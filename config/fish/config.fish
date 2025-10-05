if status is-interactive
    # Remove Greeting
    set -U fish_greeting

    # Locale
    set -x LANG en_US.UTF-8
    set -x LC_ALL en_US.UTF-8

    # Aliases
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'

    # Rust environment
    if test -d $HOME/.cargo/bin
        fish_add_path $HOME/.cargo/bin
    end
end

