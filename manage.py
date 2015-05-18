#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import sys
import autoScript
from django.conf import settings

if __name__ == "__main__":

    if settings.DEBUG is not True:
        # 在这里开启多线程来启动redis服务器
        autoScript.redis_create()

    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "dlnuFHX.settings")

    from django.core.management import execute_from_command_line

    execute_from_command_line(sys.argv)
