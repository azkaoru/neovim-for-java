#!/usr/bin/sh

export VIMRUNTIME="/usr/share/nvim/runtime"
NVIM_DEV=~/.config/nvim-java
export NVIM_DEV

rm -rf $NVIM_DEV

mkdir -p $NVIM_DEV/share
mkdir -p $NVIM_DEV/nvim

stow --restow --target=$NVIM_DEV/nvim .

alias nj='XDG_DATA_HOME=$NVIM_DEV/share XDG_CONFIG_HOME=$NVIM_DEV nvim'

export nj 

# コピー&ペーストにosのclipboardを利用するためにDISPLAYを設定
export DISPLAY=":1"

mkdir -p ~/.local/share/nvim-java/jdtls
mkdir -p ~/.local/share/nvim-java/eclipse
mkdir -p ~/.local/share/nvim-java/projects/java-debug/com.microsoft.java.debug.plugin/target/
mkdir -p ~/.local/share/nvim-java/projects/vscode-java-test/server
mkdir -p ~/.local/share/nvim-java/projects/dg-jdt-ls-decompiler

#
# install jdtls
#
tar -zxvf jars/jdt-language-server-1.19.0-202301090450.tar.gz -C ~/.local/share/nvim-java/jdtls

#
# install java-debug
#
cp jars/java-debug/com.microsoft.java.debug.plugin-0.44.0.jar  ~/.local/share/nvim-java/projects/java-debug/com.microsoft.java.debug.plugin/target

#
# install java-test
#
cp jars/vscode-java-test/*.jar  ~/.local/share/nvim-java/projects/vscode-java-test/server

#
# install dg-jdt-ls-decompiler
#
cp jars/dg-jdt-ls-decompiler/*.jar  ~/.local/share/nvim-java/projects/dg-jdt-ls-decompiler

#
# install lombok
#
cp jars/lombok.jar  ~/.local/share/nvim-java/eclipse

#
# install code style
#
cp jars/eclipse-java-google-style.xml ~/.local/share/nvim-java/eclipse

#
# install java format
#
cp jars/google-java-format-1.16.0.jar ~/.local/share/nvim-java/eclipse


