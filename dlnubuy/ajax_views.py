#coding=utf-8
from dlnubuy import models, dlnu_utils
from django.http import HttpResponse
from django.conf import settings
import json
from django.utils import timezone
import datetime
import autoScript
import pdb


# Create your views here.
# 注册函数还需要修改，目前没有注册时的验证功能
def register(request):
    rsdic = {}
    mobile = request.POST[u'mobile']
    password = request.POST[u'password']
    nickname = request.POST[u'nickname']
    user = models.Users()
    user.userphone = mobile
    user.username = nickname
    user.password = dlnu_utils.encrypt(password)
    try:
        user.save()
        rsdic['ret'] = 'success'
    except:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


# 用户登录函数
def loginuser(request):
    rsdic = {}
    mlsUser = request.POST[u'mlsUser']
    password = dlnu_utils.encrypt(request.POST[u'password'])
    try:
        username = models.Users.objects.get(password=password, username=mlsUser)
        rsdic['ret'] = 'success'
        Uid = username.id
        dlnu_utils.write_to_cache(Uid)
        rsdic['id'] = Uid
    except:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


def loginTag(request):
    rsdic = {}
    user_id = int(request.POST[u'uid'])
    user = models.Users.objects.all().filter(id=user_id)
    rdata = dlnu_utils.read_from_cache(user_id)
    if rdata is not None:
        rsdic['ret'] = 'online'
        for u in user:
            rsdic['phone'] = u.userphone
            rsdic['school'] = u.schoolAddress
            rsdic['img'] = str(u.userimg)
            rsdic['id'] = u.id
            rsdic['username'] = u.username
    else:
        rsdic['ret'] = 'outline'
    return HttpResponse(json.dumps(rsdic))


def logout(request):
    rsdic = {}
    user_id = int(request.POST[u'uid'])
    rdata = dlnu_utils.read_from_cache(user_id)
    if rdata is not None:
        dlnu_utils.del_from_cache(user_id)
        rsdic['ret'] = 'outline'
    else:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


def addproduct(request):
    rsdic = {}
    baomoney = request.POST[u'productmoney']
    baoname = request.POST[u'productname']
    buytext = request.POST[u'producttext']
    user_id = request.POST[u'userid']
    category = int(request.POST[u'productcf'])
    files = request.FILES.getlist('img')
    i = 0
    fads = []
    for f in files:
        uid = user_id + '_' + str(i)
        fad = write_to_infoimg(f, uid, 'product')
        fads.append(fad)
        i += 1
    try:
        products = models.Product()
        if len(fads) < 4:
            fads.append('0')
        products.pdimg = fads[0]
        if fads[1] != '0':
            products.pdimg2 = fads[1]
        else:
            products.pdimg2 = fads[0]
        if fads[2] != '0':
            products.pdimg3 = fads[2]
        else:
            products.pdimg3 = fads[0]
        products.userid = user_id
        products.pdname = baoname
        products.money = baomoney
        products.description = buytext
        products.requirement = buytext
        products.category = category
        products.save()
        autoScript.update_index()
        rsdic['ret'] = 'success'
    except:
        rsdic['ret'] = 'error'

    return HttpResponse(json.dumps(rsdic))


def modifyPassword(request):
    rsdic = {}
    uid = int(request.POST[u'uid'])
    oldpassword = request.POST[u'oldp']
    newpassword = request.POST[u'newp']
    try:
        user = models.Users.objects.get(id=uid)
        password = dlnu_utils.decrypt(user.password)
        if(oldpassword == password):
            user.password = dlnu_utils.encrypt(newpassword)
            user.save()
            rsdic['ret'] = 'success'
        else:
            rsdic['ret'] = 'passerror'
    except:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


def modifyPhone(request):
    rsdic = {}
    uid = int(request.POST[u'uid'])
    uphone = request.POST[u'newphone']
    try:
        user = models.Users.objects.get(id=uid)
        user.userphone = uphone
        user.save()
        rsdic['ret'] = 'success'
    except:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


def modifyuserinfo(request):
    rsdic = {}
    uid = int(request.POST[u'uid'])
    uschool = request.POST[u'news']
    img = request.FILES['newuserimg']
    import re
    pattern1 = re.compile(r'开发区')
    match = pattern1.match(uschool)
    if match is not None:
        newschooladd = '开发区校区'
    else:
        newschooladd = '金石滩校区'
    userimgadd = write_to_infoimg(img, request.POST[u'uid'], 'user')
    try:
        usernew = models.Users.objects.get(id=uid)
        usernew.userimg = userimgadd
        usernew.schoolAddress = newschooladd
        usernew.save()
        rsdic['ret'] = 'success'
    except:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


# 取得宝贝分类的方法
def getClassification(request):
    rsdic = {}
    try:
        parent = int(request.POST[u'parent'])
        level = int(request.POST[u'level'])
        cfobjs = models.Classification.objects.all().filter(parent=parent, level=level)
        cf = []
        for cfobj in cfobjs:
            temp = []
            temp.append(cfobj.CFname)
            temp.append(cfobj.CFnumber)
            cf.append(temp)
        rsdic['cf'] = cf
        rsdic['ret'] = 'success'
    except:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


# 保存用户上传的图片
def write_to_infoimg(file, uid, type):
    if type == 'user':
        with open(settings.USERIMG + 'user_'+uid+'.jpg', 'wb+') as destination:
            for chunk in file.chunks():
                destination.write(chunk)
            destination.close()
            return 'static/images/users/user_'+uid+'.jpg'
    if type == 'product':
        with open(settings.WARP+uid+'.jpg', 'wb+') as destination:
            for chunk in file.chunks():
                destination.write(chunk)
            destination.close()
            return 'static/images/warp/'+uid+'.jpg'


def get_user_buyinfo(request):
    rsdic = {}
    uid = int(request.POST['uid'])
    try:
        models.Product.objects.all().filter(userid=uid)
        rsdic['ret'] = 'have'
    except:
        rsdic['ret'] = 'no'
    return HttpResponse(json.dumps(rsdic))


def get_buyinfo(request):
    rsdic = {}
    uid = request.POST['uid']
    buyinfos = models.Product.objects.all().filter(userid=uid)
    users = models.Users.objects.get(id=uid)
    try:
        arry = []
        for buyinfo in buyinfos:
            data = {}
            data['buyphoto'] = str(users.userimg)
            data['buyname'] = users.username
            data['buyphone'] = users.userphone
            data['buyschool'] = users.schoolAddress
            status = models.Buy.objects.filter(pdid=int(buyinfo.id))
            if status.count() == 0:
                continue
            else:
                data['buylevel'] = status.get().transaction_status
            data['buyschooling'] = users.schoolAddress
            time = int(((timezone.now() - buyinfo.begintime)).total_seconds() // 3600)
            data['succeedtime'] = '剩余'+str(time)+'小时'
            data['begintime'] = str(buyinfo.begintime)[2:10]
            data['pdimg'] = str(buyinfo.pdimg)
            data['pdimg2'] = str(buyinfo.pdimg2)
            data['pdimg3'] = str(buyinfo.pdimg3)
            data['money'] = buyinfo.money
            data['pdname'] = buyinfo.pdname
            data['eval'] = status.get().transaction_status
            data['message'] = buyinfo.requirement
            data['pdid'] = buyinfo.id
            arry.append(data)
        rsdic['data'] = arry
        rsdic['ret'] = 'success'
    except:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


def delete_buy_info(request):
    rsdic = {}
    pdid = int(request.POST['pdid'])
    try:
        models.Product.objects.get(id=pdid).delete()
        models.Buy.objects.get(pdid=pdid).delete()
        autoScript.update_index()
        rsdic['ret'] = 'success'
        rsdic['pdid'] = pdid
    except:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


def get_Allbuyinfo(request):
    rsdic = {}

    cate = request.POST['cate'][:2]
    try:
        products = models.Product.objects.filter(category__startswith=cate)
        arry = []
        for product in products:
            data = {}
            data['src'] = str(product.pdimg)
            data['money'] = '￥' + str(product.money)
            data['title'] = product.description
            try:
                volume = models.Buy.objects.get(pdid=product.id)
                data['volume'] = int(volume.transaction_status)
            except:
                continue
            data['span'] = int(product.likes)
            data['pic_load'] = '#'
            user = models.Users.objects.get(id=product.userid)
            data['user_img'] = str(user.userimg)
            data['user_name'] = user.username
            data['user_info'] = product.requirement
            data['user_href'] = '#'
            data['user_id'] = user.id
            data['pdid'] = str(product.id)
            arry.append(data)
        rsdic['data'] = arry
        rsdic['ret'] = 'succsee'
    except:
        rsdic['ret'] = 'error'
        rsdic['data'] = ''
    return HttpResponse(json.dumps(rsdic))


def get_user_info_plan(request):
    rsdic = {}
    uid = request.POST['uid']
    try:
        users = models.Users.objects.get(id=uid)
        rsdic['username'] = users.username
        rsdic['userphone'] = users.userphone
        rsdic['schoolAddress'] = users.schoolAddress
        rsdic['userimg'] = str(users.userimg)
        rsdic['ret'] = 'success'
    except:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


def get_user_asset_plan(request):
    rsdic = {}
    uid = request.POST['uid']
    try:
        products = models.Product.objects.all().filter(userid=uid)
        arry = []
        for product in products:
            data = {}
            data['name'] = product.pdname
            data['id'] = str(product.id)
            time = int(((timezone.now() - product.begintime)).total_seconds() // 3600)
            if time <= 0:
                continue
            else:
                data['time'] = time
            arry.append(data)
        rsdic['data'] = arry
        rsdic['ret'] = 'success'
    except:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


def get_user_brand_plan(request):
    rsdic = {}
    cate = request.POST['cate'][:2]
    try:
        cates = models.Classification.objects.filter(CFnumber__startswith=cate, level__lte=3)
        arry = []
        for cate in cates:
            data = {}
            data['name'] = cate.CFname
            data['id'] = cate.CFnumber
            arry.append(data)
        rsdic['data'] = arry
        rsdic['ret'] = 'success'
    except:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


def proudctlike(request):
    rsdic = {}
    pid = request.POST['pid']
    try:
        product = models.Product.objects.get(id=pid)
        product.likes = product.likes + 1
        product.save()
        rsdic['num'] = product.likes
        rsdic['ret'] = 'success'
    except:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


def productTime(request):
    rsdic = {}
    pid = request.POST['pid']
    try:
        pdtime = models.Buy.objects.get(pdid=pid)
        if pdtime.transaction_status == '1':
            time7 = pdtime.buytime + datetime.timedelta(hours=12)
            rsdic['tratus'] = '1'
        else:
            time7 = pdtime.buytime + datetime.timedelta(days=7)
            rsdic['tratus'] = '0'
        timeout = (time7 - timezone.now()).total_seconds()
        if timeout > 0:
            timeoutD = timeout // 86400
            timeoutH = (timeout % 86400) // 3600
            timeoutM = (timeout % 86400 % 3600) // 60
            timeoutMm = timeout % 86400 % 3600 % 60
            rsdic['timeoutD'] = timeoutD
            rsdic['timeoutH'] = timeoutH
            rsdic['timeoutM'] = timeoutM
            rsdic['timeoutMm'] = int(timeoutMm)
            rsdic['time'] = '0'
        else:
            rsdic['time'] = '对不起，这个宝贝已经下架了！！'
        rsdic['ret'] = 'success'
    except:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


def get_Allbuyinfos(request):
    rsdic = {}
    try:
        newmonth = timezone.now() - datetime.timedelta(days=30)
        products = models.Product.objects.filter(begintime__gte=newmonth).order_by('begintime')
        arry = []
        for product in products:
            data = {}
            data['src'] = str(product.pdimg)
            data['money'] = '￥' + str(product.money)
            data['title'] = product.description
            try:
                volume = models.Buy.objects.get(pdid=product.id)
                data['volume'] = int(volume.transaction_status)
            except:
                continue
            data['span'] = int(product.likes)
            data['pic_load'] = '#'
            user = models.Users.objects.get(id=product.userid)
            data['user_img'] = str(user.userimg)
            data['user_name'] = user.username
            data['user_info'] = product.requirement
            data['user_href'] = '#'
            data['user_id'] = user.id
            data['pdid'] = str(product.id)
            arry.append(data)
        rsdic['data'] = arry
        rsdic['ret'] = 'succsee'
    except:
        rsdic['ret'] = 'error'
        rsdic['data'] = ''
    return HttpResponse(json.dumps(rsdic))


def buyproudect(request):
    rsdic = {}
    pid = request.POST['pid']
    uid = request.POST['uid']
    try:
        product = models.Buy.objects.get(pdid=pid)
        if product.transaction_status == '0':
            product.transaction_status = 1
            time = timezone.now()
            product.buytime = time
            product.esllid = int(uid)
            product.save()
            rsdic['ret'] = 'success'
        else:
            rsdic['ret'] = 'no'
    except:
        rsdic['ret'] = 'error'
    return HttpResponse(json.dumps(rsdic))


def YoNproudect(request):
    rsdic = {}
    pid = request.POST['pid']
    try:
        buyproduct = models.Buy.objects.get(pdid=pid)
        if buyproduct.transaction_status == '0':
            time = (buyproduct.buytime - timezone.now()).total_seconds()
            if abs(time) > 604800:
                models.Buy.objects.get(pdid=pid).delete()
                rsdic['buyproduct'] = 'no'
            else:
                rsdic['buyproduct'] = 'x'
        else:
            t = dlnu_utils.read_from_product(pid)
            if t is True:
                rsdic['buyproduct'] = 'no2'
            else:
                rsdic['buyproduct'] = 'yes'
                models.Buy.objects.get(pdid=pid).delete()
        rsdic['ret'] = 'success'
    except:
        rsdic['ret'] = 'success'
        rsdic['buyproduct'] = 'no'
    return HttpResponse(json.dumps(rsdic))
