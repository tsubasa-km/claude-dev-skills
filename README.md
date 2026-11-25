# dev-skills

アプリ開発の進め方をまとめた Claude 用のスキル集。Claude Code / claude.ai のプラグインマーケットプレイスとして使える。

## 中身

| プラグイン | スキル | 内容 |
|---|---|---|
| `dev-workflow` | `stack-selection` | 要件を整理し、UI ライブラリ・フレームワーク・使えるスキルを調べて提案し、決定を残す。既定はライブラリを積極的に使い、重い処理は事前計算 |
| | `doc-driven` | 根拠は `docs/`(OKF v0.3)、仕様は `SPEC.md`。コードより先に文書を直し、分かった事実を書き戻す。人の確認なしに `verified` を付けない |
| | `pdca` | 変更ごとに Plan(期待する結果と確かめ方)→ Do → Check(公式値・実画面・定義書と自分で照合)→ Act(文書とテストに戻す)。振り返りの手順も含む |
| `okf` | `okf-generate`, `okf-consume` | OKF バンドルの作成・検証と参照。Google 公開のスキルを無改変で同梱(Apache-2.0、[NOTICE](plugins/okf/NOTICE.md)) |

`doc-driven` は OKF の書き方と検証を `okf-generate` に任せるので、2つのプラグインを一緒に入れる。

## 使い方(おすすめ: claude.ai から GitHub を参照する)

公開リポジトリなので、claude.ai にマーケットプレイスとして登録すれば、push した内容がそのまま届く。

1. claude.ai の左のサイドバーで **Customize** → **Plugins** → **Add** → **Add marketplace** → **Add from a repository** を選び、`tsubasa-km/claude-dev-skills` を入れる。
2. 一覧に出る `dev-workflow` と `okf` を入れる。
3. 同じアカウントでログインした Claude Code(v2.1.273 以降)は、起動のたびに claude.ai のプラグインを同期する。どのマシンでも追加の設定は要らない。

更新は、このリポジトリに push するだけで配られる(`plugin.json` に `version` を書いていないので、コミットごとに新しい版として扱われる)。

- claude.ai のプラグインと、zip のアップロードや手元の `claude plugin install` を併用すると同じスキルが二重に見えるので、どれか1つにする。

## ほかの使い方

**Claude Code だけで使う**(マシンごとに1回):

```sh
claude plugin marketplace add tsubasa-km/claude-dev-skills
claude plugin install dev-workflow@dev-skills
claude plugin install okf@dev-skills
```

自動で更新するには、`/plugin` の Marketplaces で `dev-skills` の自動更新を有効にする。

**claude.ai にスキルとして直接アップロードする**: `./scripts/build-claudeai-zips.sh` で `dist/<スキル名>.zip` を作り、Customize > Skills からアップロードする。更新のたびに上げ直しが要る。

claude.ai が受け付ける SKILL.md の先頭の項目は `name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools` だけ。ここのスキルはこの範囲で書いている。

## 編集するとき

- スキルの本文は `plugins/<プラグイン>/skills/<スキル>/SKILL.md`。
- 変更後は `claude plugin validate .` を通してから push する。
- 試すだけなら `claude --plugin-dir plugins/dev-workflow --plugin-dir plugins/okf` で、その場限りで読み込める。
