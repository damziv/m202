--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	��������ͼ�����
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

local set_image = function (id, chnn, bright, contrast, saturation, hue,focus,focusvalue,ezoomvalue)
	local req = {
		cmd = 'set_image',
		--llssid = '123456',	-- l_sdk�Զ������򲹳����
		--llauth = '123456',	-- l_sdk�Զ������򲹳����
		set_image = {
			chnn = chnn,
			bright = bright,
			contrast = contrast,
			saturation = saturation,
			hue = hue,
			focus_mode = focus,
			focus_value = focusvalue,
			ezoom_value = ezoomvalue
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
local idx = 0

local err, res = open_stream(id, chnn, idx);
if 0 ~= err then
	print('open stream ok!err='..err)
	
	-- ����3S
	l_sys.sleep(3000)
else
	print('open stream ok!res='..res)
	
	--  ���ò�����,��Ҫwin֧��Opengl2.0����
	local dlg = l_sdk.open_wnd()	-- �򿪴���
	dlg:bind(id, chnn, idx, 0)		-- �����ڰ󶨵���¼id, ͨ��, �����
	
	while dlg:is_run() do			-- �����Ƿ�ر�

		local bright = l_sys.rand(100)
		local contrast = l_sys.rand(100)
		local saturation = l_sys.rand(100)
		local hue = l_sys.rand(100)
		local focus_mode = 1     --�����ֶ��۽�
		local focus_value = 1    --1����۽�ֵ+1 -1����۽�ֵ-1
		local ezoom_value = 50
		
		local ret, res = set_image(id, chnn, bright, contrast, saturation, hue,focus_mode,focus_value,ezoom_value)
		print('set image,ret='..ret, 'res='..res, 'bcsh='..bright..','..contrast..','..saturation..','..hue..','..focus_mode..','..focus_value..','..ezoom_value)
		
		l_sys.sleep(1000)
	end
	dlg:close()
end

-- �ǳ�
l_sdk.logout(id)


-- sdk�˳�
l_sdk.quit()
