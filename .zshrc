# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/fu/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
source "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme"
# ZSH_THEME="powerlevel10k/powerlevel10k"

# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#export SSH_ASKPASS=/usr/bin/qt4-ssh-askpass
#
plugins=(git vi-mode fzf zsh-interactive-cd) #syntax must be last

#zstyle :omz:plugins:ssh-agent agent-forwarding on

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
path+=('/home/fu/.emacs.d/bin')
#path+=('/usr/lib/jvm/java-11-openjdk')
path+=('/home/fu/bin')
path+=('/home/fu/.dotnet')
path+=('/home/fu/.local/bin')
#export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
source /home/fu/.env_variables.sh
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
export FZF_DEFAULT_COMMAND=''
export FZF_DEFAULT_OPTS=''
export QT_QPA_PLATFORMTHEME=qt5ct
export MANPAGER="nvim +Man!"
export EDITOR="nvim"
#
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias config='/usr/bin/git --git-dir=/home/fu/.dotfiles/ --work-tree=/home/fu'
alias rm="rm -I"
alias mv="mv -i"
alias gs="git status"
alias mk='make CXXFLAGS="-std=c++17 -pedantic -Wall -Wextra"'
alias mka='g++ *.cpp -pedantic -Wall -Wextra -std=c++17 -o exe && ./exe'
alias venv='source venv/bin/activate'
alias emacs="emacsclient -c -a 'emacs' &|"
alias grep="rg"
alias brightness="cd /sys/class/backlight/intel_backlight"
alias mute="amixer sset Master mute"
alias unmute="amixer sset Master unmute"
alias myip="curl http://ipecho.net/plain; echo"
alias 'sudo pacman -Syu'='sudo pacman -Syu && sudo pacdiff'
alias 'yay -Syu'='yay && pacdiff'
alias vim="nvim"
alias bim="nvim"
alias cim="nvim"
alias screenshot="maim -s -u | xclip -selection clipboard -t image/png -i"
alias savess='xclip -selection clipboard -t image/jpeg -o > "`date +%Y-%m-%d_%H-%M-%S`.png"'

bindkey '^f' fzf-cd-widget

alias ls="exa"
alias lsn="exa -snew -la"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.poetry/bin:$PATH"
export POE_LOOTFILTERS="/home/fu/.local/share/Steam/steamapps/compatdata/238960/pfx/drive_c/users/steamuser/My Documents/My Games/Path of Exile"
source /usr/share/nvm/init-nvm.sh

PATH="/home/fu/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/fu/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/fu/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/fu/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/fu/perl5"; export PERL_MM_OPT;

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
