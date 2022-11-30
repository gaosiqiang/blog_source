#!/bin/bash
# while loops

n=1
while (( 1 == 1 ))
do
    pwd
    pull_res=$(git pull origin master);
    if [ "$pull_res" != "Already up-to-date." ]
    then
        hexo clean
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
