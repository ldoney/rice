# Recursively adds `~/.local/bin` subdirectories to $PATH
# This is to make nested scripts like `setbg` accessible
export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':')"
export PATH="$PATH:$(du "$HOME/.matlab-symlinks" | cut -f2 | paste -sd ':')"

export _JAVA_AWT_WM_NONREPARENTING=1

export EDITOR="nvim" # default text editor is neovim
export TERMINAL="st" # default terminal is suckless' simple terminal
export BROWSER="firefox" # default browser is firefox
export READER="zathura" # default pdf reader is zathura

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

export LESSHISTFILE="-"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1 && exec startx

# Start graphical server on tty2 if not already running
[ "$(tty)" = "/dev/tty2" ] && ! pidof Xorg >/dev/null 2>&1 && exec startxfce4

if [[ "$(tty)" == "/dev/tty3" ]]; then
    [[ -n "$CDM_SPAWN" ]] && return
    # Avoid executing cdm(1) when X11 has already been started.
    [[ -z "$DISPLAY$SSH_TTY$(pgrep xinit)" ]] && exec cdm
fi
. "$HOME/.local/share/cargo/env"
alias codeapeel='java -jar "/home/lincoln/College/Fall 22/ENEE350/codeapeel/CodeAPeelC.jar"'
