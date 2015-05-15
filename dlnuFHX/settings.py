#coding=utf-8
"""
Django settings for dlnuFHX project.

For more information on this file, see
https://docs.djangoproject.com/en/1.7/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.7/ref/settings/
"""

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
import os
BASE_DIR = os.path.dirname(os.path.dirname(__file__))



# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.7/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '!!&4&5j0h=a$f@cvya(_3z0#78a=+m@-aj_%o3nq)1u9i%^$w$'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

TEMPLATE_DEBUG = True

ALLOWED_HOSTS = []

# Application definition

INSTALLED_APPS = (
    # 'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    # 'django.contrib.staticfiles',
    'dlnubuy',
    'haystack',
)

MIDDLEWARE_CLASSES = (
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    # 'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.auth.middleware.SessionAuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'dlnubuy.middleware.middlewareVersion',
)

ROOT_URLCONF = 'dlnuFHX.urls'

WSGI_APPLICATION = 'dlnuFHX.wsgi.application'


# Database
# https://docs.djangoproject.com/en/1.7/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'dlnubuy',
        'USER':'root',
        'PASSWORD':'1991115fhx',
        'HOST':'127.0.0.1',
        'PORT':'3306',
    }
}

# Internationalization
# https://docs.djangoproject.com/en/1.7/topics/i18n/

LANGUAGE_CODE = 'zh-cn'

TIME_ZONE = 'Asia/Shanghai'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.7/howto/static-files/

STATIC_URL = '/static/'

TEMPLATE_DIRS = (
      # os.path.join(os.path.dirname(__file__),'templates').replace('\\','/'),
      os.path.join(BASE_DIR, 'templates').replace('\\', '/'),
)

REDIS_HOST = '127.0.0.1'
REDIS_PORT = 6379
REDIS_DB = 0

# 这个路径是用户头像保存的路径
USERIMG = 'C:\\Users\\Jonny\\Documents\\project\\dlnubuy\\dlnubuy\\static\\images\\users\\'

# 这个路径是用户给宝贝上传的图片路径
WARP = 'C:\\Users\\Jonny\\Documents\\project\\dlnubuy\\dlnubuy\\static\\images\\warp\\'

# full text search
HAYSTACK_CONNECTIONS = {
    'default': {
        'ENGINE': 'dlnubuy.whoosh_cn_backend.WhooshEngine',
        'PATH': os.path.join(BASE_DIR, 'whoosh_index'),
    },
}
HAYSTACK_SIGNAL_PROCESSOR = 'haystack.signals.RealtimeSignalProcessor'

#Static file version number
STATIC_VERSION = 'v0514'