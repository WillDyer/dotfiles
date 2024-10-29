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

set -Ux PYTHONPATH "/usr/autodesk/maya2024/lib/python3.10/site-packages/" $PYTHONPATH
set -Ux PATH "/usr/autodesk/maya2024/bin/mayapy" $PATH
set -Ux PYTHONPATH "/usr/bin/python3.12" $PYTHONPATH



