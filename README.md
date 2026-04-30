# research-template

個人研究・研究室プロジェクト・共同研究を想定した、研究プロジェクトを「迷わず進める」ためのテンプレートです。文脈・判断・データ取扱い・作業・成果物を分離し、AI/人間が共通の前提で作業できるようにします。

## 使い方（GitHub Template Repository想定）
- このリポジトリを Template として利用し、新しい研究プロジェクトを作成します。
- **VSCode は必ず `workspace.code-workspace` 経由で開きます**（フォルダ直開きしない）。AI コーディングツール（Claude Code 等）の履歴がワークスペース識別子に紐づくため、最初からワークスペースで開くと履歴が分断されません。後日 multi-root に拡張しても識別子は変わりません。
- まず `00_context/context.md` を埋めて、研究の目的・範囲・制約を固定します。
- 重要な方針変更は `00_context/decisions.md` に記録します。
- データの取扱い（PII/機微情報/公開範囲）は `00_admin/data_policy.md` に明文化します。
- 実行環境・再現手順は `00_admin/environment.md` に記録します。

## ディレクトリ構成

```text
research-template/
├── README.md
├── LICENSE
├── .gitignore
├── workspace.code-workspace           # VSCode は必ずこれ経由で開く
├── CLAUDE.md                          # AI設定: Claude Code 向け指示
├── .github/
│   └── copilot-instructions.md        # AI設定: GitHub Copilot 向け指示
├── 00_context/
│   ├── context.md        # 最重要：研究の文脈（AI/人間共通）
│   └── decisions.md      # 重要な判断・方針変更のログ
├── 00_admin/
│   ├── data_policy.md    # データ・個人情報・公開範囲
│   ├── environment.md    # 実行環境・再現性情報
│   ├── checklist.md      # 実行・提出チェック
│   └── links.md          # 外部リンク（Drive, Notion, Issue等）
├── 01_data/
│   ├── raw/              # 原データ（編集しない）
│   ├── interim/          # 前処理の途中生成物
│   ├── processed/        # 分析に使う最終形
│   └── schema/           # データ辞書・スキーマ定義
├── 02_work/
│   ├── prep/             # 前処理・抽出・整形
│   ├── analysis/         # EDA・統計・モデル・SQL・Notebook
│   └── src/              # 共通ユーティリティ・関数定義
├── 03_results/
│   ├── reports/          # 分析に紐づく結果報告（データ・図表を伴う）
│   └── exports/          # 共有用のCSV/画像などの出力
└── 04_docs/
    ├── paper/
    │   ├── manuscript/
    │   ├── figures/
    │   ├── tables/
    │   └── references.bib
    ├── literature/       # 先行研究の精読メモ（references.bib と1対1対応）
    │   ├── README.md
    │   ├── _template.md
    │   └── _papers/      # PDF（.gitignore 済）
    ├── slides/
    └── notes/            # 分析に紐づかない記録（調査メモ・議事録・アイデア）
```

## 各フォルダの意図（運用ルール）

### 00_context/（最優先）
- `context.md`: 研究の「前提」を1つに集約します（目的、RQ、範囲、制約、成功基準）。
- `decisions.md`: 重要な判断を、理由と影響範囲つきで残します。

### 00_admin/
- `data_policy.md`: データ分類・アクセス権限・匿名化・公開方針などを定義します。
- `environment.md`: 実行環境・依存ライブラリ・再現手順を記録します。
- `checklist.md`: 実行・提出の抜け漏れ防止用。
- `links.md`: 外部リンクを散逸させずに集約します。

### 01_data/
- `raw/`: 取得した原データ（原則として編集しない）。
- `interim/`: 前処理の途中生成物。
- `processed/`: 分析に直接使う最終形。
- `schema/`: データ辞書・カラム定義・スキーマ情報。バージョン管理対象として、データの構造を記録します。

### 02_work/
- `prep/`: 前処理・抽出・整形のスクリプト/ノート。
- `analysis/`: EDA・統計・モデル・SQL・Notebook等。分析の単位で整理します。
- `src/`: 複数のスクリプトから参照する共通関数・設定ファイル。

### 03_results/
- `reports/`: 分析に紐づく結果報告（データや図表を伴う短報・レポート）。
- `exports/`: 共有用のCSV/画像などの出力（自動生成物を想定）。

### 04_docs/
- `paper/`: 自分が書く論文の原稿・図・表・参考文献（`references.bib`）を分離して管理。
- `literature/`: 先行研究の精読メモを `<bibkey>.md` の単位で蓄積（`paper/references.bib` の各エントリと1対1対応）。PDF は `_papers/` に置き `.gitignore` 済。
- `slides/`: 発表資料。
- `notes/`: 分析に紐づかない記録（調査メモ・議事録・落ちたアイデア）。

> **`paper/` と `literature/` の違い:**
> `paper/` は **自分が書く** 1 本の論文用（単数）、`literature/` は **他人が書いた** 論文の精読メモ集（集合）です。

> **`03_results/reports/` と `04_docs/notes/` の違い:**
> `reports/` は分析結果やデータに基づく報告文書、`notes/` は調査段階のメモや議事録など分析と直接紐づかない記録です。

## AI設定ファイルの設計方針

本テンプレートでは、**研究の文脈は `00_context/` に一元管理**し、各AIツールの設定ファイルは `00_context/` への**薄いポインタ**として機能させます。

```text
CLAUDE.md / .github/copilot-instructions.md
  └─→ 参照: 00_context/context.md（研究の前提）
  └─→ 参照: 00_context/decisions.md（判断履歴）
  └─→ 参照: 00_admin/data_policy.md（データ方針）
```

この構成により：
- **情報の二重管理を防止** — 研究の前提は `00_context/` だけを更新すればよい
- **ツール非依存** — AIツールが変わっても `00_context/` はそのまま使える
- **人間にも読める** — `00_context/` はAI設定ではなく、人間向けの研究文書

### デフォルトで含まれるAI設定ファイル

| ファイル | 対象ツール |
|---|---|
| `CLAUDE.md` | Claude Code |
| `.github/copilot-instructions.md` | GitHub Copilot |

### 他のAIツールを使う場合

同様のポインタファイルを作成してください。

| ツール | 設定ファイル |
|---|---|
| Cursor | `.cursor/rules/*.mdc` |
| Windsurf | `.windsurfrules` |

## 運用フロー

本テンプレートでは、研究の前提・判断・AI利用を分離して管理します。

1. **研究開始時** — `00_context/context.md` を埋めて前提を固定する
2. **AI利用時** — AIツールは設定ファイル経由で `00_context/` を自動参照する
3. **方針変更時** — `00_context/decisions.md` に判断を記録する
4. **データ取扱い** — `00_admin/data_policy.md` に従う
5. **節目・提出前** — `00_admin/checklist.md` で確認する

## 備考
- Gitで空フォルダを保持するため、各フォルダに `.gitkeep` を置いています。
- `.gitignore` はデフォルトで `01_data/` や `03_results/exports/` を無視する設定にしています（プロジェクトの性質に応じて調整してください）。
- `01_data/schema/` はバージョン管理対象です（`.gitignore` の対象外）。
- `analysis/` には SQL・Notebook・スクリプトを混在させて構いません（分析の単位で整理することを優先します）。
- 本テンプレートは MIT License で公開しています。
