set fish_greeting
bind -M insert -m default jk backward-char force-repaint
fish_vi_key_bindings

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      echo -en "\e[2 q"
      tput bold
      tput setab 1
      tput setaf 7
      echo "[N]"
      tput sgr0
      echo " "
    case insert
      echo -en "\e[6 q"
      tput bold
      tput setab 2
      tput setaf 7
      echo "[I]"
      tput sgr0
      echo " "
    case replace_one
      echo -en "\e[4 q"
      tput bold
      tput setab 6
      tput setaf 7
      echo "[R]"
      tput sgr0
      echo " "
    case visual
      echo -en "\e[2 q"
      tput bold
      tput setab 5
      tput setaf 7
      echo "[V]"
      tput sgr0
      echo " "
    case '*'
      echo -en "\e[2 q"
      tput bold
      tput setab 2
      tput setaf 7
      echo "[?]"
      tput sgr0
      echo " "
  end
end

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end
