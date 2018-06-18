#! /bin/bash

# 读取配置
cflags=$(/usr/bin/mysql_config --cflags)
libs=$(/usr/bin/mysql_config --libs)
# 替换/为转义,sed要用
cflags=${cflags//\//\\\/}
libs=${libs//\//\\\/}

# 拼接sed命令参数
c="s/INCS =/INCS =${cflags}/g"
l="s/LIBS =/LIBS =${libs}/g"
cur_dir=`pwd`

cd $cur_dir/network
make

cd $cur_dir/utils
make

cd $cur_dir/depends/hiredis
make
sudo make install

cd  $cur_dir/matchengine
sed -i "$c" makefile
sed -i "$l" makefile
make

cd  $cur_dir/marketprice/
make

cd  $cur_dir/accesshttp/
make

cd $cur_dir/accessws
make

cd $cur_dir/alertcenter
make

cd $cur_dir/readhistory
sed -i "$c" makefile
sed -i "$l" makefile
make
