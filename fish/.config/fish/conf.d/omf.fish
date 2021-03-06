# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

# Source other files
set -gx PATH "$HOME/.cargo/bin" $PATH;
set -gx PATH "$HOME/.local/bin" $PATH;
set -gx PATH "$HOME/.cabal/bin" $PATH;
set -gx PATH "$HOME/.local/share/gem/ruby/3.0.0/bin" $PATH;

# Exports
export QT_QPA_PLATFORMTHEME=qt5ct
export EDITOR='nvim'
export MANPAGER="nvim +Man!"
export SHELL=/usr/bin/fish
export NNN_PLUG='o:fzopen;v:imgview;s:preview-tui;'
export GPG_TTY=(tty)
set --export NNN_FIFO "/tmp/nnn.fifo"

# Aliases
alias v="nvim"
alias p="paru"
alias c="clear"
alias C="clear"
alias cdc="cd && clear"
alias cat='bat'
alias gc="git clone"
alias lg='lazygit'
alias cr='cargo run'
alias cb='cargo build'
alias ca='cargo add'
alias cw='cargo watch'
alias m='make'
# Changing "ls" to "exa"
alias ls='exa -l --color=always --group-directories-first --icons'
alias la='exa -al --color=always --group-directories-first --icons'
alias l.='exa -a | rg "^\."'
# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist-arch"
alias rg='rg --color=auto'
# adding flags
alias df='df -h'
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias ..="cd .."
alias ...="cd ../.."

source ~/.config/fish/secret.fish
