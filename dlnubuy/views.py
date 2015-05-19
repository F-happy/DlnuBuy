#coding=utf-8
from dlnubuy.models import Product, Users
from django.template import Context
from django.shortcuts import render_to_response
from django.conf import settings
from haystack.forms import SearchForm
import pdb


#在settings配置文件中取得静态文件版本号
VERSION = settings.STATIC_VERSION

# 公共的样式文件
style_lib = ['static/styles/reset.{0}.css'.format(VERSION)]

# 公共的脚本文件
script_lib = ['static/scripts/jquery-1.11.2.min.js',
              'static/scripts/jquery.cookie.min.js',
              'static/scripts/main_framework.{0}.js'.format(VERSION)]

# 公共的表单提交脚本
script_from_lib = ['static/scripts/jquery.validate.min.js',
                   'static/scripts/additional-methods.min.js',
                   'static/scripts/messages_zh.min.js',
                   'static/scripts/jquery.form.js']


def index(request):
    style_lib.append('static/styles/index.{0}.css'.format(VERSION))
    script_lib.append('static/scripts/index.{0}.js'.format(VERSION))
    c = Context({'style_list': set(style_lib), 'script_list': set(script_lib)})
    return render_to_response('index.html', c)


def product_list(request):
    style_lib.append('static/styles/product_list.{0}.css'.format(VERSION))
    script_list = ['static/scripts/query.{0}.js'.format(VERSION),
                   'static/scripts/nongli.{0}.js'.format(VERSION),
                   'static/scripts/product_list.{0}.js'.format(VERSION)]
    script_lib.extend(script_list)
    c = Context({'style_list': set(style_lib), 'script_list': set(script_lib)})
    return render_to_response('product_list.html', c)


def product(request):
    style_lib.append('static/styles/product.{0}.css'.format(VERSION))
    script_list = ['static/scripts/query.{0}.js'.format(VERSION),
                   'static/scripts/product.{0}.js'.format(VERSION)]
    script_lib.extend(script_list)
    context = {'script_list': set(script_lib), 'style_list': set(style_lib)}
    products = {}
    user = {}
    pdimg_list = []
    pid = request.GET.get('pid')
    try:
        product = Product.objects.get(id=pid)
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
        u = Users.objects.get(id=product.userid)
        user['name'] = u.username
        user['userphone'] = u.userphone
        user['school'] = u.schoolAddress
        template = 'product.html'
        context.update({'product': products, 'user': user,
                        'pdimg_list': pdimg_list})
    except:
        template = 'index.html'
    c = Context(context)
    return render_to_response(template, c)


def register(request):
    style_lib.append('static/styles/register.{0}.css'.format(VERSION))
    script_from_lib.append('static/scripts/register.{0}.js'.format(VERSION))
    script_lib.extend(script_from_lib)
    c = Context({'script_list': set(script_lib), 'style_list': set(style_lib)})
    return render_to_response('register.html', c)


def login(request):
    style_lib.append('static/styles/login.{0}.css'.format(VERSION))
    script_from_lib.append('static/scripts/login.{0}.js'.format(VERSION))
    script_lib.extend(script_from_lib)
    c = Context({'script_list': set(script_lib), 'style_list': set(style_lib)})
    return render_to_response('login.html', c)


def users(request):
    style_lib.append('static/styles/users.{0}.css'.format(VERSION))
    script_from_lib.extend(['static/scripts/String.js',
                            'static/scripts/ajaxfileupload.{0}.js'.format(VERSION),
                            'static/scripts/users.{0}.js'.format(VERSION)])
    script_lib.extend(script_from_lib)
    c = Context({'script_list': set(script_lib), 'style_list': set(style_lib)})
    return render_to_response('users.html', c)


# 全局搜索
def full_search(request):
    style_lib.append('static/styles/product_list.{0}.css'.format(VERSION))
    script_list = ['static/scripts/query.{0}.js'.format(VERSION),
                   'static/scripts/product_search_list.{0}.js'.format(VERSION)]
    script_lib.extend(script_list)
    sform = SearchForm(request.GET)
    posts = sform.search()
    template = 'product_search_list.html'
    c = Context({'posts': posts, 'style_list': set(style_lib), 'script_list': set(script_lib)})
    return render_to_response(template, c)
