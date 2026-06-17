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

## ディレクトリ構成の概要

- `00_context/` — 研究の文脈と判断ログ（最優先で参照）
- `00_planning/` — 計画・構想ノート（Obsidian から卒業した、検討中の方向性）
- `00_admin/` — 管理情報（データポリシー・チェックリスト・外部リンク）
- `01_data/` — データ（raw → interim → processed の順に加工）
- `02_work/` — 作業ファイル（前処理・分析・共通コード）
- `03_results/` — 分析結果とその出力
- `04_docs/` — 対外的な成果物（論文・スライド・記録）

## コマンドとスキル

定型作業はコマンド・スキルにまとめてある。

プロジェクト内コマンド（`.claude/commands/`）:

- `/check-context` — context.md と decisions.md を読んで現況を要約
- `/log-decision` — 重要な判断を decisions.md に日付付きで追記
- `/new-analysis` — 日付付きの分析フォルダと README 雛形を作成
- `/update-todo` — `00_admin/todo.md` を git log・decisions.md と突き合わせて更新

論文まわり（ユーザーレベルのスキル、全研究プロジェクト共通）:

- `lit-survey` — 先行研究サーベイ（広域／的撃ち）。成果物は `04_docs/notes/lit_survey_<date>.md`
- `lit-read` — 文献の「登録」（`references.bib`・精読メモ・README 一覧の3点セット）と「精読」。成果物は `04_docs/literature/<bibkey>.md`
- `verify-citations` — 完成原稿の引用を書誌・主張レベルで照合・検証。成果物は `04_docs/notes/literature_verification.md`
- `paper-review` — 投稿前の自著原稿をセルフレビュー。成果物は `04_docs/notes/paper_review_<instance>_<date>.md`

先行研究の作業の全体像は `04_docs/literature/README.md` を参照。
