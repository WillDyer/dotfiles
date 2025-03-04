function fish_greeting
     colorscript -r
end

function c
     clear
     colorscript -r
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

set fish_cursor_default block
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore

set -Ux PYTHONPATH "/usr/bin/python3.12:/usr/autodesk/maya2024/lib/python3.10/site-packages/" $PYTHONPATH
set -Ux PATH "/usr/autodesk/maya2024/bin/mayapy" $PATH
# set -Ux PYTHONPATH "/usr/bin/python3.12" $PYTHONPATH

# Start ssh-agent if not running
if not pgrep -u (whoami) ssh-agent >/dev/null
    eval (ssh-agent -c)
end

# Add SSH key if it's not already added
ssh-add -l >/dev/null 2>&1
if test $status -ne 0
    ssh-add ~/.ssh/id_rsa 2>/dev/null
end
