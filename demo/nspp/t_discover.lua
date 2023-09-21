--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	�������緢���豸
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/multicast/multicast.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


-- sdk��ʼ��
l_sdk.init('')


-- �����緢�ַ���ͻ���
l_sdk.discover_open('')


-- ���÷���
l_sdk.discover_run(true)


local count = 11
while 0 < count do
	count = count - 1

	local devs = l_sdk.discover_get_devs()
	print('discover get devs:', devs)

	l_sys.sleep(1000)
end


-- �رշ���
l_sdk.discover_run(false)


-- �ر����緢�ַ���ͻ���
l_sdk.discover_close()

-- sdk�˳�
l_sdk.quit()
