# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

# Source other files
#source ~/installs/anaconda3/etc/fish/conf.d/conda.fish
set -gx PATH "$HOME/.cargo/bin" $PATH;
set -gx PATH "$HOME/.local/bin" $PATH;
set -gx PATH "$HOME/.cabal/bin" $PATH;

# Exports
export QT_QPA_PLATFORMTHEME=qt5ct
export EDITOR=nvim
export MANPAGER="nvim -c 'set ft=man' -"
export SHELL=/usr/bin/fish

# Alias
alias c="clear"
alias upd="sudo pacman -Syu && yay -Syu"
alias q="exit"
alias ls="exa --icons --group-directories-first"
alias cat='bat'
# Changing "ls" to "exa"
alias ls='exa --color=always --group-directories-first --icons'  # all files and dirs
alias la='exa -al --color=always --group-directories-first --icons' # my preferred listing
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias l.='exa -a | rg "^\."'
# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
# Colorize grep output (good for log files)
alias grep='rg --color=auto'
alias rg='rg --color=auto'
# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias ..="cd .."

# cat ~/.config/name.txt | awk -v col=$COLUMNS '{n_blank=(col-length($0))/2 ; printf "%-*s",n_blank," " ;print $0}'
