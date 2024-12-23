# My Dotfiles

## Requirements

- Homebrew

`
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
`

- Git  
`
brew install git
`

- Stow
`
brew install stow
`

## Installation 

Clone Repo with 

```
git clone https://github.com/viktoricalonia/dotfiles.git
```

then 

```
cd dotfiles
```

then 

```
stow . --target=$HOME --restow
```
