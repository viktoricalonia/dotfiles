alias setup_appetiser="ssh-add -D;ssh-add ~/.ssh/appetiser";
alias setup_teamfusion="ssh-add -D;ssh-add ~/.ssh/viktoricaloniay";
alias setup_personal="ssh-add -D;ssh-add ~/.ssh/id_rsa";
alias setup_poplar="ssh-add -D;ssh-add ~/.ssh/poplar";
alias setup_snowmanlab="cd ~/Documents/snowmanlabs/aws-credentials-renewer-master && python3 ~/Documents/snowmanlabs/aws-credentials-renewer-master/git_auth.py && cd -"

alias xplode="cd ~/Documents/personal/xplode; ./xplode; cd -"

alias run_moving_script="~/Documents/appetiser/run.sh"

alias st="open -a /Applications/SourceTree.app"

#Change Directory
alias cdpoplar="cd ~/Documents/poplar/poplar-ios/Poplar"
alias cdpersonal="cd ~/Documents/personal"
alias cdteamfusion="cd ~/Documents/teamfusion"
alias cdalgo="cd ~/Documents/algorithms"

#Setup Work
alias setuppoplar="cdpoplar;st ..;open Poplar.xcworkspace;setup_poplar"

#Git shortcut
alias gitsp="git stash pop"
alias gitpo="git push origin"
alias gitc="git checkout"
alias gitfo="git fetch origin"

#Apollo
alias apollogen="./Pods/Apollo/apollo-ios-cli generate"
alias apollofetch="./Pods/Apollo/Apollo-ios-cli fetch-schema"

#TrackPad Settings
alias setTrackpadScaling="defaults write -g com.apple.trackpad.scaling"

#Open File in NeoVIM
alias findf="fd --type f --hidden --exclude .git --exclude Pods | fzf-tmux -p --reverse | xargs nvim"

export PATH="/Users/viktorimmanuelcalonia/Library/Python/3.9/bin:/usr/local/Cellar:$PATH:$HOME/.local/scripts"
