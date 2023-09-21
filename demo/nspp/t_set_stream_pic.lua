--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	��������ͼƬ��
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/net.md
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


local chnn = 0
local idx = 64	--ͼƬ��1


local stream_pic = {
	cmd = 'stream_pic',
	--llssid = '123456',
	--llauth = '123456',
	stream_pic = {
		chnn = chnn,
		idx = idx
  }
}


local set_stream_pic = {
	cmd = 'set_stream_pic',
	--llssid = '123456',
	--llauth = '123456',
	set_stream_pic = {
		chnn = chnn,
		idx = idx,
		fmt = 'jpeg',
		wh = '1600*1200',
		quality = 'high',
		interval_ms = 333
	}
}

local ret, res = l_sdk.request(id, to_json(stream_pic))
print('request get stream_pic, ret='..ret, 'res='..res)


local ret, res = l_sdk.request(id, to_json(set_stream_pic))
print('request set stream_pic, ret='..ret, 'res='..res)


-- ����3S
l_sys.sleep(3000)


-- �ǳ�
l_sdk.logout(id)


-- sdk�˳�
l_sdk.quit()
