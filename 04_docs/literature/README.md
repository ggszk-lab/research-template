# literature/ — 先行研究まわりの作業

先行研究に関わる作業は3種類あり、目的も成果物も異なる。混同しないこと。

| 活動 | 何をするか | 成果物 | 進め方 |
|---|---|---|---|
| ① サーベイ | 領域を掃く／特定の新規性主張の prior art を確認する | `04_docs/notes/lit_survey_<date>.md` | `/lit-survey` スキル・`_survey_template.md` |
| ② 精読メモ | 文献1本を精読し構造化して残す | `04_docs/literature/<bibkey>.md` | `_template.md` をコピー |
| ③ 引用検証 | 完成原稿の引用を書誌・主張レベルで照合する | `04_docs/notes/literature_verification.md` | `/verify-citations` スキル |

このディレクトリは主に **② 精読メモ**を束ねる場所。①③のノートは `04_docs/notes/` に置くが、雛形と進め方はここに集約する。

## 04_docs/paper/ との違い

| ディレクトリ | 役割 | 単複 |
|---|---|---|
| `04_docs/paper/` | **自分が書く** 1 本の論文（manuscript / figures / tables / references.bib） | 単数 |
| `04_docs/literature/` | **他人が書いた** 論文の精読メモを束ねる | 集合 |

`paper/references.bib` の各エントリと、本ディレクトリの `<bibkey>.md` が 1 対 1 で対応するイメージです。

## 構成

```
literature/
├── README.md          # このファイル
├── _template.md       # ② 精読メモのテンプレート
├── _survey_template.md # ① サーベイノートのテンプレート
├── _papers/           # 文献 PDF（gitignore 対象、ローカルのみ）
└── <bibkey>.md        # 各文献の精読メモ
```

- `<bibkey>` は `references.bib` のキーと揃える（例：`fletcher1975.md`）
- PDF は `_papers/<bibkey>.pdf` に置く（リポジトリには含めない）
- 著作権上の理由から PDF は `.gitignore` 済

## ② 精読メモの書き方

`_template.md` をコピーして使います。フロントマターで著者・年・出典・状態を構造化することで、後から横断検索しやすくなります。

`status` は以下のいずれか：

- `queued` — 入手済だが未読
- `reading` — 読書中
- `read` — 読了、メモ充足
- `skim` — 流し読みのみ

## ① サーベイ / ③ 引用検証

- **サーベイ**は `_survey_template.md` を雛形に `04_docs/notes/lit_survey_<date>.md` を作る。広域／的撃ちの2タイプがある。詳細は `/lit-survey` スキル。
- **引用検証**は完成原稿の引用照合。サーベイとは別活動。詳細は `/verify-citations` スキル。
- いずれも LLM＋Web 検索ベースの調査は暫定であり、書誌情報は原著で検証する。

## 文献ステータス一覧

精読が進んだら以下のテーブルを更新します（手動）。

| bibkey | 著者・年 | タイトル | status | 自研究との関係 |
|---|---|---|---|---|
| _未記入_ | | | | |
