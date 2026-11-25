---
name: doc-driven
description: Document-driven development with an OKF (Open Knowledge Format) bundle in docs/ for evidence (data sources, metrics, methods, decisions) and SPEC.md for the app spec. Docs are updated before code, facts learned during implementation are written back, and nothing is marked verified without human confirmation. Use when starting a new app or data project, before implementing a change, or when the user asks to keep docs, sources, or specs in sync with the code.
metadata:
  version: "0.1.0"
---

# ドキュメント駆動開発

根拠は `docs/`(OKF バンドル)、アプリの仕様は `SPEC.md` に書き、**コードより先に**更新する。OKF の書き方と検証は `okf-generate` スキル(同じマーケットプレイスの `okf` プラグイン)に従う。

## 置き場所

| ファイル | 書くこと |
|---|---|
| `docs/`(OKF v0.3) | 根拠。`datasets/`(出典・ライセンス・取得日・限界)、`metrics/`(指標の定義と式)、`methods/`(手法)、`decisions/`(意思決定と理由)、`references/`(データ形式など)、`log.md`(分かったことの記録) |
| `SPEC.md` | アプリの仕様。機能(F1, F2…)、画面、**数値つきの受け入れ条件**、限界の表示 |
| `README.md` | 概要、再現手順(前処理→ビルド→公開)、データ出典の表、未達事項 |

## 始めるとき

1. 要件が曖昧なら、先に質問して詰める(`grilling` スキルがあれば使う)。
2. `okf-generate` の手順で `docs/` を作る。最低限: ルートの `index.md`、使うデータごとの `datasets/*.md`、主要な指標の `metrics/*.md`、`log.md`。
3. `SPEC.md` を書き、**ユーザーの承認を得てから**実装を始める。

## 変更するたびに

1. **先に書く**: 変更に関わる `docs/` と `SPEC.md` を直す(新しいデータ・指標・手法・判断は、それぞれのページを足す)。
2. 実装する。
3. **書き戻す**: 実装やデータの確認で分かった事実(実際の件数、データの癖、想定と違った点)を該当ページに反映し、`docs/log.md` に日付つきで追記する。
4. **検証する**: コミット前に OKF の検証を通す。`okf-generate` の `scripts/validate.py --strict docs` を使う(例: `uv run --no-project --with pyyaml python3 <okf-generate のディレクトリ>/scripts/validate.py --strict docs`)。
5. `SPEC.md` の受け入れ条件の数字と、テストの期待値を一致させる。

## 守ること

- **出典を読んでから書く。** データの意味(何が 0 か、何が含まれないか、境界の扱い)は、提供元の定義書・作成方法の資料で確かめてから説明する。確かめられないことは「推測」と明記する。
- **実データを使い、架空のデータを実績として扱わない。** サンプルや仮の値を使うときは、画面と文書の両方にそう書く。
- **限界を隠さない。** 分析に含まれないもの(例: 対象外の交通手段、住民以外の人口)を `docs/` と画面と README に書く。
- **人の確認がない内容に `verified` を付けない。** 付けるのは、ユーザーが内容を確かめたと明言したときだけ。
- 文書の数字は、生成物(meta.json やテスト)から写す。手で丸めた数字を別々に書かない。
