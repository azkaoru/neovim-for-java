# neovim-for-java

## install

```
# source install.sh
```

## raunch nvim

```
# nj
```

## bashrc setting

``` 
export VIMRUNTIME="/usr/share/nvim/runtime"
NVIM_JAVA=~/.config/nvim-java
export NVIM_JAVA
# コピー&ペーストにosのclipboardを利用するためにDISPLAYを設定
alias nj='DISPLAY=":1" XDG_DATA_HOME=$NVIM_JAVA/share XDG_CONFIG_HOME=$NVIM_JAVA nvim'
```

