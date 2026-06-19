# manuscript/ — 論文ビルドの標準手順

論文原稿（LaTeX）のビルドと**機械検証**の雛形。venue ごとに原稿一式
（`main.tex` / クラス・スタイル / `references.bib`）を置き、ここの `Makefile` と
`latexcheck.sh` で「ビルド→検証」を一手で回す。

## 使い方

```bash
make          # ビルド（latex → bibtex → latex ×2 → PDF）
make check    # ビルド後に機械検証（PASS/WARN/FAIL を印字、FAIL があれば exit 1）
make clean    # 中間ファイル削除
```

投稿前は必ず `make check` を通す。「毎回目視で確認」していた項目を自動化したもの：

| 区分 | 検出内容 |
|---|---|
| FAIL | TeX エラー（`! `）／未定義引用（キー名表示）／未解決 `\ref`/`\label`／図ファイル未検出／bibtex エラー |
| WARN | overfull hbox（pt 閾値超）／偶数頁違反（`--even` 時）／相互参照の再実行要求／bibtex 警告 |

## venue ごとの切り替え（Makefile 上部の変数のみ）

| venue | LATEX | BIBTEX | CHECKOPTS |
|---|---|---|---|
| IPSJ / SIGMUS | `platex` | `pbibtex` | （空） |
| JSMPC（APA・apacite） | `platex` | `upbibtex` | `--even` |
| lualatex 系 | `lualatex` | `upbibtex`/`biber` | （pdf 規則の調整要） |

`latexcheck.sh` はログ文言ベースなのでエンジン非依存。`--overfull PT` で
overfull の WARN 閾値を変更できる（既定 2.0pt）。

## 注意

- ビルド成果物（`*.aux *.log *.dvi *.bbl *.pdf` 等）は `.gitignore` 済みの想定。
- `references.bib` を別ディレクトリで一元管理する場合は symlink で取り込む
  （書誌は単一ソース、APA 等の体裁は `.bst` 側で吸収）。
- macOS の `/bin/sh` は bash 3.2。`latexcheck.sh` は多バイト直後の変数展開を
  `${var}` で囲って 3.2 のバグを回避済み（編集時は踏襲すること）。
