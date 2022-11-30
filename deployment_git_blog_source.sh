#!/bin/bash
# while loops

n=1
while (( 1 == 1 ))
do

    pull_res=$(git pull origin master);
    if [ "$pull_res" != "Already up-to-date." ]
    then
        # hexo clean # 报错Error: EBUSY: resource busy or locked, rmdir '/blog/public/'
        hexo generate
    else
        echo 'not update';
    fi
    #hexo clean
    #hexo generate
    # echo $n
    #(( n++ ))
    sleep 15

done

# hexo服务器部署脚本，每15秒执行一次
