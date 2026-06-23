# CleanPSAlias

実行時に設定されているエイリアスについて、同名のコマンドがPowerShell外に存在する場合、そのエイリアスを削除します。`curl.exe`を使う場合や、[coreutils](https://github.com/microsoft/coreutils)を導入した場合などに便利です。

エイリアスは[スクリプトでは使用しないよう求められている](https://learn.microsoft.com/powershell/scripting/learn/shell/using-aliases#dont-use-aliases-in-scripts)ため、まともなスクリプトであればこれにより壊れることはありません。

## 使い方

1. `Test.bat`を実行
1. 実行ポリシーを「RemoteSigned」に設定するか否か答える。設定しなくても続行できるが、プロファイル機能を使うには設定する必要がある
1. 削除されるエイリアスが表示される
1. 削除された状態のPowerShellが起動する。効果はこのセッション内のみ
1. 良さそうなら`.\AddToProfile.ps1`を実行すると、プロファイルに追加され、PowerShell起動時に自動で削除されるようになる

`. "path\to\AddToProfile.ps1"`の形で登録されるので、`AddToProfile.ps1`を移動したり削除したりすると機能しなくなります。

## 標準で削除されるエイリアス

| エイリアス | 標準定義 | 備考 |
| ---------- | -------- | ---- |
| `curl` | `Invoke-WebRequest` | 本物の`curl.exe`がある |
| `fc` | `Format-Custom` | 用途の異なる`fc.exe`(ファイル比較)がある |
| `sc` | `Set-Content` | 用途の異なる`sc.exe`(サービス管理)がある |
| `sort` | `Sort-Object` | 用途の微妙に異なる`sort.exe`がある |
| `where` | `Where-Object` | 用途の異なる`where.exe`がある |