--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/8/22
--
-- @brief	测试设置图像曝光
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/image.md
--]]
local tostring = tostring
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")
local cjson = require("cjson")


local target = require("demo.target")
local to_json =  require("demo.to_json")
local login = require("demo.login")


-- sdk初始化
l_sdk.init('')


-- 登录到设备
local err, id = login(target.ip, target.port, target.username, target.passwd)


-- 打印登录结果
if 0 ~= err then
	print('login error!'.. 'err=' .. err,  target.username .. '@' .. target.ip .. ':'..target.port .. ' -p ' .. target.passwd)
else	
	print('login ok!'.. 'id=' .. id, target.username .. '@' .. target.ip .. ':'..target.port)
end

local t_get_default_img_exposure = function (id, chnn)
		local req = {
		cmd = 'default_img_exposure',
		--llssid = '123456',
		--llauth = '123456',
		default_img_exposure = {
			chnn = chnn	-- 0
		}
	}
	
	local ret, res = l_sdk.request(id, to_json(req))
	print('request get default_img_exposure,ret=' .. ret, 'res='..res)

	local dec, obj = pcall(cjson.decode, res)
	
	local E = {}
	return ((obj or E).default_img_exposure or E).compensation
end


local t_get_img_exposure = function (id, chnn)
		local req = {
		cmd = 'img_exposure',
		--llssid = '123456',
		--llauth = '123456',
		img_exposure = {
			chnn = chnn	-- 0
		}
	}
	
	local ret, res = l_sdk.request(id, to_json(req))
	print('request get img_exposure,ret=' .. ret, 'res='..res)

	local dec, obj = pcall(cjson.decode, res)
	
	local E = {}
	return ((obj or E).img_exposure or E).compensation
end


local t_set_img_ME_exposure = function (id, chnn, expo_type,a_gain,shuttertime)
	local req = {
		--set_img_ME_exposure->set_img_meexposure 正则表达式不通过
		cmd = 'set_img_meexposure',
		--llssid = '123456',
		--llauth = '123456',
		set_img_meexposure = {
			chnn = chnn,		-- 0
			expo_type = expo_type,	--  [0, 1]
			a_gain = a_gain,	--  [0, 36]
			shuttertime = shuttertime	--  [0, 333]
		}
	}
	
	local ret, res = l_sdk.request(id, to_json(req))
	print('request set_img_ME_exposure, compensation=' .. tostring(expo_type) .. ',ret=' .. ret, 'res='..res)
end


local chnn = 0


--local def_compensation = t_get_default_img_exposure(id, chnn)
--print('request,default compensation = ' .. tostring(def_compensation))


--local compensation = t_get_img_exposure(id, chnn)
--print('request,now compensation = ' .. tostring(compensation))


-- 56 [0, 255]
--t_set_img_exposure(id, chnn, 200)
print('set ME exp')
t_set_img_ME_exposure(id, chnn, 0,0,333)  ---默认（0，0，333）
print('set ME exp end')
-- 休眠1S
l_sys.sleep(1000)


-- 登出
l_sdk.logout(id)


-- sdk退出
l_sdk.quit()
