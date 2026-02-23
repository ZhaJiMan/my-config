function wsle { wsl --shutdown }

function rf { ruff format @args }
function rfc { ruff format @args; ruff check @args }
function rfcc { ruff format @args; ruff check --fix @args }

Set-Alias ipy ipython
function pyt { python -m unittest }
function venv { & .venv/Scripts/activate.ps1 }

(& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
Set-Alias base D:/programming/uv_base/.venv/Scripts/activate.ps1
