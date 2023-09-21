--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/4/30
--
-- @brief	�Զ�Ѱ���豸, �Զ�Ѱ��������, ��������
--  \n ���緢�־��������豸, ���ֲ�ͬ�汾(��ǿ������), ������
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/auth.md
--]]
local table = require("table")
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")
local cjson = require("cjson")
local lfs = require("lfs")


local to_json =  require("demo.to_json")


local force_upgrade = true						-- �Ƿ�ǿ������, ���ܰ汾�Ƿ���ͬ
local path_lpk = 'D:/work/ipc_my/l_dev/main'	-- ������·��	



-- ��ǰ·��
local cur = lfs.currentdir()
local pwd = string.gsub(cur, '\\', '/') or cur	-- ͳһʹ��Ŀ¼��'/'


-- �Ҳ���Ŀ¼, ��ʹ�õ�ǰĿ¼
local path_lpk_attr = lfs.attributes(path_lpk)
if not path_lpk_attr or 'directory' ~= path_lpk_attr.mode then
	path_lpk_attr = pwd
end


-- @brief ��ȡĳĿ¼�������ļ�
-- @param [in]	root_path[string]	����ȡ�ĸ�Ŀ¼
-- @param [out]	files[table]		����ļ��б�
-- @return ��
local get_all_files = nil
get_all_files = function (root_path, files)
	for entry in lfs.dir(root_path) do
		if '.' ~= entry and '..' ~= entry then
			local path = root_path .. '/' .. entry
			local attr = lfs.attributes(path)
			if 'table' == type(attr) then
				if 'directory' == attr.mode then
					get_all_files(path, files)
				elseif 'file' == attr.mode then
					table.insert(files, path)
				end
			else
				assert(false)
			end
		end
	end
end


local discover_devs = function ()
	-- �����緢�ַ���ͻ���
	l_sdk.discover_open('')

	-- ���÷���
	l_sdk.discover_run(true)
	
	local o = {}

	local count = 6
	while 0 < count do
		count = count - 1
		
		print('discover devs...')
	
		local devs = l_sdk.discover_get_devs()
		local dec, obj = pcall(cjson.decode, devs)

		if dec then
			for k, v in pairs(obj) do
				local ip = v['ip']
				if 'string' == type(ip) and '' ~= ip and nil == o[ip] then
					o[ip] = v	-- ���Ϲ����ip �������
				end
			end
		end

		l_sys.sleep(500)
	end

	-- �رշ���
	l_sdk.discover_run(false)

	-- �ر����緢�ַ���ͻ���
	l_sdk.discover_close()
	
	return o
end


local find_lpk = function (root_path)
	
	local files = {}
	get_all_files(root_path, files)
	
	local lpks = {}
	for k, v in ipairs(files) do
		-- �������ļ����ƹ���
		-- �ҵ����� '1.0.7.lpk'��ʽ���ļ�
		local v1, v2, v3 = string.match(v, '.*([%d]+)%.([%d]+)%.([%d]+)%.lpk$')
		
		if v1 and v2 and v3 then
			local o ={
				v1 = v1,
				v2 = v2,
				v3 = v3,
				path = v,
			}
			
			table.insert(lpks, o)			
			-- TEST
			--table.insert(lpks, {v1='1',v2='0',v3='5',path = v,})
			--table.insert(lpks, {v1='2',v2='0',v3='18',path = v,})
			--table.insert(lpks, {v1='10',v2='1',v3='55',path = v,})
			--table.insert(lpks, {v1='10',v2='1',v3='55',path = 'aaa',})
			--table.insert(lpks, {v1='50',v2='0',v3='5',path = v,})
			--table.insert(lpks, {v1='0',v2='0',v3='5',path = v,})
		end
	end
	
	-- �Ӱ汾�ߵ��� ����
	table.sort(lpks, function (lpk_a, lpk_b)
		local a1 = tonumber(lpk_a.v1)
		local a2 = tonumber(lpk_a.v2)
		local a3 = tonumber(lpk_a.v3)
		local b1 = tonumber(lpk_b.v1)
		local b2 = tonumber(lpk_b.v2)
		local b3 = tonumber(lpk_b.v3)
		
		local r
		if a1 == b1 then
			if a2 == b2 then
				r = a3 > b3
			else
				r = a2 > b2
			end
		else
			r = a1 > b1
		end	
		
		return r
	end)
	
	print('find lpks:--------------------------------')
	for k, v in ipairs(lpks) do
		print('*.lpk:' .. v['v1'] .. '.' .. v['v2'] .. '.' .. v['v3'], v['path'])
	end

	if 0 < #lpks then
		local v = lpks[1]
		return v.path, 'v' .. v['v1'] .. '.' .. v['v2'] .. '.' .. v['v3']
	end
	
	return '', ''
end


local upgrade_dev = function (ip, port, lpk)	
	local up = {
		cmd = 'upgrade',
		llssid = '123456',
		llauth = '123456',
		ip = ip,			-- Ŀ��ip
		port = port,		-- Ŀ��˿�
		path = lpk,			-- �����ļ�·��, ��þ���·��
		upgrade = {
			username = 'admin',
			passwd = '123456'
		}
	}

	print('request upgrade:', ip .. ':' .. port)
	local ret, res = l_sdk.request(0, to_json(up))
	print('request upgrade:', ret, res)
	
	while 0 == ret do
		local up_status = {
			cmd = 'status_upgrade',	-- ��ѯ����״̬
			ip = ip,				-- Ŀ��ip
			port = port,			-- Ŀ��˿�
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
end


-- start ...
print('find *.lpk path:', path_lpk)
print('force upgrade:', force_upgrade)


-- sdk��ʼ��
l_sdk.init('')


-- �ҵ������ļ�
local lpk_file, lpk_ver = find_lpk(path_lpk)
if '' == lpk_file then
	print('no lpk file!path:', path_lpk)
else
	print('select lpk file:', lpk_file)
end


-- �����豸
local devs = discover_devs()
print('upgrade auto...')


-- �����������Զ�����
for k, v in pairs(devs) do
	local port = v['discover']['port']
	local ver = v['discover']['sw_ver']
	
	print('dev:', k .. ':' .. port, ver)
	
	if '' ~= lpk_file then
		if force_upgrade or
			ver ~= lpk_ver then
			upgrade_dev(k, port, lpk_file)
			
			-- ��������������Ϊ1S, ����ȴ�����
			-- ������Է�����쳣����, �����ע�͵�����
			print('upgrade wait..')
			l_sys.sleep(3000)
		end
	end
end


-- sdk�˳�
l_sdk.quit()
