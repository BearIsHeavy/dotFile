# Manual

## Directory Structe
``` txt
.dotfile
├── .gitignore
├── .zsh                    <--- Third-party plugins related to zsh
│   ├── spaceship
│   └── zsh-autosuggestions
├── Download                <--- Commonly used third-party tools
│   ├── Clash
│   ├── nvim
│   ├── frp
├── main.sh                 <---- The entry point for project operation
├── Linux_Initial           <---- Perform necessary initialization on the new system
│   ├── Arch
│   └── Ubuntu
├── README.md
├── bin
│   ├── enableProxy
│   ├── explainshell
│   ├── shell/
│   ├── src/
│   └── workshop/
├── bug_fixes.log           <--- bug repair log
├── generalConfig           <--- general config files
│   ├── .alias
│   ├── .bashrc
│   ├── .profile
│   ├── .tmux.conf
│   └── .vimrc
├── initial                 <--- Initialization scripts for different modules enhance the user experience
│   ├── build_dvwa.sh
│   ├── colors.sh
│   ├── conda.sh
│   ├── neovide.sh
│   ├── nvim.sh
│   ├── otherCommand.sh
│   ├── terminal_fonts.sh
│   ├── vim.sh
│   ├── vpn.sh
│   └── zsh.sh
├── nvim                    <--- nvim config files
│   ├── coc-settings.json
│   ├── init.lua
│   ├── lua
│   └── plugin
├── requirements.sh         <--- apt packages
├── securityNote/
├── vscode_config
│   └── settings.json
└── zshconfig               <--- zsh config files
    ├── .zlogin
    ├── .zprofile           <--- The contents of different computers are different
    ├── .zshenv
    ├── .zshrc
    └── trigger.sh
```

## Intruction
1. Recommand your manually running `bash ./initial/vpn.sh`, which will setup your vpn config. (**Recommand Manaual** !!!)
> Please setup your vpn before setup nvim, because install plugs for nvim will connecte github
1. `bash ./Initial` this script will auto-compelte your configs (zsh, vim and nvim)
. if have error, you can use `echo $?` command to dected your error. (Then add an error table for each error, building....)
3. The content in the `Public`branch has been tested on a new Ubuntu computer, but the `Main` branch has not.
4. `frp` and `frps` need your manaual config. if you want to use **frp server** you can use this file 