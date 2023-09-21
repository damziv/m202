#!/usr/bin/python3
#-*-coding:utf-8-*-

"""
///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, 武汉舜立软件, All Rights Reserved
//  Created: 2019/06/18
//
/// @file    t_discover.py
/// @brief   测试网络发现
/// @version 0.1
/// @author  李绍良
/// @see https://github.com/lishaoliang/l_sdk_doc/blob/master/sdk/l_sdk_discover.md
///////////////////////////////////////////////////////////////////////////
"""
# 添加基础搜索目录
import l_sdk
l_sdk.append_path()


a = l_sdk.c()

# 打印所有搜索到的设备
print('get_devs :', a.get_devs())
