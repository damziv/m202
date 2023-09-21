--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	目标测试设备信息
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc
--]]

local target = {}


-- @name   target.ip
-- @export 目标IP地址
target.ip = '192.168.1.247'
--target.ip = '192.168.3.247'

--target.ip = '192.168.1.201'


-- @name   target.port
-- @export 目标端口
target.port = 80


-- @name   target.path
-- @export 目标短连接路径
target.path = '/luajson'


-- @name   target.username
-- @export 用户名
target.username = 'admin'


-- @name   target.passwd
-- @export 密码
target.passwd = '123456'


-- @name   target.wifi_ssid
-- @export 相机处于STA模式下,待连接的目标wifi的ssid名称
--target.wifi_ssid = 'HUAWEI-7NLNPF_5G'
-- target.wifi_ssid = 'TAGYE_5'
target.wifi_ssid = 'SLGD_CAMERA'


-- @name   target.wifi_passwd
-- @export 相机处于STA模式下,待连接的目标wifi的密码
-- target.wifi_passwd = 'qwertyuiop1234567890'
-- target.wifi_passwd = 'tagye1207'
target.wifi_passwd = '87654321'

target.wifi_APssid = 'F801W_00:00:00:00:22:33'--当前由mac决定,在此无效
target.wifi_APpasswd = '11113333'--87654321


return target
