# research-template

個人研究・研究室プロジェクト・共同研究を想定した、研究プロジェクトを「迷わず進める」ためのテンプレートです。文脈・判断・データ取扱い・作業・成果物を分離し、AI/人間が共通の前提で作業できるようにします。

## 使い方（GitHub Template Repository想定）
- このリポジトリを Template として利用し、新しい研究プロジェクトを作成します。
- まず `00_context/context.md` を埋めて、研究の目的・範囲・制約を固定します。
- 重要な方針変更は `00_context/decisions.md` に記録します。
- データの取扱い（PII/機微情報/公開範囲）は `00_admin/data_policy.md` に明文化します。

※ 本テンプレートでは、
- `03_results/` は「分析・実験の結果（中間成果含む）」
- `04_docs/` は「対外的な成果物（論文・発表資料・記録）」
として区別します。

## ディレクトリ構成

```text
research-template/
├── README.md
├── .gitignore
├── 00_context/
│   ├── context.md        # 最重要：研究の文脈（AI/人間共通）
│   ├── decisions.md      # 重要な判断・方針変更のログ
│   └── prompts.md        # 再利用するプロンプト断片
├── 00_admin/
│   ├── data_policy.md    # データ・個人情報・公開範囲
│   ├── checklist.md      # 実行・提出チェック
│   └── links.md          # 外部リンク（Drive, Notion, Issue等）
├── 01_data/
│   ├── raw/
│   ├── interim/
│   └── processed/
├── 02_work/
│   ├── prep/             # 前処理・抽出・整形
│   └── analysis/         # EDA・統計・モデル・SQL・Notebook
├── 03_results/
│   ├── reports/
│   └── exports/
└── 04_docs/
    ├── paper/
    │   ├── manuscript/
    │   ├── figures/
    │   └── tables/
    ├── slides/
    └── notes/
```

## 各フォルダの意図（運用ルール）

### 00_context/（最優先）
- `context.md`: 研究の「前提」を1つに集約します（目的、RQ、範囲、制約、成功基準）。
- `decisions.md`: 重要な判断を、理由と影響範囲つきで残します。
- `prompts.md`: 繰り返し使うプロンプト断片を蓄積します。

### 00_admin/
- `data_policy.md`: データ分類・アクセス権限・匿名化・公開方針などを定義します。
- `checklist.md`: 実行・提出の抜け漏れ防止用。
- `links.md`: 外部リンクを散逸させずに集約します。

### 01_data/
- `raw/`: 取得した原データ（原則として編集しない）。
- `interim/`: 前処理の途中生成物。
- `processed/`: 分析に直接使う最終形。

### 02_work/
- `prep/`: 前処理・抽出・整形のスクリプト/ノート。
- `analysis/`: EDA・統計・モデル・SQL・Notebook等。

### 03_results/
- `reports/`: 共有する文章（メモ/短報/レポート）
- `exports/`: 共有用のCSV/画像などの出力（自動生成物を想定）

### 04_docs/
- `paper/`: 論文原稿・図・表を分離して管理。
- `slides/`: 発表資料。
- `notes/`: 調査メモ・議事録・落ちたアイデア。

## 運用フロー（AI利用を含む）

本テンプレートでは，研究の前提・判断・AI利用を分離して管理します．  
研究開始時および AI を利用する際は **`00_context/context.md`** を必ず参照し，前提を共有してください．  
研究方針や解釈に影響する判断は **`00_context/decisions.md`** に記録し，再利用可能なプロンプトは **`00_context/prompts.md`** に蓄積します．  
データの取扱いは **`00_admin/data_policy.md`** に従い，研究の節目や提出前には **`00_admin/checklist.md`** を用いて確認します．

## 備考
- Gitで空フォルダを保持するため、各フォルダに `.gitkeep` を置いています。
- `.gitignore` はデフォルトで `01_data/` や `03_results/exports/` を無視する設定にしています（プロジェクトの性質に応じて調整してください）。
- analysis/ には SQL・Notebook・スクリプトを混在させて構いません（分析の単位で整理することを優先します）。
