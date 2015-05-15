#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2015-03-27 14:15:13
# @Author  : jonnyF (fuhuixiang@jonnyf.com)
# @Link    : http://jonnyf.com

from dlnubuy.models import Product
from haystack import indexes


class ProductIndex(indexes.SearchIndex, indexes.Indexable):
    text = indexes.CharField(document=True, use_template=True)

    # 对pdname和description字段进行索引
    pdname = indexes.CharField(model_attr='pdname')

    description = indexes.CharField(model_attr='description')

    def get_model(self):
        return Product

    def index_queryset(self, using=None):
        return self.get_model().objects.all()
