# .bashrc
alias hou="/opt/sidefx/launcher/bin/houdini_launcher"
alias hou_license="sudo /usr/lib/sesi/sesinetd start"
alias lvim-config="lvim /home/will/.config/lvim/config.lua"
alias bash-config="lvim /home/will/.bashrc"
alias maya-modular-rigging="lvim /home/will/maya/scripts/maya_modular_rigging/main.py"
alias maya-usd-export="lvim /home/will/maya/scripts/maya_usd_export/main.py"
alias wd-tools="lvim /home/will/maya/scripts/WD_Tools/main.py"

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

neofetch
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Autodesk/maya2024/bin:$PATH"

