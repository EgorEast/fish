if not status is-interactive
    exit
end

# Created by `pipx` on 2025-03-14 06:55:59
set PATH $PATH /home/egoreast/.local/bin

zoxide init fish | source

# Эти пути будут добавлены в $PATH единожды
fish_add_path -m ~/bin ~/.local/bin

# Определим переменные XDG
set -q XDG_DATA_HOME || set -U XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME || set -U XDG_STATE_HOME $HOME/.local/state
set -q XDG_CONFIG_HOME || set -U XDG_CONFIG_HOME $HOME/.config
set -q XDG_CACHE_HOME || set -U XDG_CACHE_HOME $HOME/.cache

# Различные настройки
# Используем привычные сочетания клавиш
set -U fish_key_bindings fish_vi_key_bindings

# Двойное нажатие ESC не работает, если выставить меньше
set -g fish_escape_delay_ms 300

# В Yakuake вывод fetch не очень смотрится
if command -q fastfetch && ! string match -q -- "*yakuake*" (pstree -s -p $fish_pid)
    fastfetch
end

set -Ux EDITOR nvim
set -gx BROWSER xdg-open

set -U PROJECT_PATHS ~/Programming/exarh-web ~/Yandex.Disk/ ~/Yandex.Disk/Obsidian/
set -U __done_min_cmd_duration 5000 # default: 5000 ms
set -U __done_exclude '^(v|nvim|y|yazi|m|cmus|g|lazygit)' # default: all git commands, except push and pull. accepts a regex.
set -U __done_notify_sound 1
set -U pisces_only_insert_at_eol 1

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

alias v="nvim"
alias m="cmus"
alias g="lazygit"
alias enable_keyboard1="sudo chmod 777 /dev/hidraw1"
alias enable_keyboard2="sudo chmod 777 /dev/hidraw2"
alias ls='lsd'
