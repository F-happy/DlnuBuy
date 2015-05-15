#coding=utf-8
from dlnubuy import models
from django.template import Context
from django.shortcuts import render_to_response
from django.conf import settings
import pdb
from haystack.forms import SearchForm


#在settings配置文件中取得静态文件版本号
version = settings.STATIC_VERSION


def index(request):
    c = Context({'version': version})
    return render_to_response('index.html', c)


def product_list(request):
    c = Context({'version': version})
    return render_to_response('product_list.html', c)


def product(request):
    products = {}
    user = {}
    pdimg_list = []
    pid = request.GET.get('pid')
    try:
        product = models.Product.objects.get(id=pid)
        products['name'] = product.pdname
        products['money'] = product.money
        products['description'] = product.description
        products['requirement'] = product.requirement
        products['pdimg'] = str(product.pdimg)
        pdimg_list.append(product.pdimg)
        if str(product.pdimg2)[-10:] != '000001.jpg':
            pdimg_list.append(str(product.pdimg2))
        if str(product.pdimg3)[-10:] != '000001.jpg':
            pdimg_list.append(str(product.pdimg3))
        u = models.Users.objects.get(id=product.userid)
        user['name'] = u.username
        user['userphone'] = u.userphone
        user['school'] = u.schoolAddress
        template = 'product.html'
        c = Context({'product': products, 'user': user, 'pdimg_list':pdimg_list, 'version': version})
    except:
        template = 'index.html'
        c = Context({'version': version})
    return render_to_response(template, c)


def register(request):
    c = Context({'version': version})
    return render_to_response('register.html', c)


def login(request):
    c = Context({'version': version})
    return render_to_response('login.html', c)


def users(request):
    c = Context({'version': version})
    return render_to_response('users.html', c)


# 全局搜索
def full_search(request):
    sform = SearchForm(request.GET)
    posts = sform.search()
    template = 'product_search_list.html'
    c = Context({'posts': posts, 'version': version})
    return render_to_response(template, c)
