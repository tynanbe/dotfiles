# config.fish


# https://fishshell.com/docs/current/index.html#variables-color
set -g fish_color_normal normal
set -g fish_color_command --bold
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_param cyan
set -g fish_color_comment red
set -g fish_color_match --background=brblue
set -g fish_color_selection white --bold --background=brblack
set -g fish_color_search_match bryellow --background=brblack
set -g fish_color_operator bryellow
set -g fish_color_escape bryellow --bold
set -g fish_color_cwd green
set -g fish_color_autosuggestion 555 brblack
set -g fish_color_user brgreen
set -g fish_color_host normal
set -g fish_color_cancel -r
set -g fish_pager_color_prefix white --bold --underline
#set -g fish_pager_color_completion
set -g fish_pager_color_description B3A06D yellow
set -g fish_pager_color_progress brwhite --background=cyan
#set -g fish_pager_color_secondary


fish_vi_key_bindings insert


test -f "$HOME/.dircolors"
and set -x LS_COLORS (cat "$HOME/.dircolors")


test -f "$HOME/.asdf/asdf.fish"
and source "$HOME/.asdf/asdf.fish"


command --quiet --search starship
and starship init fish | source
