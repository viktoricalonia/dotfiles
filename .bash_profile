alias setup_appetiser="ssh-add -D;ssh-add ~/.ssh/appetiser";
alias setup_teamfusion="ssh-add -D;ssh-add ~/.ssh/viktoricaloniay";
alias setup_personal="ssh-add -D;ssh-add ~/.ssh/id_rsa";
alias setup_poplar="ssh-add -D;ssh-add ~/.ssh/poplar";
alias setup_snowmanlab="cd ~/Documents/snowmanlabs/aws-credentials-renewer-master && python3 ~/Documents/snowmanlabs/aws-credentials-renewer-master/git_auth.py && cd -"

alias xplode="cd ~/Documents/personal/xplode && ./Documents/personal/xplode/xplode && cd -"

alias run_moving_script="~/Documents/appetiser/run.sh"

alias st="open -a /Applications/SourceTree.app"

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

setopt PROMPT_SUBST
export PROMPT='%F{grey}%n%f %F{cyan}%~%f %F{green}$(parse_git_branch)%f %F{normal}$%f '
