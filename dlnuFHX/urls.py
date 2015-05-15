#coding=utf-8
from django.conf.urls import patterns, include, url
import os

urlpatterns = patterns('',
    # Examples:
    url(r'^search/', include('haystack.urls')),
    url(r'', include('dlnubuy.urls')),
)

static_dir = os.path.join(os.path.dirname(__file__), '../dlnubuy/static')

urlpatterns += patterns('',
         (r'^static/(?P<path>.*)$','django.views.static.serve',{'document_root':static_dir}),
)
