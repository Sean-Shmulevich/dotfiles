# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export nvimConfig="/Users/seanshmulevich/.local/share/nvim"
export GIT_EDITOR=nvim
export OPENAI_API_KEY="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"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# set default editor to Vim
export EDITOR=vim
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
#

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive copy from nvim visul mode to system clipboardcompletion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
 zstyle ':omz:update' mode reminder  # just remind me to update when it's time


# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots. e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
cat() {
    for file in "$@"; do
        if [[ $file == *.md ]]; then
            mdcat "$file"
        elif [[ $file == *.png || $file == *.pdf || $file == *.jpeg || $file == *.jpg || $file == *.webp ]]; then
            imgcat "$file"
        else
            bat -Pp "$file"
        fi
    done
}
alias python="python3"
alias ftpservers='cd /Users/seanshmulevich/Code/ftpServers/'

export BAT_THEME="base16"
alias vim="nvim"
alias v="nvim"
# alias cat="bat -Pp"
alias c="code"
alias sshh="history | grep -i 'ssh'"
export EDITOR="code -w"
alias ftpservers='cd /Users/seanshmulevich/Code/ftpServers/'
alias f="fine-dev"
alias pbp="pbpaste"
alias pbc="pbcopy"
alias npmreset="rm -rf node_modules && rm package-lock.json && npm i"
alias todo='/Users/shmul/developer/scripts/todo.sh'
alias ls="exa"

alias rf="rm -rf"
alias pitt="cd /Users/shmul/Desktop/Pitt"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Created by `pipx` on 2022-09-30 14:47:03
# export PATH="$PATH:/Users/seanshmulevich/.local/bin"

# Created by `pipx` on 2022-09-30 14:47:05
# export PATH="$PATH:/Users/seanshmulevich/Library/Python/3.8/bin"
# okay lol thats why i can run 'flutter' without being in my bin
# export PATH="$PATH:/Users/seanshmulevich/flutter/bin"
# export PATH=".:$PATH:/Users/shmul/apache-maven-3.9.6"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home/

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

pm2d() { for i in {0..$1}; do npx pm2 delete $i; done }
alias pm2l="npx pm2 list"
alias make-cli="npm run build && npm i -g"
alias matrix="cargo run --release --manifest-path /Users/shmul/Developer/rusty-rain/Cargo.toml"
alias la="exa -al"
alias goo="/Users/shmul/Developer/scripts/google.sh"

alias runmypython='(cd /Users/shmul/Developer/scripts/startup/ && pipenv run python startup.py )'
alias sch="imgcat ~/Desktop/scheduleSpring.png"


read -r rows cols < <(stty size)

# figlet -c -w $cols  $(date +"%H:%M") | lolcat
# figlet -c -w $cols  $(date +"%x") | lolcat
# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/shmul/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/shmul/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/shmul/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/shmul/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/Users/shmul/jdt-language-server-1.31.0-202401111522/bin:$PATH"
