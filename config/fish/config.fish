# ~/.config/fish/config.fish

if status is-interactive
    set fish_greeting ""
    if test -f ~/.config/fish/aliases.fish
        source ~/.config/fish/aliases.fish
    end
    if test -f ~/.config/fish/functions.fish
        source ~/.config/fish/functions.fish
    end
    if test -f ~/.config/fish/starship.fish
        source ~/.config/fish/starship.fish
    end
    if test -f ~/.config/fish/prompt.fish
        source ~/.config/fish/prompt.fish
    end
end
