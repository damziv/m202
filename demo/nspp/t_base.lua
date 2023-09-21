--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	���Ի���Э��
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/base.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


local target = require("demo.target")
local to_json =  require("demo.to_json")
local login = require("demo.login")


-- sdk��ʼ��
l_sdk.init('')


-- ��¼���豸
local err, id = login(target.ip, target.port, target.username, target.passwd)


-- ��ӡ��¼���
if 0 ~= err then
	print('login error!'.. 'err=' .. err,  target.username .. '@' .. target.ip .. ':'..target.port .. ' -p ' .. target.passwd)
else	
	print('login ok!'.. 'id=' .. id, target.username .. '@' .. target.ip .. ':'..target.port)
end

local req_name = {
	cmd = 'name, default_name'
}

local ret, res = l_sdk.request(id, to_json(req_name))
print('request name, ret='..ret, 'res='..res)


local req_system = {
	cmd = 'system'
}

local ret, res = l_sdk.request(id, to_json(req_system))
print('request system, ret='..ret, 'res='..res)


-- ����1S
l_sys.sleep(1000)


-- �ǳ�
l_sdk.logout(id)


-- sdk�˳�
l_sdk.quit()
