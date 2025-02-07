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
#
# vineflowerを利用してdecompileしたjavaファイルをnvimで開
#
# cdecoはjarとclassを選択し、nvimで開く
alias cdeco='DECO_HOME=~/.local/share/utils/cli-decompiler;rm -fr $DECO_HOME/dest/*;TARGET_JAR=$(find . -name "*.jar" | peco);TARGET_CLASS=$(jar -tvf $TARGET_JAR | awk "{ print \$8}" | grep class | peco);jar -xvf $TARGET_JAR $TARGET_CLASS;cp -pr $TARGET_CLASS $DECO_HOME/src; rm $TARGET_CLASS;DECO_T_CLASS=$(ls -t $DECO_HOME/src | head -n1); java -jar $DECO_HOME/vineflower-1.10.1.jar -log=error $DECO_HOME/src/$DECO_T_CLASS $DECO_HOME/dest;DECO_GENERATED_JAVA=$(ls -t $DECO_HOME/dest | head -n1);nj $DECO_HOME/dest/$DECO_GENERATED_JAVA'
# jdecoはjarを選択し、nvimで開く
alias jdeco='DECO_HOME=~/.local/share/utils/cli-decompiler;rm -fr $DECO_HOME/dest/*;TARGET_JAR=$(find . -name "*.jar" | peco); java -jar $DECO_HOME/vineflower-1.10.1.jar -log=error $TARGET_JAR $DECO_HOME/dest;cd $DECO_HOME/dest;nj'
```

## dev shutcut memo

commentはgcでカレントの行をコメントする。visual modeで複数行選択の場合はgccで、複数行をコメントする。

find type definication: ,ft
jump to type definication: ,jt
jump to method: ,gd

実装クラスのメソッドにジャンプ: ,fi


インポートしているクラスが親クラスで、そのサブクラスを探したい場合は、import文のところに移動して　,fi
なお、複数サブクラスがある場合は、ctrl + q でクイックリストを出して、そこからチェックしたほうがよいかも。

Interfaceを表示して、メソッドに移動して、,frでも実装しているメソッドを表示する。

mvn clean pacakge: fn + <f11>
wildfly deploy: fn + <f12>
widlfy deploy using open pom.xml:  ,rmd
widlfy undploy using open pom.xml:  ,rmu
mvn dependency:tree: ,rmt



## debug shutcut memo

attach to jboss: press ,daj
set break point: ,bb

step into: press <fn><f7>
step over: press <fn><f8>
continue:  preff <fn><f9>


## 利用メモ

まずは参照したいファイルをブラウザより探し、tabで選択すること(例はREADME.md)

つぎに参照するファイルがあればファイル名検索で,ffでファイル名を入力する。その際に<ctrl
+ v>で決定する。例はpom.xml
  (なお、ファイル名の内容を見て、検索したい場合は,ftを入力して検索できる。)

ctrl+vは、 virualsplitなので、ブラウザtreeの右側にpom.xmlを配置する。

この状態で、pom.xmlが画面左に、README.mdが右に表示され、２画面になる。

pom.xlが表示されている画面が開発用で、以降は,ffや,ftでファイルを検索してファイルを検索する(Hello.java)と、
左１画面にpom.xmlとhello.javaのバッファが作成される。


ファイルを編集する際に、別の画面（ファイル）をみたい場合は、READMD.mdの画面を別のファイルに差し替えるとよい。

ttで、ブラウザtreeを表示し、みたいファイルを選択し、tabを押すと「Pickup
Window 」が表示されるので、A と Bが画面に出てくるので、Bを押すと
README.mdからANOTHER_README.mdに変更される。


### using cli decompiler


jdeco でカンレントディレクトリ配下にあるjarを選択し、nvimで開く

cdeco でカンレントディレクトリ配下にあるjarを選択し、そのあとに、classを選択し、nvimで開く


