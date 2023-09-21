--[[
-- Copyright (c) 2019 �人˴������, All Rights Reserved
-- Created: 2019/5/20
--
-- @brief	��������ͼ����ת
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/image.md
--]]
local tostring = tostring
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

local t_get_img_rotate = function (id, chnn)
		local req = {
		cmd = 'img_rotate',
		--llssid = '123456',
		--llauth = '123456',
		img_rotate = {
			chnn = chnn	-- 0
		}
	}
	
	local ret, res = l_sdk.request(id, to_json(req))
	print('request get img_rotate,ret=' .. ret, 'res='..res)

	local dec, obj = pcall(cjson.decode, res)
	
	local E = {}
	return ((obj or E).img_rotate or E).rotate
end


local t_set_img_rotate = function (id, chnn, rotate)
	local req = {
		cmd = 'set_img_rotate',
		--llssid = '123456',
		--llauth = '123456',
		set_img_rotate = {
			chnn = chnn,		-- 0
			rotate = rotate		-- 0, 180
		}
	}
	
	local ret, res = l_sdk.request(id, to_json(req))
	print('request set_img_rotate, rotate=' .. tostring(rotate) .. ',ret=' .. ret, 'res='..res)
end


local rotate = t_get_img_rotate(id, 0)
print('request,now rotate = ' .. tostring(rotate))

if 0 == rotate then
  	rotate = 180
	--rotate = 90
else
	rotate = 0
end

t_set_img_rotate(id, 0, rotate)


-- ����3S
l_sys.sleep(3000)


-- �ǳ�
l_sdk.logout(id)


-- sdk�˳�
l_sdk.quit()
