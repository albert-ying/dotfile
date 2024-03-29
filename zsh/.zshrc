
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
# [ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PYTHONPATH=~/zoteroutils:${PYTHONPATH}
export NEOVIDE_FRAMELESS=1
export NeovideMultiGrid=1
export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

<<<<<<< HEAD
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export OPENAI_API_KEY="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"

# export PYTHONPATH=~/zoteroutils:${PYTHONPATH}
# export NEOVIDE_FRAMELESS=1
# export NeovideMultiGrid=1
# (cat ~/.cache/wal/sequences &)
=======
###############
nincat --random --center
echo "

Welcome!

"
##############

(cat ~/.cache/wal/sequences &)
>>>>>>> 9384fc3d7596f3891dbbba38e3601b800534bb40
#source ~/.oh-my-zsh/oh-my-zsh.sh
# load zgen
source "${HOME}/.zgen/zgen.zsh"
# if the init script doesn't exist
if ! zgen saved; then
  # specify plugins here
  zgen oh-my-zsh
  zgen load fdw/ranger_autojump
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/command-not-found
  zgen oh-my-zsh plugins/autojump
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load romkatv/powerlevel10k powerlevel10k
  # zgen oh-my-zsh themes/arrow
  # generate the init script from plugins above
  zgen save
fi

alias rr="radian"
alias n="/usr/local/bin/nvim"
alias vim="n"
alias nvim="nvr"
alias o2="sshpass -p 'D777ho220**0' ssh ky126@o2.hms.harvard.edu"
alias bigblack="sshpass -p 123456 ssh kejun@222.200.186.63"
alias o2scp="sshpass -p 'D777ho220**0' scp"
alias fas="ssh -CY kying@boslogin04.rc.fas.harvard.edu"
alias main="ssh -Y -L2023:aging:22    kx461@ssh.partners.org"
alias main2="ssh -Y -L2023:aging:22    kx461@ssh3.partners.org"
alias aging="ssh -Y -l kying -p 2023 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no localhost"
alias ls='exa --icons'
alias lln='ls --icons -snew'
alias z='zathura --fork'
alias fasdown="scp -r kying@login.rc.fas.harvard.edu:/n/home00/kying/outbox/ ./"
<<<<<<< HEAD
=======
alias python3="/Users/A.Y/miniconda3/bin/python3"
alias yo="open -a Yoink"
>>>>>>> 9384fc3d7596f3891dbbba38e3601b800534bb40
alias ta="tmux a"
export EDITOR="/usr/local/bin/nvim"
#export DISPLAY=localhost:11.0

# plugins=(git zsh-autosuggestions autojump zsh-syntax-highlighting)
# If you come from bash you might have to change your $PATH.

# Path to your oh-my-zsh installation.
export ZSH="/Users/A.Y/.oh-my-zsh"
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}

cpfile() {
    osascript \
        -e 'on run args' \
        -e 'set the clipboard to POSIX file (first item of args)' \
        -e end \
        "$@"
}
### Wall script
wl_export() {
  export WALLPAPER=$(osascript -e 'tell application "System Events" to tell first Desktop to get its picture')
}
alias wl='wl_export; wal -i "$WALLPAPER" -o "$HOME/.wal_script.sh"; sleep 3; yabai -m config window_shadow off'
alias wll='wl_export; wal -i "$WALLPAPER" -o "$HOME/.wal_script.sh" -l; sleep 3; yabai -m config window_shadow off'

alias lw='wal -i /Users/A.Y/OneDrive\ -\ Harvard\ University/Wallpaper -q; wl'
alias www='rm -rf /Users/A.Y/Wallhaven/*; python3 /Users/A.Y/Wallhaven-dl/wallhaven-dl.py; ww'
alias ww='wal -i /Users/A.Y/Wallhaven -q; wl'
alias rw='python3 /Users/A.Y/pywal-reddit/pywal-reddit.py'
alias sw='wl_export; cp "$WALLPAPER" /Users/A.Y/OneDrive\ -\ Harvard\ University/Wallpaper/'
alias fw='wl_export; cp "$WALLPAPER" /Users/A.Y/OneDrive\ -\ Harvard\ University/Wallpaper/favorite'
alias fwl='wal -i /Users/A.Y/OneDrive\ -\ Harvard\ University/Wallpaper/favorite -q; wl'
alias dwl='wal -i /Users/A.Y/OneDrive\ -\ Harvard\ University/Wallpaper/doraemon -q; wl'
alias rwl='wal -i /Users/A.Y/Pictures/Reddit-Wall -q ; wl'
alias tw='/Users/A.Y/programs/ImageTheming/imagetheme_wal.sh'
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
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

# User configurations
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
export PATH="/usr/local/opt/cython/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# source "$HOME/zsh-vim-mode/zsh-vim-mode.plugin.zsh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kying/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kying/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kying/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kying/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.bashrc

# Sync
export FZF_COMPLETION_TRIGGER='*'
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    *)            fzf "$@" ;;
  esac
}
export PATH="/usr/local/opt/openssl@3/bin:$PATH"

eval $(thefuck --alias)
alias fk="fuck"

<<<<<<< HEAD
alias envset='export "`tmux showenv PATH`" ; export "`tmux showenv GIT_ASKPASS`" ; export "`tmux showenv VSCODE_GIT_ASKPASS_MAIN`"
; export "`tmux showenv VSCODE_GIT_ASKPASS_NODE`" ; export "`tmux showenv VSCODE_IPC_HOOK_CLI`"'

alias ipy="envset; ipython"

=======
#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
# [ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####

(trash ~/trash/*) &>/dev/null
>>>>>>> 9384fc3d7596f3891dbbba38e3601b800534bb40
