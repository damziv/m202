--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	���Ի�ȡͼƬ��
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


local target = require("demo.target")
local to_json =  require("demo.to_json")
local login = require("demo.login")


local open_stream = function (id, chnn, idx)
	local req = {
		cmd = 'open_stream',
		--llssid = '123456',	-- l_sdk�Զ������򲹳����
		--llauth = '123456',	-- l_sdk�Զ������򲹳����
		open_stream = {
			chnn = chnn,
			idx = idx
		}
	}
	
	local json = to_json(req)
	--print('open stream:', json)

	local err, res = l_sdk.request(id, json)

	return err, res
end


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
local idx = 64	-- ͼƬ��1

local err, res = open_stream(id, chnn, idx);
if 0 ~= err then
	print('open stream error!err='..err)
else
	print('open stream ok!res='..res)
end


local count = 10
local pic = 1
while 0 < count do
	if pic < 10 then
		if l_sdk.save(id, chnn, idx, 0, 'test_' .. pic .. '.jpg') then
			print('save pic ok path:'.. 'test_' .. pic .. '.jpg')
			pic = pic + 1
		end
	else
		break
	end
	
	count = count - 1
	l_sys.sleep(1000)
end


-- �ǳ�
l_sdk.logout(id)


-- sdk�˳�
l_sdk.quit()
