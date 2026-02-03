#--------------------------------------------
#        User Environment Variables
#--------------------------------------------
export own=~/own
export obin=$own/obin
export olib=$own/olib
export oinc=$own/oinc
export ebrid=/run/media/logos/Data/EBRID
export cs=$ebrid/COMP_SCI
export learning=$ebrid/COMP_SCI/Learning
export lp=~/logos_projects
export proj=$lp/projects
export edits=$proj/sh/Edits
export releases=$proj/sh/Releases
export bin_src=$lp/bin_src
export nvconf=~/.config/nvim
export lab=$lp/lab_test
export cm=$cs/CMake
export gnu=$cs/GNU
export EDITOR=nvim
export VISUAL=nvim
export OPENER=xdg-open
export GOBIN=~/go/bin
export JAVAPATH=/usr/local/bin/java/jre1.8.0_431/
export WEZPATH=~/wezterm/target/release/
# export BEMENU_OPTS='--prompt run --tb "#5987b6" --tf "#000000" --hf "#5987b6" --scf "#5987b6" --nb "#111111F0" --scb "#111111F0" --fb "#111111F0" --ab "#111111F0" --hb "#111111F0" --ignorecase --single-instance --list 5 --binding vim --scrollbar autohide --no-overlap --border-radius 6px --margin 5 --fn "JetBrainsMono 12"'
# export EZA_COLORS="di=0:ex=0:fi=0:pi=0:so=0:bd=0:cd=0:ln=0:or=0"
export FZF_DEFAULT_OPTS='--height=-1 --bind "ctrl-e:execute(nvim {})" --bind "ctrl-o:execute-silent(xdg-open {})" --bind "ctrl-v:preview:bat {}" --preview-window hidden --bind "ctrl-h:change-preview-window(hidden|)"'
. "$HOME/.cargo/env"
