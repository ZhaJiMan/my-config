# 添加用户安装的软件
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# export https_proxy='http://10.24.14.174:1235'

alias ll='ls -lha'
alias src='source ~/.bashrc'
alias venv='source .venv/bin/activate'
alias ssha='eval "$(ssh-agent -s)"'
alias ipy='ipython'
alias pyt='python -m unittest'
# alias exp='/mnt/c/Windows/explorer.exe'

# vim
export EDITOR=vim
alias vc='vim ~/.vim/vimrc'
alias vb='vim ~/.bashrc'
alias vt='vim ~/.tmux.conf'
# alias vw='vim /mnt/c/Users/USER/.wezterm.lua'

# uv
if command -v uv &> /dev/null; then
    eval "$(uv generate-shell-completion bash)"
    eval "$(uvx --generate-shell-completion bash)"
fi

# yazi
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# fzf
if command -v fzf &> /dev/null; then
    eval "$(fzf --bash)"
fi

# ruff
alias rf='ruff format'
alias rc='ruff check'
rfc() { ruff format "$@" && ruff check "$@"; }
rfcc() { ruff format "$@" && ruff check --fix "$@"; }
