#!/bin/bash

cd /usr/src
# 这里要删除解压的目录，因为如果已经编译过一次，此时目录里面不仅有源目录的文件还会出现编译时新生成的文件。这个时候再解压的话，他只会覆盖刚解压的目录文件，并不会覆盖编译时新生成的新文，这样的话新的解压目录和旧的编译文件就会冲突，所有要删除解压包从头来，确保环境的干净。
rm -rf apr-1.7.0  apr-util-1.6 httpd-2.4.48
tar xf apr-1.7.0.tar.gz
tar xf apr-util-1.6.1.tar.gz
tar xf httpd-2.4.48.tar.gz

cd apr-1.7.0/
sed -i 's/$RM "$cfgfile"/ # $RM "$cfgfile"/g' configure
./configure --prefix=/usr/local/apr && make && make install


cd ../apr-util-1.6.1
./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr && make && make install


cd ../httpd-2.4.48
./configure --prefix=/usr/local/httpd \
                 --enable-so \
                 --enable-ssl \
                 --enable-cgi \
                 --enable-rewrite \
                 --with-zlib \
                 --with-pcre \
                 --with-apr=/usr/local/apr \
                 --with-apr-util=/usr/local/apr-util \
                 --enable-modules=most \
                 --enable-mpms-shared=all \
                              --with-mpm=prefork && \
          make && make install

# 修改httpd的配置文件，把文件中的#号删掉或者注释
#sed -i "/#ServerName/s/#//" /usr/local/httpd/conf/httpd.conf

# 添加环境变量
#echo "export PATH=/usr/local/httpd/bin:\$PATH" > /etc/profile.d/httpd.sh

# 重新加载配置文件
#systemctl daemon-reload

#systemctl restart httpd.service
