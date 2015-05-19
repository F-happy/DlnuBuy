#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2015-03-27 14:15:13
# @Author  : jonnyF (fuhuixiang@jonnyf.com)
# @Link    : http://jonnyf.com

import os
import threading


# 当数据库更新时更新索引
def update_index():
    os.system('python manage.py update_index')


# 创建索引
def create_index():
    os.system('python manage.py rebuild_index')


# 启动redis
def redis_start():
    os.chdir('C:\\Users\\Jonny\\Documents\\Service\\redis')
    os.system('redis-server.exe redis.conf')


def redis_create():
    # 在这里开启多线程来启动redis服务器
    thread = threading.Thread(target=redis_start)
    thread.start()

if __name__ == "__main__":
    redis_create()
