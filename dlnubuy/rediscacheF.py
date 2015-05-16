#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2015-04-24 08:25:40
# @Author  : jonnyF (fuhuixiang@jonnyf.com)
# @Link    : http://jonnyf.com


from django.conf import settings
import redis


class redisCache(object):
    """docstring for redisCache"""
    def __init__(self):
        self.host = settings.REDIS_HOST
        self.port = settings.REDIS_PORT
        self.db = settings.REDIS_DB
        self.R = redis.StrictRedis(host=self.host, port=self.port, db=self.db)

    #write cache user id
    def write_to_cache(self, user_id):
        r = self.R
        key = 'user_id_of_' + str(user_id)
        r.set(key, key)

    #read cache user id
    def read_from_cache(self, user_id):
        r = self.R
        key = 'user_id_of_'+str(user_id)
        value = r.get(key)
        if value is None:
            data = None
        else:
            data = value
        return data

    # 保存产品的交易时间
    def write_to_product(self, pdid):
        r = self.R
        key = 'product_id_of_'+str(pdid)
        r.set(key, key)
        r.expire(key, 43200)

    # 查询产品是否超时
    def read_from_product(self, pdid):
        r = self.R
        key = 'product_id_of_'+str(pdid)
        value = r.get(key)
        if value is not None:
            return True
        else:
            return False

    def del_from_cache(self, user_id):
        r = self.R
        r.delete(str(user_id))
