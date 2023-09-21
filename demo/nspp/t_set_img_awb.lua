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

-- ��ȡ��ƽ������
local t_get_img_awb = function (id, chnn)
		local req = {
		cmd = 'img_awb',
		--llssid = '123456',
		--llauth = '123456',
		img_awb = {
			chnn = chnn	-- 0
		}
	}
	
	local ret, res = l_sdk.request(id, to_json(req))
	print('request get img_awb,ret=' .. ret, 'res='..res)

	local dec, obj = pcall(cjson.decode, res)
	
	local E = {}
	return ((obj or E).img_awb or E).awb
end


-- ��ȡ��ǰ��ͷISP��ʵʱ��ƽ����Ϣ
local t_get_info_img_awb = function (id, chnn)
	local req = {
		cmd = 'info_img_awb',
		--llssid = '123456',
		--llauth = '123456',
		info_img_awb = {
			chnn = chnn		-- 0
		}
	}
	
	local ret, res = l_sdk.request(id, to_json(req))
	print('request get info_img_awb,ret=' .. ret, 'res='..res)

	local dec, obj = pcall(cjson.decode, res)
	
	local E = {}
	local b = ((obj or E).info_img_awb or E).b
	local gb = ((obj or E).info_img_awb or E).gb
	local gr = ((obj or E).info_img_awb or E).gr
	local r = ((obj or E).info_img_awb or E).r
	
	return b, gb, gr, r
end

-- ���ð�ƽ������
local t_set_img_awb = function (id, chnn, awb, b, gb, gr, r)
	local req = {
		cmd = 'set_img_awb',
		--llssid = '123456',
		--llauth = '123456',
		set_img_awb = {
			chnn = chnn,		-- 0
			awb = awb,			-- 'auto', 'manual'
			b = b,				-- [0, 4095]
			gb = gb,			-- [0, 4095]
			gr = gr,			-- [0, 4095]
			r = r				-- [0, 4095]
		}
	}
	
	local txt_req = to_json(req)
	local ret, res = l_sdk.request(id, txt_req)
	
	print('request set_img_awb, awb = ' .. tostring(awb) .. ': req = ' .. txt_req)
	print('ret=' .. ret, 'res='..res)
end


local now_b, now_gb, now_gr, now_r = t_get_info_img_awb(id, 0)


local awb = t_get_img_awb(id, 0)
print('request,now img_awb = ' .. tostring(awb))


if 'auto' == awb then
	-- ʹ�����ֵ
	--t_set_img_awb(id, 0, 'manual', l_sys.rand(4096) - 1, l_sys.rand(4096) - 1, l_sys.rand(4096) - 1, l_sys.rand(4096) - 1)
	
	-- ʹ��ʵʱ��ƽ����Ϣ,�մӷ���˻�ȡ����ֵ
	t_set_img_awb(id, 0, 'manual', now_b, now_gb, now_gr, now_r)
	
	-- ʹ��ʵʱ��ƽ����Ϣ,������������
	--t_set_img_awb(id, 0, 'manual')
	
	-- �Զ����ֵ, gb = gr
	--t_set_img_awb(id, 0, 'manual', 200, 2047, 2047, 1000)
	
	-- ȱʧĳ��, �Ͳ��� b gb gr rЧ��һ��
	--t_set_img_awb(id, 0, 'manual', 200, 2047, nil, 1000)
else
	t_set_img_awb(id, 0, 'auto')
end


-- ����3S
l_sys.sleep(3000)


-- �ǳ�
l_sdk.logout(id)


-- sdk�˳�
l_sdk.quit()
