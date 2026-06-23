# CleanPSAlias

実行時に設定されているエイリアスと関数について、同名のコマンドがPowerShell外に存在する場合、そのエイリアスを削除します。`curl.exe`を使う場合や、[coreutils](https://github.com/microsoft/coreutils)を導入した場合などに便利です。

エイリアスは[スクリプトでは使用しないよう求められている](https://learn.microsoft.com/powershell/scripting/learn/shell/using-aliases#dont-use-aliases-in-scripts)ため、まともなスクリプトであればこれにより壊れることはありません。

関数はもしかしたら何か壊すかも……?

## 使い方

1. `TestPowerShell.bat`または`TestPwsh.bat`を実行
1. 削除されるエイリアスが表示され、削除スクリプトが作成される
1. 削除スクリプトが読み込まれた状態のPowerShellが起動する。効果はこのセッション内のみ
1. 良さそうなら`.\AddToProfile.ps1`を実行すると、プロファイルに追加され、PowerShell起動時に自動で削除スクリプトが実行されるようになる。Windows PowerShellの場合、実行ポリシーを「RemoteSigned」に設定するか否か答える。設定しなくても続行できるが、プロファイル機能を使うには設定する必要がある

削除スクリプトは`generated`フォルダ内に作成され、移動したり削除したりすると機能しなくなります。また、インストールされているコマンドが増減した場合は再度作成して反映してください。ただし、プロファイルへの追加をくり返すと重複してしまうので行わないでください。

## 標準で削除されるもの

| 名前 | 標準定義 | 備考 |
| ---------- | -------- | ---- |
| `curl` | `Invoke-WebRequest` | 本物の`curl.exe`がある。Windows PowerShellのみ |
| `fc` | `Format-Custom` | 用途の異なる`fc.exe`(ファイル比較)がある |
| `sc` | `Set-Content` | 用途の異なる`sc.exe`(サービス管理)がある。Windows PowerShellのみ |
| `sort` | `Sort-Object` | 用途の微妙に異なる`sort.exe`がある |
| `where` | `Where-Object` | 用途の異なる`where.exe`がある |
| `help` | (関数、`Get-Help`と変わらないように見える) | 用途の異なる`help.exe`がある |
| `more` | (関数) | 内部で呼ばれる`more.com`がある |

標準で被る関数はほとんどありませんが、`coreutils`を導入した場合に`mkdir`が被るため一応実装しています。