#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2015-05-14 14:15:13
# @Author  : jonnyF (fuhuixiang@jonnyf.com)
# @Link    : http://jonnyf.com

import re

class middlewareVersion(object):

    def process_request(self, request):
        #判断如果url请求中有静态文件的请求，那么就拦截下来
        if request.path_info.startswith('/static/'):
            #得到path路径，使用正则表达式将版本号过滤掉
            request.path_info = re.sub(r'\.v\d+', '', request.path_info)