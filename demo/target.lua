--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	Ŀ������豸��Ϣ
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc
--]]

local target = {}


-- @name   target.ip
-- @export Ŀ��IP��ַ
target.ip = '192.168.1.247'
--target.ip = '192.168.3.247'

--target.ip = '192.168.1.201'


-- @name   target.port
-- @export Ŀ��˿�
target.port = 80


-- @name   target.path
-- @export Ŀ�������·��
target.path = '/luajson'


-- @name   target.username
-- @export �û���
target.username = 'admin'


-- @name   target.passwd
-- @export ����
target.passwd = '123456'


-- @name   target.wifi_ssid
-- @export �������STAģʽ��,�����ӵ�Ŀ��wifi��ssid����
--target.wifi_ssid = 'HUAWEI-7NLNPF_5G'
-- target.wifi_ssid = 'TAGYE_5'
target.wifi_ssid = 'SLGD_CAMERA'


-- @name   target.wifi_passwd
-- @export �������STAģʽ��,�����ӵ�Ŀ��wifi������
-- target.wifi_passwd = 'qwertyuiop1234567890'
-- target.wifi_passwd = 'tagye1207'
target.wifi_passwd = '87654321'

target.wifi_APssid = 'F801W_00:00:00:00:22:33'--��ǰ��mac����,�ڴ���Ч
target.wifi_APpasswd = '11113333'--87654321


return target
