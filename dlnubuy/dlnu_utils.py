#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2015-05-17 09:46:53
# @Author  : jonnyF (fuhuixiang@jonnyf.com)
# @Link    : http://jonnyf.com


from django.conf import settings
import redis


# 加密类
class EncryPtionF(object):
    '''
    使用的时候需要传人一个生成密文长度的参数 key = 15
    加密实例
    s1 = encrypt(key, '密码')
    解密实例
    s2 = decrypt(key, s1)
    '''
    def __init__(self):
        # 加密的长度，可选，默认为15位
        self.key = 15

    # 加密算法
    def encrypt(self, s):
        b = bytearray(str(s).encode("utf-8"))
        n = len(b)  # 求出 b 的字节数
        c = bytearray(n*2)
        j = 0
        for i in range(0, n):
            b1 = b[i]
            b2 = b1 ^ self.key  # b1 = b2^ key
            c1 = b2 % 16
            c2 = b2 // 16  # b2 = c2*16 + c1
            c1 = c1 + 65
            c2 = c2 + 65  # c1,c2都是0~15之间的数,加上65就变成了A-P 的字符的编码
            c[j] = c1
            c[j+1] = c2
            j = j+2
        return c.decode("utf-8")

    # 解密算法
    def decrypt(self, s):
        c = bytearray(str(s).encode("utf-8"))
        n = len(c)  # 计算 b 的字节数
        if n % 2 != 0:
            return ""
        n = n // 2
        b = bytearray(n)
        j = 0
        for i in range(0, n):
            c1 = c[j]
            c2 = c[j+1]
            j = j+2
            c1 = c1 - 65
            c2 = c2 - 65
            b2 = c2*16 + c1
            b1 = b2 ^ self.key
            b[i] = b1
        try:
            return b.decode("utf-8")
        except:
            return "error"

# 通过单例的方式取得方法
encrypt = EncryPtionF().encrypt
decrypt = EncryPtionF().decrypt


# 缓存控制类
class redisCacheManage(object):
    '''
    这个类是来控制redis缓存的
    提供了用户和产品基本的增，删，改，查功能
    '''
    def __init__(self):
        self.host = settings.REDIS_HOST
        self.port = settings.REDIS_PORT
        self.db = settings.REDIS_DB
        self.R = redis.StrictRedis(host=self.host, port=self.port, db=self.db)

    #写入用户ID到缓存
    def write_to_cache(self, user_id):
        r = self.R
        key = 'user_id_of_' + str(user_id)
        r.set(key, key)

    #从缓存中读取用户ID
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

    # 退出登录后删除用户ID
    def del_from_cache(self, user_id):
        r = self.R
        r.delete(str(user_id))

# 通过单例的方式取得控制方法
write_to_cache = redisCacheManage().write_to_cache
read_from_cache = redisCacheManage().read_from_cache
write_to_product = redisCacheManage().write_to_product
read_from_product = redisCacheManage().read_from_product
del_from_cache = redisCacheManage().del_from_cache
