# 添加用户安装的软件
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# git branch in prompt
function git_branch {
branch="`git branch 2>/dev/null | grep "^\*" | sed -e "s/^\*\ //"`"
    if [ "${branch}" != "" ]; then
        if [ "${branch}" = "(no branch)" ]; then
            branch="(`git rev-parse --short HEAD`...)"
        fi
        echo " ($branch)"
    fi
}

# 命令提示符的颜色变量
GREEN='\[\033[01;32m\]'
BLUE='\[\033[01;34m\]'
YELLOW='\[\033[01;33m\]'
RESET='\[\033[00m\]'

# 给 debian 的命令提示符加上 git 分支
PS1="${debian_chroot:+($debian_chroot)}${GREEN}\u@\h${RESET}:${BLUE}\w${YELLOW}\$(git_branch)${RESET}\$ "

# 覆盖前面的 xterm
case "$TERM" in
    xterm*|rxvt*) PS1="\[\e]0;\u@\h: \w\a\]$PS1";;
esac

# 自动激活 python 虚拟环境
function auto_venv {
    if [[ -n "$VIRTUAL_ENV" && "$VIRTUAL_ENV" -ef "${PWD}/.venv" ]]; then
        return
    fi

    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/.venv/bin/activate" ]]; then
            source "$dir/.venv/bin/activate"
            return
        fi
        dir=$(dirname "$dir")
    done

    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
    fi
}

PROMPT_COMMAND="auto_venv${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

# export https_proxy='http://10.24.14.174:1235'

# alias
alias ll='ls -lha'
alias src='source ~/.bashrc'
alias ssha='eval "$(ssh-agent -s)"'

# windows
# alias exp='/mnt/c/Windows/explorer.exe'

# python
alias ipy='ipython'
alias pyt='python -m unittest'
alias venv='source .venv/bin/activate'

# vim
export EDITOR=vim
alias vc='vim ~/.vim/vimrc'
alias vb='vim ~/.bashrc'
alias vt='vim ~/.tmux.conf'
# alias vw='vim /mnt/c/Users/zhajiman/.wezterm.lua'

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

# line_profiler
export LINE_PROFILE=1

# kubectl
alias k=kubectl
if command -v kubectl &> /dev/null; then
    source <(kubectl completion bash)
    complete -o default -F __start_kubectl k
fi

# oss
export OSS_ACCESS_KEY_ID=''
export OSS_ACCESS_KEY_SECRET=''

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pi
alias pin='pi --no-session'
alias pic='pi -c'
alias pir='pi -r'

# zhipu
export ZAI_API_KEY=''
export MY_API_KEY="$ZAI_API_KEY"
export ZAI_ENABLED_MODULES=search,reader,zread
