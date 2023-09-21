--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/04/15
--
-- @brief	ʹ��HTTP��¼
-- @author	������
--]]

local curl = require("demo.curl")
local target = require("demo.target")
local to_json =  require("demo.to_json")


-- @brief ��¼���豸
-- @param [in]  	ip[string]			�豸ip
-- @param [in]		port[number]		�˿�
-- @param [in]		username[string]	�û���
-- @param [in]		passwd[string]		����
-- @return err_id[number]	 0.�ɹ�; ��0.������
--	\n		login_id[number] ��¼�ɹ�֮��ĵ�¼id	
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/auth.md
--  \n 'err_id'������: https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/net_err.md
local h_login = function (ip, port, username, passwd)
	local req = {
		cmd = 'login',
		llssid = '123456',
		llauth = '123456',
		login = {
			username = username,
			passwd = passwd
		}
	}
	
	local json = to_json(req)	

	local ret, res = curl.post(ip, port, target.path, json)
	print(ret, res)
	
	return ret, res
end


h_login('192.168.1.247', 80, 'admin', '123456')

return h_login
