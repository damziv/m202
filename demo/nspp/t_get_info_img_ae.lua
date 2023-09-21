--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/5/20
--
-- @brief	��������ͼ���ƽ��
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/image.md
--]]
local tostring = tostring
local string = require("string")
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")
local cjson = require("cjson")


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




-- ��ȡ��ǰ��ͷISP��ʵʱ��ƽ����Ϣ
local t_get_info_img_ae = function (id, chnn)
	local req = {
		cmd = 'info_img_ae',
		--llssid = '123456',
		--llauth = '123456',
		info_img_ae = {
			chnn = chnn		-- 0
		}
	}
	
	local ret, res = l_sdk.request(id, to_json(req))
	print('request get info_img_ae,ret=' .. ret, 'res='..res)

	local dec, obj = pcall(cjson.decode, res)
	
	local E = {}
	local a_gain = ((obj or E).info_img_ae or E).a_gain
	local shuttertime = ((obj or E).info_img_ae or E).shuttertime

	
	return a_gain, shuttertime
end




--��оƬ���ȡ�Ĳ���
local now_a_gain, now_shuttertime = t_get_info_img_ae(id, 0)


-- local ae = t_get_img_ae(id, 0)
print('request,now now_again = ' .. tostring(now_a_gain))
print('request,now now_shuttertime = ' .. tostring(now_shuttertime))




-- �ǳ�
l_sdk.logout(id)


-- sdk�˳�
l_sdk.quit()
