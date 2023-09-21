--[[
-- Copyright (c) 2019 �人˴������, All Rights Reserved
-- Created: 2019/4/24
--

-- @brief	���������豸
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/auth.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")
local cjson = require("cjson")


local target = require("demo.target")
local to_json =  require("demo.to_json")



local path_lpk = 'E:/WORK_PC/F701W/demoV1.1.5_h265/demo/f702w_update_v1.1.18.lpk'


-- sdk��ʼ��
l_sdk.init('')


local up = {
	cmd = 'upgrade',
	llssid = '123456',
	llauth = '123456',
	ip = target.ip,			-- Ŀ��ip
	port = target.port,		-- Ŀ��˿�
	path = path_lpk,		-- �����ļ�·��, ��þ���·��
	upgrade = {
		username = 'admin',
		passwd = '123456'
	}
}


local ret, res = l_sdk.request(0, to_json(up))
print('request upgrade:', ret, res)


while true do
	local up_status = {
		cmd = 'status_upgrade',		-- ����״̬
		ip = target.ip,				-- Ŀ��ip
		port = target.port,			-- Ŀ��˿�
	}

	local ret, res = l_sdk.request(0, to_json(up_status))
	--print('request status_upgrade:', ret, res)
	
	if 0 == ret then
		local dec, o = pcall(cjson.decode, res)
		local o_s_upgrade = o['status_upgrade']
		local percentage = o_s_upgrade['percentage']
		local state = o_s_upgrade['status']

		print('status_upgrade:', state, percentage)
	
		if 'doing' == state then	-- ����ִ��
			
		elseif 'done' == state then	-- ���
			break
		end
	else
		print('request status_upgrade error:', ret)
		break
	end

	l_sys.sleep(100)
end



-- sdk�˳�
l_sdk.quit()
