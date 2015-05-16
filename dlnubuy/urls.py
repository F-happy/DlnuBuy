#coding=utf-8
from django.conf.urls import patterns, url


urlpatterns = patterns('dlnubuy.views',
       url(r'^$', "index"),
       url(r'^index.html', "index"),
       url(r'^product_list.html', "product_list"),
       url(r'^product.html', "product"),
       url(r'^register.html', "register"),
       url(r'^login.html', "login"),
       url(r'^users.html', "users"),
       url(r'^Product_Serach.html', "full_search")
)

urlpatterns += patterns('dlnubuy.ajax_views',
       url(r'^ajax/registeruser', 'register'),
       url(r'^ajax/loginuser', 'loginuser'),
       url(r'^ajax/loginTag', 'loginTag'),
       url(r'^ajax/addproduct', 'addproduct'),
       url(r'^ajax/get_classification', 'getClassification'),
       url(r'^ajax/modifypassword', 'modifyPassword'),
       url(r'^ajax/modifyphone', 'modifyPhone'),
       url(r'^ajax/modifyuserinfo', 'modifyuserinfo'),
       url(r'^ajax/get_user_buyinfo', 'get_user_buyinfo'),
       url(r'^ajax/get_buyinfo', 'get_buyinfo'),
       url(r'^ajax/delete_buy_info', 'delete_buy_info'),
       url(r'^ajax/get_Allbuyinfo', 'get_Allbuyinfo'),
       url(r'^ajax/get_Allbuy', 'get_Allbuyinfos'),
       url(r'^ajax/get_user_info_plan', 'get_user_info_plan'),
       url(r'^ajax/get_user_asset_plan', 'get_user_asset_plan'),
       url(r'^ajax/get_user_brand_plan', 'get_user_brand_plan'),
       url(r'^add/proudctlike', 'proudctlike'),
       url(r'^ajax/productTime', 'productTime'),
       url(r'^ajax/buyproudect', 'buyproudect'),
       url(r'^ajax/yes_or_no_buyproduct', 'YoNproudect'),
       url(r'^ajax/logout', "logout")
)
