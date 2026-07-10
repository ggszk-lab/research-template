# プロジェクト指示（Claude Code 向け）

このファイルは Claude Code がプロジェクトを理解するための指示です。
研究の文脈・制約は `00_context/` に一元管理しています。

## 必読ドキュメント

作業を始める前に、以下を必ず読んでください。

- `00_context/context.md` — 研究の前提（目的・RQ・範囲・制約・成功基準）
- `00_context/decisions.md` — 重要な判断・方針変更の履歴
- `00_admin/todo.md` — 作業ダッシュボード。「次に何をするか」の入口
- `00_admin/data_policy.md` — データの取扱い・公開範囲

## 作業規約

- 不明点は推測せず「不明」と明示する
- `01_data/raw/` のファイルは編集しない（原データは不変）
- 個人情報・機微情報の生成・補完・推測は禁止
- 図表や数値を出力する場合は、根拠となるデータ・処理を明示する
- コード生成時は副作用のある処理を避け、仮のカラム名やスキーマを作らない

### 状態の正本規則（stale 防止）

- **プロジェクト全体の現況・次の一手の正本は `00_admin/todo.md` のみ**。論文ごとの投稿状態は
  `00_planning/04_paper_planning/paper_instances/` の各インスタンス冒頭が正本。
- **README（`00_planning/README.md` 含む）には状態を書かない**。README は構成の説明と
  正本へのポインタのみ。状態を二重管理すると片方が必ず stale になる（実例: 2026-07 に
  planning README の旧記述が誤った投稿判断の材料になりかけた）。
- 状態が変わったら todo.md / paper instance を**その場で**更新する（後でまとめては書かない）。

### 送信ログ規約（外部やり取り＝事実の記録）

- 投稿・presubmission inquiry・編集部/共同研究者との重要メールなど**外部とのやり取りは、
  発生したその場で** `04_docs/correspondence/<用途>_<YYYY-MM-DD>.md` に記録する
  （形式は `04_docs/correspondence/README.md` の雛形を参照。本文＋送信ログのチェックボックス）。
- **decisions.md は「判断」、correspondence は「事実」**。送った/受け取った/提出した という事実は
  correspondence 側に置き、decisions.md からリンクする。
- 投稿システムでの提出（原稿アップロード等）も同様に、整理番号・Manuscript ID・日付を
  即記録する（記録がないと「投稿したか不明」状態が生じる。2026-07 の実例あり）。

### AI 自律実行タグ（Obsidian ダッシュボード連携）

- `00_admin/todo.md` のタスクには `[auto:: yes]`（AI が自律実行してよい: 実験・分析・調査・
  ドラフト作成・検証）/ `[auto:: no]`（人間タスク: 判断・メール送信・提出操作・外部連携）を付ける。
- Obsidian vault の `Planning/research/_dashboard.md`（横断司令塔）はこのタグを読んで
  作業を派遣する。プロジェクト間の優先順位はダッシュボード側、プロジェクト内の正本はこちら。

## リポジトリ命名規約

研究は「開発本体」→「論文検証用の公開」の2リポジトリ構成になることが多い。命名は次で固定する。

- **リポジトリ名・ディレクトリ・配布名はハイフン**（`messiaen-birdsong`）。アンダースコアは使わない。
- **Python パッケージ名（`02_work/src/` 配下・`import`）はアンダースコア**（`messiaen_birdsong`）。
  pip の `foo-bar` ↔ `import foo_bar` と同じで、アンダースコアはコード側で使う。
- **開発本体と公開検証用はサフィックスで対にする**:
  - 開発本体（無印）: `<slug>`　例 `messiaen-birdsong`
  - 公開検証用（reproducibility）: `<slug>-repro`　例 `messiaen-birdsong-repro`
- 公開リポジトリ作成時は本体名に `-repro` を付けるだけ（毎回の命名で悩まない）。

## ディレクトリ構成の概要

- `00_context/` — 研究の文脈と判断ログ（最優先で参照）
- `00_planning/` — 計画・構想ノート（Obsidian から卒業した、検討中の方向性）
- `00_admin/` — 管理情報（データポリシー・チェックリスト・外部リンク）
- `01_data/` — データ（raw → interim → processed の順に加工）
- `02_work/` — 作業ファイル（前処理・分析・共通コード）
- `03_results/` — 分析結果とその出力
- `04_docs/` — 対外的な成果物（論文・スライド・記録）。`correspondence/` に外部やり取りの送信ログ

## コマンドとスキル

定型作業はコマンド・スキルにまとめてある。

プロジェクト内コマンド（`.claude/commands/`）:

- `/check-context` — context.md と decisions.md を読んで現況を要約
- `/log-decision` — 重要な判断を decisions.md に日付付きで追記
- `/new-analysis` — 日付付きの分析フォルダと README 雛形を作成
- `/update-todo` — `00_admin/todo.md` を git log・decisions.md と突き合わせて更新

論文まわり（ユーザーレベルのスキル、全研究プロジェクト共通）:

- `lit-survey` — 先行研究サーベイ（広域／的撃ち）。成果物は `04_docs/notes/lit_survey_<topic>_<date>.md`
- `lit-read` — 文献の「登録」（`references.bib`・精読メモ・README 一覧の3点セット）と「精読」。成果物は `04_docs/literature/<bibkey>.md`
- `verify-citations` — 完成原稿の引用を書誌・主張レベルで照合・検証。成果物は `04_docs/notes/literature_verification_<instance>.md`
- `paper-review` — 投稿前の自著原稿をセルフレビュー。成果物は `04_docs/notes/paper_review_<instance>_<date>.md`

先行研究の作業の全体像は `04_docs/literature/README.md` を参照。
