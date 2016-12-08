#!/bin/sh
#使用该脚本对java工程进行编译
#需初始化文件夹如下(设该脚本名为complier.sh)：
#project
#    |---lib(存放用到的第三方jar)
#    |---src(存放java源文件)
#    |---bin(存放生成的class文件)
#    |---compiler.sh
#将所有源文件copy到src文件夹下，并将用到的第三方jar copy到lib文件夹下
LIB_PATH=./lib
SRC_PATH=./src
BIN_PATH=./bin
SOURCES=$SRC_PATH/sources.list
LIBS=$LIB_PATH/libs.list

#将所有java文件名copy到sources.list
rm -f $SOURCES 
find $SRC_PATH/ -name *.java > $SOURCES
#清空class文件夹
rm -rf $BIN_PATH/*

#将所有第三方jar名copy到libs.list
rm -f $LIBS 
find $LIB_PATH/ -name *.jar > $LIBS

#编译java文件
javac -g -d $BIN_PATH -cp @$LIBS @$SOURCES

#将src中除java文件以外的文件copy到bin
find $SRC_PATH -type f | grep -v ".java"
