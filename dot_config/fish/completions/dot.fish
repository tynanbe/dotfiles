# fish completion for dot - an alias of chezmoi

source "$HOME/.config/fish/completions/chezmoi.fish"

complete --do-complete "dot " > /dev/null 2>&1
complete -c dot -e
complete -c dot -n "set --query __chezmoi_comp_do_file_comp"
complete -c dot -n "__chezmoi_prepare_completions" -f -a '$__chezmoi_comp_results'