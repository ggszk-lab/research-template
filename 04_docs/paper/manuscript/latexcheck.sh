#!/bin/sh
# =====================================================================
# latexcheck.sh — LaTeX ビルドの機械的健全性チェック（venue 非依存）
#
# ビルド後の <target>.log / <target>.blg を解析し、PASS / WARN / FAIL を
# 印字する。FAIL が 1 件でもあれば終了コード 1（make / CI を落とせる）。
# エンジン（platex / uplatex / lualatex）に依存しないログ文言で判定する。
#
# Usage:
#   latexcheck.sh <target-basename> [--even] [--overfull PT]
#     <target-basename>  例: main （main.log / main.blg を見る）
#     --even             ページ数が偶数でなければ WARN（JSMPC 等の偶数頁制約）
#     --overfull PT      overfull hbox をこの pt 超で WARN（既定 2.0）
#
# 判定:
#   FAIL  未定義引用 / 未解決参照 / 図ファイル未検出 / TeX エラー / bibtex エラー
#   WARN  overfull 超過 / 偶数頁違反 / 「Rerun」要求 / bibtex 警告
#   PASS  上記いずれも無し
# =====================================================================

TARGET=""
EVEN=0
OVERFULL_PT="2.0"

while [ $# -gt 0 ]; do
  case "$1" in
    --even) EVEN=1; shift ;;
    --overfull) OVERFULL_PT="$2"; shift 2 ;;
    *) TARGET="$1"; shift ;;
  esac
done

if [ -z "$TARGET" ]; then
  echo "usage: latexcheck.sh <target-basename> [--even] [--overfull PT]" >&2
  exit 2
fi

LOG="$TARGET.log"
BLG="$TARGET.blg"

if [ ! -f "$LOG" ]; then
  echo "FAIL  $LOG が無い（先に make でビルドすること）"
  exit 1
fi

fail=0
warn=0
say_pass() { printf '[PASS] %s\n' "$1"; }
say_warn() { printf '[WARN] %s\n' "$1"; warn=$((warn + 1)); }
say_fail() { printf '[FAIL] %s\n' "$1"; fail=$((fail + 1)); }

# grep -c は一致 0 でも "0" を表示し exit 1。値だけ安全に取り出す。
# パターン中の LaTeX 引用符 (backtick) は . で代用し、シェル展開を避ける。
cnt() {
  c=$(grep -aEc "$1" "$2" 2>/dev/null)
  [ -n "$c" ] || c=0
  echo "$c"
}

echo "=== latexcheck: $TARGET ==="

# --- TeX エラー（! で始まる行） --------------------------------------
errs=$(cnt '^! ' "$LOG")
if [ "$errs" -gt 0 ]; then
  say_fail "TeX エラー $errs 件（ログの '! ' 行を確認）"
  grep -aE '^! ' "$LOG" | head -5 | sed 's/^/        /'
else
  say_pass "TeX エラーなし"
fi

# --- 未定義引用（Citation `key' ... undefined） ----------------------
undef_cite=$(grep -aoE "Citation .[^']+' .*undefined" "$LOG" 2>/dev/null \
             | sed -E "s/^Citation .//; s/'.*//" | sort -u)
if [ -n "$undef_cite" ]; then
  n=$(printf '%s\n' "$undef_cite" | grep -c .)
  say_fail "未定義引用 $n 件: $(printf '%s ' $undef_cite)"
else
  say_pass "未定義引用なし"
fi

# --- 未解決参照 ------------------------------------------------------
ref_undef=$(cnt "There were undefined references" "$LOG")
ref_undef2=$(cnt "Reference .[^']+' on page .* undefined" "$LOG")
if [ "$ref_undef" -gt 0 ] || [ "$ref_undef2" -gt 0 ]; then
  say_fail "未解決の \\ref / \\label がある"
else
  say_pass "参照（ref/label）解決済み"
fi

# --- 再実行要求 ------------------------------------------------------
rerun=$(cnt "Rerun to get|Label\(s\) may have changed|Citation\(s\) may have changed" "$LOG")
if [ "$rerun" -gt 0 ]; then
  say_warn "相互参照/引用が未確定（make をもう一度回すと解消する場合あり）"
fi

# --- 図ファイル未検出（File `x' not found） -------------------------
missing=$(grep -aoE "File .[^']+' not found" "$LOG" 2>/dev/null \
          | sed -E "s/^File .//; s/' not found//" | sort -u)
if [ -n "$missing" ]; then
  say_fail "ファイル未検出: $(printf '%s; ' $missing)"
else
  say_pass "graphics ファイル検出 OK"
fi

# --- overfull hbox ---------------------------------------------------
of_count=$(cnt 'Overfull \\hbox' "$LOG")
if [ "$of_count" -gt 0 ]; then
  of_max=$(grep -aoE 'Overfull \\hbox \([0-9]+\.[0-9]+pt' "$LOG" \
           | grep -oE '[0-9]+\.[0-9]+' | sort -gr | head -1)
  [ -n "$of_max" ] || of_max=0
  over=$(awk -v a="$of_max" -v b="$OVERFULL_PT" 'BEGIN{print (a>b)?1:0}')
  if [ "$over" = "1" ]; then
    say_warn "overfull hbox $of_count 件（最大 ${of_max}pt > ${OVERFULL_PT}pt）"
  else
    say_pass "overfull hbox $of_count 件（最大 ${of_max}pt、閾値内）"
  fi
else
  say_pass "overfull hbox なし"
fi

# --- bibtex（.blg） --------------------------------------------------
if [ -f "$BLG" ]; then
  bib_err=$(cnt "I couldn.t open|Aborted|error message" "$BLG")
  bib_warn=$(cnt "Warning--" "$BLG")
  if [ "$bib_err" -gt 0 ]; then
    say_fail "bibtex エラー $bib_err 件（$BLG を確認）"
  elif [ "$bib_warn" -gt 0 ]; then
    say_warn "bibtex 警告 $bib_warn 件（$BLG を確認）"
  else
    say_pass "bibtex 問題なし"
  fi
fi

# --- ページ数・偶奇 --------------------------------------------------
pages=$(grep -aoE "Output written on [^ ]+ \([0-9]+ page" "$LOG" \
        | grep -oE '[0-9]+ page' | grep -oE '[0-9]+' | tail -1)
[ -n "$pages" ] || pages=""
if [ -n "$pages" ]; then
  if [ "$EVEN" = "1" ] && [ $((pages % 2)) -ne 0 ]; then
    say_warn "ページ数 ${pages}（奇数。偶数頁制約あり → 末尾に白紙ページを追加）"
  elif [ "$EVEN" = "1" ]; then
    say_pass "ページ数 ${pages}（偶数 OK）"
  else
    say_pass "ページ数 $pages"
  fi
fi

echo "--- 結果: FAIL=$fail WARN=$warn ---"
[ "$fail" -gt 0 ] && exit 1
exit 0
