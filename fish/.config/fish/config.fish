function fish_greeting
     colorscript -r
end


if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

set fish_cursor_default block
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore

