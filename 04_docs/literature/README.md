# literature/ — 先行研究の精読メモ

自分が読んだ／読む予定の文献を、PDF とは別に **構造化されたメモ**として蓄積する場所です。

## 04_docs/paper/ との違い

| ディレクトリ | 役割 | 単複 |
|---|---|---|
| `04_docs/paper/` | **自分が書く** 1 本の論文（manuscript / figures / tables / references.bib） | 単数 |
| `04_docs/literature/` | **他人が書いた** 論文の精読メモを束ねる | 集合 |

`paper/references.bib` の各エントリと、本ディレクトリの `<bibkey>.md` が 1 対 1 で対応するイメージです。

## 構成

```
literature/
├── README.md         # このファイル（読書ステータス一覧を併記）
├── _template.md      # 精読メモのテンプレート
├── _papers/          # 文献 PDF（gitignore 対象、ローカルのみ）
└── <bibkey>.md       # 各文献の精読メモ
```

- `<bibkey>` は `references.bib` のキーと揃える（例：`fletcher1975.md`）
- PDF は `_papers/<bibkey>.pdf` に置く（リポジトリには含めない）
- 著作権上の理由から PDF は `.gitignore` 済

## 精読メモの書き方

`_template.md` をコピーして使います。フロントマターで著者・年・出典・状態を構造化することで、後から横断検索しやすくなります。

`status` は以下のいずれか：

- `queued` — 入手済だが未読
- `reading` — 読書中
- `read` — 読了、メモ充足
- `skim` — 流し読みのみ

## 文献ステータス一覧

精読が進んだら以下のテーブルを更新します（手動）。

| bibkey | 著者・年 | タイトル | status | 自研究との関係 |
|---|---|---|---|---|
| _未記入_ | | | | |
