if ($env:WT_Session) {
  Invoke-Expression (oh-my-posh --init --shell pwsh --config "$(scoop prefix oh-my-posh)/themes/default.omp.json")
}
