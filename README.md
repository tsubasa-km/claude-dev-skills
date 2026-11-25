# dev-skills

アプリ開発の進め方をまとめた Claude 用のスキル集。Claude Code のプラグインマーケットプレイスとして使え、claude.ai にもアップロードできる。

## 中身

| プラグイン | スキル | 内容 |
|---|---|---|
| `dev-workflow` | `stack-selection` | 要件を整理し、UI ライブラリ・フレームワーク・使えるスキルを調べて提案し、決定を残す。既定はライブラリを積極的に使い、重い処理は事前計算 |
| | `doc-driven` | 根拠は `docs/`(OKF v0.3)、仕様は `SPEC.md`。コードより先に文書を直し、分かった事実を書き戻す。人の確認なしに `verified` を付けない |
| | `pdca` | 変更ごとに Plan(期待する結果と確かめ方)→ Do → Check(公式値・実画面・定義書と自分で照合)→ Act(文書とテストに戻す)。振り返りの手順も含む |
| `okf` | `okf-generate`, `okf-consume` | OKF バンドルの作成・検証と参照。Google 公開のスキルを無改変で同梱(Apache-2.0、[NOTICE](plugins/okf/NOTICE.md)) |

`doc-driven` は OKF の書き方と検証を `okf-generate` に任せるので、2つのプラグインを一緒に入れる。

## Claude Code で使う

非公開リポジトリなので、先に各マシンで GitHub に git で接続できるようにしておく(SSH 鍵、または `gh auth login` と `gh auth setup-git`)。

```sh
claude plugin marketplace add tsubasa-km/claude-dev-skills
claude plugin install dev-workflow@dev-skills
claude plugin install okf@dev-skills
```

github.com の SSH 鍵が別のアカウントに結びついているマシンでは、個人用の鍵を使う SSH の別名(例: `~/.ssh/config` の `Host private.github.com`)を URL で指定する。

```sh
claude plugin marketplace add git@private.github.com:tsubasa-km/claude-dev-skills.git
```

セッション内なら `/plugin marketplace add tsubasa-km/claude-dev-skills` と `/plugin install dev-workflow@dev-skills`。スキルは `dev-workflow:pdca` のように呼べる。

更新を自動で受け取るには、`/plugin` の Marketplaces で `dev-skills` の自動更新を有効にする(手動なら `claude plugin marketplace update dev-skills`)。更新を配るときは `plugin.json` の `version` を上げる。

## claude.ai で使う(どのマシンの Claude Code にも同期される)

```sh
./scripts/build-claudeai-zips.sh   # dist/<スキル名>.zip を作る
```

claude.ai の Customize > Skills で zip をアップロードして有効にする。同じアカウントでログインした Claude Code(ターミナル)にも `~/.claude/skills/synced/` として同期され、クラウドのセッションでも使える。

- claude.ai と Claude Code のプラグインの両方で同じスキルを入れると二重に見えるので、マシンではどちらか一方にする。
- claude.ai が受け付ける SKILL.md の先頭の項目は `name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools` だけ。ここのスキルはこの範囲で書いている。

## 編集するとき

- スキルの本文は `plugins/<プラグイン>/skills/<スキル>/SKILL.md`。
- 変更後は `claude plugin validate .` を通し、`version` を上げてから push する。
- 試すだけなら `claude --plugin-dir plugins/dev-workflow --plugin-dir plugins/okf` で、その場限りで読み込める。
