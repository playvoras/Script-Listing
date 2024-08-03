--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- SETUP --

local executor, executor_version = "VulkanExec", ""
local identity = 69420
local hooked = {}
local ceRequests = false
local genv = table.create(0)
local env
local instances_reg = setmetatable({ [game] = true }, { __mode = "ks" })
local metaInstances = {}
local rTypeof = typeof
local function ismetainstance(obj)
	return metaInstances[obj] ~= nil or rTypeof(obj) == "table" and obj.___originalInstance
end
local emptyT = {}
local function table_find(t,v)
	return (table.find(t,v) or t[v]) ~= nil
end

local genvMeta = setmetatable({},{
	__index = function(self, name)
		return _G.ENV and _G.ENV[name] or getfenv()[name] or getfenv().getfenv(0)[name]
	end,
	__newindex = function(self, name, value)
		if _G.ENV then
			_G.ENV[name] = value
		end
		getfenv().getfenv(1.2)[name] = value
		getfenv().getfenv(0)[name] = value
		getfenv().getfenv(1)[name] = value
	end,
})
--local rrequire = require
local function getgenv()
	return genvMeta
end
local function getFunc(name)
	return getfenv()[name]
end
local canLoadstring = false
pcall(function()
	canLoadstring = loadstring("return true")()
end)
local function newLoadstring(str)
	if canLoadstring then return loadstring(str) end
	str = ([[if type(setidentity) == 'function' then setidentity(8) end ]])..str
	local nLs = require((_G.Internal or getFunc("Internal") or _G.ENV.Internal).loadstring)
	local oLs = _G.oldLoadstring

	local psuccess, success, result

	_, success, result = pcall(oLs, str, --env
		genvMeta)
	if not success then
		local worked, nsuccess, nresult = pcall(nLs, str, env)
		if worked then
			success, result = nsuccess, nresult
		end
	end

	return success, result
end
local convertToMetaInstance
function convertToMetaInstance(object,options)
	if ismetainstance(object) then
		local metametainstance = setmetatable({},{
			__index = function(self, index)
				return object[index]
			end,
			__newindex = function(self, index, value)
				object[index] = value
			end,
			__tostring = function()
				return tostring(object)
			end,
			__metatable = "Metatable is locked!"
		})
		metaInstances[metametainstance] = object.___originalInstance

		return metametainstance
	end

	local options = options or {}
	local customMethods = options.CustomMethods or {}
	local blockMethods = options.BlockMethods or {}
	local fixEnv = not not options.FixEnvinroment
	local metaInstance

	local function checkExist(self, index)
		return table.pack(pcall(function()
			return self[index] ~= nil
		end))[1]
	end

	if checkExist("IsLoaded") and not customMethods["IsLoaded"] then
		customMethods["IsLoaded"] = function(self, ...)
			return object:IsLoaded(...)
		end
	end
	if checkExist("isLoaded") and not customMethods["isLoaded"] then
		customMethods["isLoaded"] = function(self, ...)
			return object:isLoaded(...)
		end
	end
	if checkExist("FindFirstChild") and not customMethods["FindFirstChild"] then
		customMethods["FindFirstChild"] = function(self, ...)
			return convertToMetaInstance(object:FindFirstChild(...))
		end
	end
	if checkExist("findFirstChild") and not customMethods["findFirstChild"] then
		customMethods["findFirstChild"] = function(self, ...)
			return convertToMetaInstance(object:findFirstChild(...))
		end
	end
	if checkExist("FindFirstChildOfClass") and not customMethods["FindFirstChildOfClass"] then
		customMethods["FindFirstChildOfClass"] = function(self, ...)
			return convertToMetaInstance(object:FindFirstChildOfClass(...))
		end
	end
	if checkExist("findFirstChildOfClass") and not customMethods["findFirstChildOfClass"] then
		customMethods["findFirstChildOfClass"] = function(self, ...)
			return convertToMetaInstance(object:findFirstChildOfClass(...))
		end
	end
	if checkExist("FindFirstChildWhichIsA") and not customMethods["FindFirstChildWhichIsA"] then
		customMethods["FindFirstChildWhichIsA"] = function(self, ...)
			return convertToMetaInstance(object:FindFirstChildWhichIsA(...))
		end
	end
	if checkExist("findFirstChildWhichIsA") and not customMethods["findFirstChildWhichIsA"] then
		customMethods["findFirstChildWhichIsA"] = function(self, ...)
			return convertToMetaInstance(object:findFirstChildWhichIsA(...))
		end
	end
	if checkExist("Clone") and not customMethods["Clone"] then
		customMethods["Clone"] = function(self, ...)
			return convertToMetaInstance(object:Clone(...))
		end
	end
	if checkExist("clone") and not customMethods["clone"] then
		customMethods["clone"] = function(self, ...)
			return convertToMetaInstance(object:clone(...))
		end
	end
	if checkExist("Remove") and not customMethods["Remove"] then
		customMethods["Remove"] = function(self, ...)
			return object:Remove(...)
		end
	end
	if checkExist("remove") and not customMethods["remove"] then
		customMethods["remove"] = function(self, ...)
			return object:remove(...)
		end
	end
	if checkExist("GetChildren") and not customMethods["GetChildren"] then
		customMethods["GetChildren"] = function(self, ...)
			return object:GetChildren(...)
		end
	end
	if checkExist("getChildren") and not customMethods["getChildren"] then
		customMethods["getChildren"] = function(self, ...)
			return object:getChildren(...)
		end
	end
	if checkExist("WaitForChild") and not customMethods["WaitForChild"] then
		customMethods["WaitForChild"] = function(self, ...)
			return object:WaitForChild(...)
		end
	end
	if checkExist("waitForChild") and not customMethods["waitForChild"] then
		customMethods["waitForChild"] = function(self, ...)
			return object:waitForChild(...)
		end
	end
	if checkExist("IsA") and not customMethods["IsA"] then
		customMethods["IsA"] = function(self, ...)
			return object:IsA(...)
		end
	end
	if checkExist("isA") and not customMethods["isA"] then
		customMethods["isA"] = function(self, ...)
			return object:isA(...)
		end
	end
	if checkExist("GetAttribute") and not customMethods["GetAttribute"] then
		customMethods["GetAttribute"] = function(self, ...)
			return object:GetAttribute(...)
		end
	end
	if checkExist("getAttribute") and not customMethods["getAttribute"] then
		customMethods["getAttribute"] = function(self, ...)
			return object:getAttribute(...)
		end
	end
	if checkExist("SetAttribute") and not customMethods["SetAttribute"] then
		customMethods["SetAttribute"] = function(self, ...)
			return object:SetAttribute(...)
		end
	end
	if checkExist("setAttribute") and not customMethods["setAttribute"] then
		customMethods["setAttribute"] = function(self, ...)
			return object:setAttribute(...)
		end
	end
	if checkExist("FindFirstAncestorOfClass") and not customMethods["FindFirstAncestorOfClass"] then
		customMethods["FindFirstAncestorOfClass"] = function(self, ...)
			return convertToMetaInstance(object:FindFirstAncestorOfClass(...))
		end
	end
	if checkExist("findFirstAncestorOfClass") and not customMethods["findFirstAncestorOfClass"] then
		customMethods["findFirstAncestorOfClass"] = function(self, ...)
			return convertToMetaInstance(object:findFirstAncestorOfClass(...))
		end
	end
	if checkExist("IsDescendantOf") and not customMethods["IsDescendantOf"] then
		customMethods["IsDescendantOf"] = function(self, ...)
			return object:IsDescendantOf(...) or object:IsDescendantOf(table.pack(...)[1].___originalInstance)
		end
	end
	if checkExist("isDescendantOf") and not customMethods["isDescendantOf"] then
		customMethods["isDescendantOf"] = function(self, ...)
			return object:IsDescendantOf(...) or object:IsDescendantOf(table.pack(...)[1].___originalInstance)
		end
	end
	if checkExist("GetDescendants") and not customMethods["GetDescendants"] then
		customMethods["GetDescendants"] = function(self, ...)
			return object:GetDescendants(...)
		end
	end
	if checkExist("getDescendants") and not customMethods["getDescendants"] then
		customMethods["getDescendants"] = function(self, ...)
			return object:getDescendants(...)
		end
	end
	if checkExist("GetPropertyChangedSignal") and not customMethods["GetPropertyChangedSignal"] then
		customMethods["GetPropertyChangedSignal"] = function(self, ...)
			return object:GetPropertyChangedSignal(...)
		end
	end
	if checkExist("getPropertyChangedSignal") and not customMethods["getPropertyChangedSignal"] then
		customMethods["getPropertyChangedSignal"] = function(self, ...)
			return object:getPropertyChangedSignal(...)
		end
	end
	if checkExist("GetFullName") and not customMethods["GetFullName"] then
		customMethods["GetFullName"] = function(self, ...)
			return object:GetFullName(...)
		end
	end
	if checkExist("getFullName") and not customMethods["getFullName"] then
		customMethods["getFullName"] = function(self, ...)
			return object:getFullName(...)
		end
	end
	if checkExist("ClearAllChildren") and not customMethods["ClearAllChildren"] then
		customMethods["ClearAllChildren"] = function(self, ...)
			return object:ClearAllChildren(...)
		end
	end
	if checkExist("clearAllChildren") and not customMethods["clearAllChildren"] then
		customMethods["clearAllChildren"] = function(self, ...)
			return object:clearAllChildren(...)
		end
	end
	if checkExist("HasTag") and not customMethods["HasTag"] then
		customMethods["HasTag"] = function(self, ...)
			return object:HasTag(...)
		end
	end
	if checkExist("hasTag") and not customMethods["hasTag"] then
		customMethods["hasTag"] = function(self, ...)
			return object:hasTag(...)
		end
	end
	if checkExist("FindFirstAncestorWhichIsA") and not customMethods["FindFirstAncestorWhichIsA"] then
		customMethods["FindFirstAncestorWhichIsA"] = function(self, ...)
			return convertToMetaInstance(object:FindFirstAncestorWhichIsA(...))
		end
	end
	if checkExist("findFirstAncestorWhichIsA") and not customMethods["findFirstAncestorWhichIsA"] then
		customMethods["findFirstAncestorWhichIsA"] = function(self, ...)
			return convertToMetaInstance(object:findFirstAncestorWhichIsA(...))
		end
	end
	if checkExist("GetActor") and not customMethods["GetActor"] then
		customMethods["GetActor"] = function(self, ...)
			return object:GetActor(...)
		end
	end
	if checkExist("getActor") and not customMethods["getActor"] then
		customMethods["getActor"] = function(self, ...)
			return object:getActor(...)
		end
	end
	if checkExist("AddTag") and not customMethods["AddTag"] then
		customMethods["AddTag"] = function(self, ...)
			return object:AddTag(...)
		end
	end
	if checkExist("addTag") and not customMethods["addTag"] then
		customMethods["addTag"] = function(self, ...)
			return object:addTag(...)
		end
	end
	if checkExist("GetTags") and not customMethods["GetTags"] then
		customMethods["GetTags"] = function(self, ...)
			return object:GetTags(...)
		end
	end
	if checkExist("getTags") and not customMethods["getTags"] then
		customMethods["getTags"] = function(self, ...)
			return object:getTags(...)
		end
	end
	if checkExist("IsAncestorOf") and not customMethods["IsAncestorOf"] then
		customMethods["IsAncestorOf"] = function(self, ...)
			return object:IsAncestorOf(...) or object:IsAncestorOf(table.pack(...)[1].___originalInstance, unpack(table.pack(...), 2))
		end
	end
	if checkExist("isAncestorOf") and not customMethods["isAncestorOf"] then
		customMethods["isAncestorOf"] = function(self, ...)
			return object:IsAncestorOf(...) or object:IsAncestorOf(table.pack(...)[1].___originalInstance, unpack(table.pack(...), 2))
		end
	end
	if checkExist("RemoveTag") and not customMethods["RemoveTag"] then
		customMethods["RemoveTag"] = function(self, ...)
			return object:RemoveTag(...)
		end
	end
	if checkExist("removeTag") and not customMethods["removeTag"] then
		customMethods["removeTag"] = function(self, ...)
			return object:removeTag(...)
		end
	end
	if checkExist("FindFirstAncestor") and not customMethods["FindFirstAncestor"] then
		customMethods["FindFirstAncestor"] = function(self, ...)
			return convertToMetaInstance(object:FindFirstAncestor(...))
		end
	end
	if checkExist("findFirstAncestor") and not customMethods["findFirstAncestor"] then
		customMethods["findFirstAncestor"] = function(self, ...)
			return convertToMetaInstance(object:findFirstAncestor(...))
		end
	end
	if checkExist("GetAttribute") and not customMethods["GetAttribute"] then
		customMethods["GetAttribute"] = function(self, ...)
			return object:GetAttribute(...)
		end
	end
	if checkExist("getAttribute") and not customMethods["getAttribute"] then
		customMethods["getAttribute"] = function(self, ...)
			return object:getAttribute(...)
		end
	end
	if checkExist("GetAttributes") and not customMethods["GetAttributes"] then
		customMethods["GetAttributes"] = function(self, ...)
			return object:GetAttributes(...)
		end
	end
	if checkExist("getAttributes") and not customMethods["getAttributes"] then
		customMethods["getAttributes"] = function(self, ...)
			return object:getAttributes(...)
		end
	end
	if checkExist("SetAttribute") and not customMethods["SetAttribute"] then
		customMethods["SetAttribute"] = function(self, ...)
			return object:SetAttribute(...)
		end
	end
	if checkExist("setAttribute") and not customMethods["setAttribute"] then
		customMethods["setAttribute"] = function(self, ...)
			return object:setAttribute(...)
		end
	end
	if checkExist("Play") and not customMethods["Play"] then
		customMethods["Play"] = function(self, ...)
			return object:Play(...)
		end
	end
	if checkExist("play") and not customMethods["play"] then
		customMethods["play"] = function(self, ...)
			return object:play(...)
		end
	end
	if checkExist("Create") and not customMethods["Create"] then
		customMethods["Create"] = function(self, ...)
			return object:Create(...)
		end
	end
	if checkExist("create") and not customMethods["create"] then
		customMethods["create"] = function(self, ...)
			return object:create(...)
		end
	end
	if checkExist("Pause") and not customMethods["Pause"] then
		customMethods["Pause"] = function(self, ...)
			return object:Pause(...)
		end
	end
	if checkExist("pause") and not customMethods["pause"] then
		customMethods["pause"] = function(self, ...)
			return object:pause(...)
		end
	end
	if checkExist("Stop") and not customMethods["Stop"] then
		customMethods["Stop"] = function(self, ...)
			return object:Stop(...)
		end
	end
	if checkExist("stop") and not customMethods["stop"] then
		customMethods["stop"] = function(self, ...)
			return object:stop(...)
		end
	end
	if checkExist("TweenPosition") and not customMethods["TweenPosition"] then
		customMethods["TweenPosition"] = function(self, ...)
			return object:TweenPosition(...)
		end
	end
	if checkExist("tweenPosition") and not customMethods["tweenPosition"] then
		customMethods["tweenPosition"] = function(self, ...)
			return object:tweenPosition(...)
		end
	end
	if checkExist("TweenSize") and not customMethods["TweenSize"] then
		customMethods["TweenSize"] = function(self, ...)
			return object:TweenSize(...)
		end
	end
	if checkExist("tweenSize") and not customMethods["tweenSize"] then
		customMethods["tweenSize"] = function(self, ...)
			return object:tweenSize(...)
		end
	end
	if checkExist("TweenSizeAndPosition") and not customMethods["TweenSizeAndPosition"] then
		customMethods["TweenSizeAndPosition"] = function(self, ...)
			return object:TweenSizeAndPosition(...)
		end
	end
	if checkExist("tweenSizeAndPosition") and not customMethods["tweenSizeAndPosition"] then
		customMethods["tweenSizeAndPosition"] = function(self, ...)
			return object:tweenSizeAndPosition(...)
		end
	end
	if checkExist("Raycast") and not customMethods["Raycast"] then
		customMethods["Raycast"] = function(self, ...)
			return object:Raycast(...)
		end
	end
	if checkExist("raycast") and not customMethods["raycast"] then
		customMethods["raycast"] = function(self, ...)
			return object:raycast(...)
		end
	end
	if checkExist("Blockcast") and not customMethods["Blockcast"] then
		customMethods["Blockcast"] = function(self, ...)
			return object:Blockcast(...)
		end
	end
	if checkExist("blockcast") and not customMethods["blockcast"] then
		customMethods["blockcast"] = function(self, ...)
			return object:blockcast(...)
		end
	end

	metaInstance = setmetatable({},
	{
		__index = function(self, index)
			if index == "___originalInstance" then return object end
			local found = table_find(customMethods, index)
			if found then
				return customMethods[index]
			else
				local inst = object[index]
				if rTypeof(inst) == "Instance" then
					return convertToMetaInstance(inst, {FixEnvinroment = true})
				else
					return inst
				end
			end
		end,
		__lt = function(self, value)
			return object < value
		end,
		__le = function(self, value)
			return object <= value
		end,
		__gc = function(self)

		end,
		__len = function(self)
			return #object
		end,
		__unm = function(self)
			return -object
		end,
		__iter = function(self)
			return next, object
		end,
		__newindex = function(self, index, value)
			if blockMethods[index] == true then
				error("Failed to set "..tostring(index).." to "..tostring(value))
			elseif rTypeof(blockMethods[index]) == "function" then
				return blockMethods[index](value)
			end
			object[index] = ismetainstance(value) and value.___originalInstance or value
		end,
		__tostring = options.Tostring or function()
			return tostring(object)
		end,
		__metatable = "Metatable is locked!",
		__eq = function(self, obj)
			return self == obj or object == obj
		end,
		__call = function(self, ...)
			return object(...)
		end,
		__concat = function(self, val)
			return object .. val
		end,
		__add = function(self, value)
			return object + value
		end,
		__sub = function(self, value)
			return object - value
		end,
		__mul = function(self, value)
			return object * value
		end,
		__div = function(self, value)
			return object / value
		end,
		__idiv = function(self, value)
			return object // value
		end,
		__mod = function(self, value)
			return object%value
		end,
		__pow = function(self, value)
			return object ^ value
		end
	})

	object.ChildAdded:Connect(function(c)
		metaInstanceChildAdded(object, metaInstance, c)
	end)

	metaInstances[metaInstance] = object

	return metaInstance
	--return object
end
-- loadstring
function metaInstanceChildAdded(object, metaInstance, c)
	if c and c.Name == "CACHEDEQ" and c:IsA("ObjectValue") then
		if object and object.Parent ~= game and object ~= game or not object then
			if rTypeof(object) == "table" and object.___originalInstance ~= game and object.___originalInstance or rTypeof(object) ~= "table" then
				if c.Value then
					local obj = c.Value:Clone()
					obj.Parent = c.Parent
					if object then
						object:Destroy()
					end
					object = obj
					obj = nil
				else
					if object then
						object:Destroy()
					end
					object = nil
				end
				metaInstances[metaInstance] = object
			end
		end
		c:Destroy()
	end
end

local function splitIntoSaveChunks(input)
	local chunks = {}

	local step = 199999
	local rep = math.round((#input/step)+0.5)

	for i=0, rep do
		table.insert(chunks, input:sub(i*step, ((i+1)*step)-1))
	end

	return chunks
end

local function identifyexecutor()
	return executor, executor_version
end
local err = function(...)
	local args = table.pack(...)
	local genStr = ""
	for i,v in pairs(args) do
		if i == #args then return end
		genStr = genStr..tostring(v)..(i == #args and "" or " ")
	end
	return error(genStr)
end
local function rs(times)
	for i=1, tonumber(times) or 1 do
		game["Run Service"].RenderStepped:Wait()
	end
end
local function gethui()
	local plr = game.Players.LocalPlayer
	local pgui = plr:WaitForChild("PlayerGui")
	local function getGui()
		for i,v in pairs(pgui:GetChildren()) do
			if v and v:IsA("ScreenGui") and not v.ResetOnSpawn then
				return v
			end
		end
	end
	local gui = getGui()
	if not gui then
		gui = pgui:WaitForChild(identifyexecutor().."LoadingGui",2) or plr.PlayerGui
	end
	coroutine.wrap(function()
		repeat rs(1) until _G._hidden_ui
		if _G._hidden_ui.Parent == plr.PlayerGui then
			while _G._hidden_ui.Parent == plr.PlayerGui do
				local gui = getGui()
				if gui then
					_G._hidden_ui.Parent = plr.PlayerGui
				end
				rs(1)
			end
		end
	end)()
	local fhui = _G._hidden_ui or gui:FindFirstChild("hui")
	local hui
	if not fhui then
		fhui = Instance.new("ScreenGui",gui)
		fhui.Enabled = false
		fhui.DisplayOrder = 999999997
		fhui.ResetOnSpawn = false
		fhui.Name = "hui"
		hui = Instance.new("Folder",fhui)
		hui.ChildAdded:Connect(function(c)
			if c and c:IsA("ScreenGui") then
				while c do
					c.DisplayOrder = math.max(999999997, c.DisplayOrder)
					c.ResetOnSpawn = false
					rs(1)
				end
			end
		end)
		_G._hidden_ui = hui
	else
		hui = typeof(_G._hidden_ui) == "Instance" and _G._hidden_ui:IsA("Folder") and _G._hidden_ui or rTypeof(_G._hidden_ui) == "Instance" and not _G._hidden_ui:IsA("Folder") and _G._hidden_ui:FindFirstChildOfClass("Folder")
	end
	return hui
end
local httpGet = function(self,url)
	local res = _G.HttpResults()
	if res[url] then return res[url] end
	if _G.HTTPGET then
		return _G.HTTPGET(url)
	end
	warn("Not loaded")
	--return CEREQUEST("httpGet", url, "_HTTP_GET_REQUEST")
end
local Game, coreGui
coreGui = convertToMetaInstance(game.Players.LocalPlayer.PlayerGui,{
	CustomMethods = {
		Name = "CoreGui",
		GetFullName = function()
			return "CoreGui"	
		end,
		getFullName = function()
			return "CoreGui"
		end,
		Parent = Game,
		ClassName = "CoreGui",
		Version = 0,
		SelectionImageObject = nil,
		IsA = function(self, class)
			if self == coreGui and class == "CoreGui" then return true end
			return self:IsA(class)
		end,
		isA = function(self, class)
			if self == coreGui and class == "CoreGui" then return true end
			return self:IsA(class)
		end,
	},
	BlockMethods = {["Name"]=true,["Parent"]=true},
	Tostring = function()
		return "CoreGui"
	end,
	FixEnvinroment = true
})
local userInputService = convertToMetaInstance(game.UserInputService,{
	CustomMethods = {
		Name = "UserInputService",
		GetFullName = function()
			return "UserInputService"	
		end,
		getFullName = function()
			return "UserInputService"
		end,
		Parent = Game,
		ClassName = "UserInputService"
	},
	BlockMethods = {["Name"]=true,["Parent"]=true},
	Tostring = function()
		return "UserInputService"
	end,
	FixEnvinroment = true
})
local origGame = game
Game = convertToMetaInstance(game, {
	CustomMethods = {
		HttpGet = httpGet,
		HttpGetAsync = httpGet,

		CoreGui = coreGui,
		GetService = function(self, name)
			if name == "CoreGui" then return coreGui end
			--if name == "UserInputService" then return userInputService end
			return origGame:GetService(name)
		end,
		getService = function(self, name)
			if name == "CoreGui" then return coreGui end
			--if name == "UserInputService" then return userInputService end
			return origGame:GetService(name)
		end,
		service = function(self, name)
			if name == "CoreGui" then return coreGui end
			--if name == "UserInputService" then return userInputService end
			return origGame:service(name)
		end,
		getChildren = function(self)
			local dscs = origGame:GetChildren()
			dscs[#dscs+1] = coreGui

			return dscs
		end,
		GetChildren = function(self)
			local dscs = origGame:GetChildren()
			dscs[#dscs+1] = coreGui

			return dscs
		end,
		getDescendants = function(self)
			local dscs = origGame:GetDescendants()
			dscs[#dscs+1] = coreGui

			return dscs
		end,
		GetDescendants = function(self)
			local dscs = origGame:GetDescendants()
			dscs[#dscs+1] = coreGui

			return dscs
		end,
		Shutdown = function(self)
			while true do

			end
		end,
	},
	Tostring = function()
		return tostring(origGame)
	end
})
local game = Game
local unparsableObjects = {}
local clone
local function table_clone(t)
	if typeof(t) ~= "table" then return clone(t) end

	local newT = {}
	for i,v in pairs(t) do
		newT[i] = v
	end

	return newT
end
local function clonefunction(func) -- luau made this 
	local isc = debug.info(func, "s") == "[C]"
	local newfunc = nil
	if isc == true then
		newfunc = genv.newcclosure(func)
	else
		newfunc = function(...)
			return func(...)
		end
	end
	return newfunc
end
local function getscripthash(script) -- idk who made this
	return script:GetHash()
end
local function request(options) -- luau made this
	assert(type(options) == "table", "invalid argument #1 to 'request' (table expected, got " .. type(options) .. ") ", 2)
	assert(type(options.Url) == "string", "invalid URL (string expected, got " .. type(options.Url) .. ") ", 2)
	if options.Method then 
		assert(type(options.Method) == "string", "invalid URL (string expected, got " .. type(options.Method) .. ") ", 2)
	end
	if options.Body then 
		assert(type(options.Body) == "string", "invalid URL (string expected, got " .. type(options.Body) .. ") ", 2)
	end

	options.CachePolicy = Enum.HttpCachePolicy.None
	options.Priority = 5
	options.Timeout = 15000

	options.Url = options.Url:gsub('roblox.com','roproxy.com')
	local heads
	if options.Method then options.Method = options.Method:upper() end
	for t,v in options do
		if t:lower() == "headers" then
			heads = v
			break
		end
	end

	if not heads then
		heads = {}
	end
	options.Headers = heads
	options.Headers["Fingering" .. "-Fingerprint"] = "FINGERME"

	local Event = Instance.new("BindableEvent")
	local game = game
	local RequestInternal = game:GetService("HttpService").RequestInternal
	local Request = RequestInternal(game:GetService("HttpService"), options)
	local Start = Request.Start
	local Response
	Start(Request, function(state, response)
		Response = response
		Event:Fire()
	end)
	Event.Event:Wait()
	return Response
end

function clone(obj)
	if ismetainstance(obj) then return convertToMetaInstance(obj, {FixEnvinroment = true}) end

	if rTypeof(obj) == "table" then
		local copy = {}
		for i,v in pairs(obj) do
			copy[i] = v
		end
		return copy
	elseif rTypeof(obj) == "Instance" then
		if table_find(unparsableObjects, obj) then
			print(obj,"is not a valid member to be cloned.")
			return obj
		else
			return convertToMetaInstance(obj, {FixEnvinroment = true})
		end
	elseif rTypeof(obj) == "function" then
		return clonefunction(obj)
	elseif rTypeof(obj) == "number" then
		return tostring(obj)
	elseif rTypeof(obj) == "string" then
		return obj.." "
	elseif rTypeof(obj) == "boolean" then
		return obj and "true" or nil
	else
		return obj
	end
end
local function cloneref(...)
	local objs = table.pack(...)
	local res = {}
	for i,v in pairs(objs) do
		res[#res+1] = clone(v)
	end
	return unpack(res)
end
local function printidentity(...)
	local args = table.pack(...)
	if #args == 0 then
		print("Current identity is", identity)
	else
		local arg = args[1]
		if rTypeof(arg) == "string" or rTypeof(arg) == "number" then
			print(arg, identity)
		else
			print("(null)", identity)
		end
	end
end
local function getReal(...)
	local real = {}
	local fake = table.pack(...)

	for i,v in pairs(fake) do
		real[i] = ismetainstance(v) and v.___originalInstance or v
	end

	fake = nil
	return unpack(real)
end
local function gotErrorOutput(argument)
	return (typeof(argument) == "Instance" and argument.ClassName or rTypeof(argument))
end
local function expection(argidx,ex,got)
	if rTypeof(got) == "Instance" then
		if not got:IsA(ex) then
			err("Argument "..argidx..": "..typeof(ex).." expected, got "..got.ClassName)
		end
	else
		if rTypeof(got) ~= ex then
			err("Argument "..argidx..": "..ex.." expected, got "..typeof(got))
		end
	end
end
local function fireproximityprompt(pp)
	pp = getReal(pp)
	expection(1,"ProximityPrompt",pp)
	local hd = pp.HoldDuration
	local mad = pp.MaxActivationDistance
	local rlof = pp.RequiresLineOfSight
	local cf = workspace.CurrentCamera.CFrame

	local tr = false
	local trcon = pp.Triggered:Connect(function()
		tr = true
	end)

	pp.RequiresLineOfSight = false
	pp.HoldDuration = 0
	pp.MaxActivationDistance = math.huge

	local function getPos(obj)
		if not obj then return end
		local function get(obj)
			if obj:IsA("Model") or obj:IsA("BasePart") then return obj:GetPivot().Position end
			if obj:IsA("Attachment") then return obj.WorldPosition end
			return nil
		end
		local got = get(obj)
		if not got then
			got = get(obj:FindFirstAncestorOfClass("Model")) or get(obj:FindFirstAncestorOfClass("BasePart")) or get(obj:FindFirstAncestorOfClass("Attachment"))
			if not got then return end
		end
		return got
	end

	local function fire()
		pp:InputHoldBegin()
		pp:InputHoldEnd()
	end

	fire()

	if not tr then
		local pos = getPos(pp.Parent) or (cf.Position + cf.LookVector)
		workspace.CurrentCamera.CFrame = CFrame.lookAt(cf.Position,pos)
		rs(2)
		fire()
		rs(1)
		workspace.CurrentCamera.CFrame = cf
	end

	pp.RequiresLineOfSight = rlof
	pp.HoldDuration = hd
	pp.MaxActivationDistance = mad

	trcon:Disconnect()
end
local function firetouchinterest(a,b,touching)
	a, b = getReal(a, b)
	expection(1,"number",touching)
	touching = touching == 1
	expection(2,"BasePart",a)
	expection(3,"BasePart",b)

	if not touching then
		local c = b
		local ct = c.CanTouch
		c.CanTouch = false
		rs(2)
		c.CanTouch = ct
	else
		local pp = b:GetPivot()
		local t,c,an = b.Transparency,b.CanCollide,b.Anchored
		b:PivotTo(a:GetPivot())
		b.Transparency = 1
		b.CanCollide = false
		b.Anchored = true
		rs(2)
		b.Transparency = t
		b.CanCollide = c
		b.Anchored = an
		b:PivotTo(pp)
	end
end
local function randomstring(len)
	len = len or math.random(10,25)
	local gen = ""
	for i=1, len do
		gen = gen..string.char(math.random(32,125))
	end
	return gen
end
local function protect_gui(gui)
	expection(1,"ScreenGui",gui)

	gui.Name = randomstring()
end

local function useDot(str:string)
	local allowed = {}
	for i=48,57 do
		allowed[string.char(i)] = true
	end
	for i=97,122 do
		allowed[string.char(i)] = true
	end

	local thruDot = true
	local genS = str

	for i,v in pairs(str:split("")) do
		if not allowed[v] and not allowed[v:lower()] then
			thruDot = false
		end
	end

	genS = genS:gsub("\\","\\\\"):gsub("\"","\\\""):gsub("\10","\\10"):gsub("\13","\\13")

	return thruDot, genS
end

local function getPath(obj)
	if rTypeof(obj) == "nil" then return "nil" end
	local cobj, gen, a, max = obj, "", 0, 10000

	while cobj and cobj.Parent ~= game or a ~= max do
		if cobj == game or not cobj then break end
		local dot, form = useDot(cobj.Name)
		gen = (dot and "." or "[\"")..form..(dot and "" or "\"]")..gen
		cobj = cobj.Parent
		a += 1
	end

	return a == max and "nil" or obj == game and "game" or gen == "" and "nil" or ("game"..gen):gsub("game[\""..table.pack(useDot(game.Name))[2].."\"]","game"):gsub("game%."..game.Name,"game")
	--return obj and table.pack("game."..obj:GetFullName():gsub("\10","\\n"):gsub("\13","\\n"))[1] or "nil"
end
function argToString(arg)
	if rTypeof(arg) == "function" then
		local res 
		local s = pcall(function()
			res = arg()
		end)
		if res then
			return "function(...) return "..tableToString(res).." end"
		elseif not s then
			return "function(...) --[[Bad function]] end"
		else
			return "function(...) return end"
		end
	end
	local Arg = arg
	local type = typeof(arg)
	local arg = tostring(arg)
	if type ~= "number" and type ~= "boolean" and type ~= "string" and type ~= "nil" and type ~= "table" and type ~= "function" then
		return type..".new("..arg..")"
	else
		if type == "string" then
			local isMultiline = arg:find("\10") ~= nil
			local start = (isMultiline and "[[" or "\"")
			local mid = arg
			local End = (isMultiline and "]]" or "\"")
			if isMultiline then
				mid = mid:gsub("%[%[", "\\[\\["):gsub("%]%]", "\\]\\]")
			else
				arg = arg:gsub("\"","\\\"")
			end
			return start..mid..End
		elseif type ~= "table" then
			if type == "Instance" then
				return getPath(Arg)
			else
				return arg
			end
		elseif type == "table" then
			return tableToString(Arg)
		end
	end
end

function addTabs(amnt)
	return string.rep("	",amnt)
end

function tableToString(table,index)
	local result
	local index = index or 1
	if rTypeof(table) ~= "table" then
		result = argToString(table)
	else
		result = "{\10"
		for i,v in pairs(table) do
			if rTypeof(i) ~= "table" then
				if rTypeof(v) ~= "table" then
					result = result..addTabs(index).."["..argToString(i).."] = "..argToString(v)..",\10"
				else
					result = result..addTabs(index).."["..argToString(i).."] = "..tableToString(v,index+1)..",\10"
				end
			else
				if rTypeof(v) ~= "table" then
					result = result..addTabs(index).."[\10"..addTabs(index+1)..tableToString(i,index+2).."] = "..argToString(v)..",\10"
				else
					result = result..addTabs(index).."[\10"..addTabs(index+1)..tableToString(i,index+2).."] = "..tableToString(v,index+1)..",\10"
				end
			end
		end
		if index == 1 then
			result = result:sub(0,#result-2).."\10}"
		else
			result = result:sub(0,#result-2).."\10"..addTabs(index-1).."}"
		end
		if not result:match("{") then
			result = "{}"
		end
	end
	return result
end

local ftdmsg = "--Failed to decompile"
local prefix = "--"..identifyexecutor().."'s decompiler\10--Made by xinfernusx\10\10"
local denied = "--Decompiling that is denied."

local function tryWeakDecompile(script)
	local src
	pcall(function()
		src = script.Source
	end)
	return src or script:GetAttribute("src") or script:GetAttribute("Source") or script:GetAttribute("Src") or script:GetAttribute("source") or ftdmsg
end
local function queueonteleport() end
local function isEmptyString(str)
	return #(str:gsub("	",""):gsub("\10",""):gsub("\13",""):gsub(" ","")) == 0
end
local function extractId(str)
	if not str then return end

	local s = str:split("/")
	for i,v in pairs(s) do
		if tonumber(v) then
			return tonumber(v)
		end
	end

	local s = str:split("\\")
	for i,v in pairs(s) do
		if tonumber(v) then
			return tonumber(v)
		end
	end
end
local function LoadLocalAsset(self,id)
	local att
	id = "rbxassetid://"..tostring(id)
	local function try(func)
		if att then return att end
		local res
		pcall(function()
			res = func(self,id)
		end)
		if not res then
			pcall(function()
				res = func(self,extractId(id))
			end)
		end
		return res or att
	end

	pcall(function()att=try(game.GetObjects)end)
	pcall(function()att=try(game.InsertService.LoadAsset)end)
	pcall(function()att=try(game.InsertService.loadAsset)end)
	pcall(function()att=try(game.InsertService.LoadLocalAsset)end)
	pcall(function()att=try(game.InsertService.LoadAssetVersion)end)

	return att
end
local function findTable(t,o)
	local f = false
	for i,v in pairs(t) do
		f = f or i == o or v == o
	end
	return f
end
local function decompile(script)
	local path = getPath(ismetainstance(script) and script.___originalInstance or script)
	local base = prefix.."--Path: "..path.."\10--Script:\10\10"
	if rTypeof(script) ~= "Instance" or (not script:IsA("ModuleScript") and not script:IsA("Script") and not script:IsA("LocalScript")) then
		return base.."--Unallowed Instance type (LuaSourceContainer expected)"
	end
	if not script:IsA("ModuleScript") then
		return base.."--Sorry, but that script decompiler only decompiles module scripts!"
	end
	if findTable(tpData,script) then return base..denied end
	local s,e = pcall(function()
		local decompilingText = _G.decompilingText
		if not _G.decompilingGui or not _G.decompilingText then
			local decompilingText1 = _G.decompilingGui or Instance.new("ScreenGui") --DecompilingText
			decompilingText1.Parent = gethui()
			decompilingText1.Name = "DecompilingText"
			_G.decompilingGui = decompilingText1
			local obj_ID2D1 = _G.decompilingText or Instance.new("TextLabel") --TextLabel
			obj_ID2D1.Parent = decompilingText1
			_G.decompilingText = obj_ID2D1
			obj_ID2D1.BorderSizePixel = 0
			obj_ID2D1.FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			obj_ID2D1.AnchorPoint = Vector2.new(0.5, 0.5)
			obj_ID2D1.TextScaled = true
			obj_ID2D1.Size = UDim2.new(0.5, 0, 0.05000000074505806, 0)
			obj_ID2D1.TextColor3 = Color3.new(1, 1, 1)
			obj_ID2D1.BorderColor3 = Color3.new(0, 0, 0)
			obj_ID2D1.BackgroundColor3 = Color3.new(1, 1, 1)
			obj_ID2D1.BackgroundTransparency = 1
			obj_ID2D1.Position = UDim2.new(0.5, 0, 0.800000011920929, 0)
			decompilingText = obj_ID2D1
		end
		decompilingText.Text = "Decompiling "..path.."..."
		task.wait(0.1)
		local s, r = pcall(function()
			return require(ismetainstance(script) and script.___originalInstance or script)
		end)
		decompilingText.Text = ""
		if not s then
			return base..ftdmsg
		else
			return base.."return "..tableToString(r)
		end
	end)
	return e
end

local localFileSys = {
	["_GClassName"] = "_LocalFileSystem",
	[1] = {
		["Clipboard"] = {},
		["Files"] = {}
	}
}

_G[localFileSys._GClassName] = cloneref(localFileSys[1])

local function writefile(filename, val)
	expection(1,"string",filename)
	expection(2,"string",val)
	_G[localFileSys._GClassName].Files[filename] = val
end

local function readfile(filename)
	expection(1,"string",filename)
	return _G[localFileSys._GClassName].Files[filename]
end

local function makefolder(name)
	expection(1,"string",name)
	writefile(name, "_FOLDERCLASS")
end

local function isfolder(name)
	expection(1,"string",name)
	return readfile(name) == "_FOLDERCLASS"
end

local function isfile(name)
	expection(1,"string",name)
	if isfolder(name) then
		return false
	else
		return _G[localFileSys._GClassName].Files[name] ~= nil
	end
end

local function deletefile(filename)
	expection(1,"string",filename)
	_G[localFileSys._GClassName].Files[filename] = nil
end

local function toclipboard(text)
	expection(1, "string", text)
	table.insert(_G[localFileSys._GClassName].Clipboard, text)
end

_G._MaximizeBind = "V"

local function setMaximizeBind(bind)
	if rTypeof(bind) == "EnumItem" then
		if bind.EnumType ~= Enum.KeyCode then error("Argument 1: EnumItem.KeyCode/string expected, got "..tostring(bind.EnumType)) end
		_G._MaximizeBind = bind.Name
	elseif rTypeof(bind) == "string" and Enum.KeyCode[bind] then
		_G._MaximizeBind = bind
	elseif rTypeof(bind) == "string" and not Enum.KeyCode[bind] then
		error("Failed to set maximize bind:\10KeyCode "..bind.." is not exist!")
	else
		error("Argument 1: EnumItem.KeyCode/string expected, got "..(typeof(bind) == "Instance" and bind.Name or rTypeof(bind)))
	end
end

local m = 100
local function playaudio(id)
	local ID = tonumber(id) and "rbxassetid://"..id or type(id) == "string" and id
	if not ID then error("Invalid sound id.") end
	local audio = Instance.new("Sound", game:GetService("ReplicatedStorage"))
	audio.SoundId = ID
	local e = 0
	repeat task.wait(0.1) e += 1 until audio.IsLoaded or e == m
	if e == m then error("Failed to load the audio.") end
	audio:Play()
	task.wait(0.1+audio.TimeLength)
	audio:Destroy()
end
local function playloopedaudio(id)
	local ID = tonumber(id) and "rbxassetid://"..id or type(id) == "string" and id
	if not ID then error("Invalid sound id.") end
	local audio = Instance.new("Sound", game:GetService("ReplicatedStorage"))
	audio.SoundId = ID
	local e = 0
	repeat task.wait(0.1) e += 1 until audio.IsLoaded or e == m
	if e == m then error("Failed to load the audio.") end
	audio:Play()
	task.wait(0.1+audio.TimeLength)
	audio:Destroy()
end
local function stopaudio(id)
	local ID = tonumber(id) and "rbxassetid://"..id or type(id) == "string" and id
	if not ID then error("Invalid sound id.") end
	local audio
	for i,v in pairs(game.ReplicatedStorage:GetChildren()) do
		if v and v:IsA("Sound") and v.SoundId == ID then
			v.Playing = false
		end
	end
end
local function resumeaudio(id)
	local ID = tonumber(id) and "rbxassetid://"..id or type(id) == "string" and id
	if not ID then error("Invalid sound id.") end
	local audio
	for i,v in pairs(game.ReplicatedStorage:GetChildren()) do
		if v and v:IsA("Sound") and v.SoundId == ID then
			v.Playing = true
		end
	end
end
local function audiolooped(id, looped)
	local ID = tonumber(id) and "rbxassetid://"..id or type(id) == "string" and id
	if not ID then error("Invalid sound id.") end
	local audio
	for i,v in pairs(game.ReplicatedStorage:GetChildren()) do
		if v and v:IsA("Sound") and v.SoundId == ID then
			v.Looped = looped
		end
	end
end
local function removeaudio(id)
	local ID = tonumber(id) and "rbxassetid://"..id or type(id) == "string" and id
	if not ID then error("Invalid sound id.") end
	local audio
	for i,v in pairs(game.ReplicatedStorage:GetChildren()) do
		if v and v:IsA("Sound") and v.SoundId == ID then
			v:Destroy()
		end
	end
end

local function isrbxactive(func)
	return true
end

local function setreadonly(t, ro)
	if ro then
		table.freeze(t)
	else
		error("idk how to unfreeze tables")
	end
end

local function isreadonly(t)
	return table.isfrozen(t) or env[t]
end

local function getscripts()
	local scripts = {}

	for i,v in pairs(origGame:GetDescendants()) do
		if v and (v:IsA("ModuleScript") or v:IsA("LocalScript")) then
			table.insert(scripts, v)
		end
	end

	return scripts
end
local function getrunningscripts()
	local scripts = getscripts()
	local runningscritps = {}

	for i,v in pairs(scripts) do
		if v and (v:IsA("ModuleScript") or v.Enabled) then
			table.insert(runningscritps, v)
		end
	end

	return runningscritps
end

local printt = function(...)
	local a = table.pack(...)
	local b = {}
	for i,v in pairs(a) do
		b[i] = tostring(v)
	end
	local s = table.concat(b," ")
	if _G.NOTIF and #s <= protectedLimit then
		_G.NOTIF.print(s,5)
	end
	print(s)
end
local warnn = function(...)
	local a = table.pack(...)
	local b = {}
	for i,v in pairs(a) do
		b[i] = tostring(v)
	end
	local s = table.concat(b," ")
	if _G.NOTIF and #s <= protectedLimit then
		_G.NOTIF.warn(s,5)
	end
	warn(s)
end
local errorr = function(cont,lvl)
	if _G.NOTIF and #cont <= protectedLimit then
		_G.NOTIF.error(cont,5)
	end
	error(cont,lvl)
end
local infoo = function(...)
	local a = table.pack(...)
	local b = {}
	for i,v in pairs(a) do
		b[i] = tostring(v)
	end
	local s = table.concat(b," ")
	if _G.NOTIF and #s <= protectedLimit then
		_G.NOTIF.info(s,5)
	end
	game.TestService:Message(s)
end

local luaEnv = {
	game=Game,
	Instance=Instance,
	type=type,
	typeof=typeof,
	wait=wait,
	workspace=workspace,
	Wait=wait,
	Workspace=workspace,
	Enum=Enum,
	ElapsedTime=getFunc("elapsedTime"),
	elapsedTime=getFunc("elapsedTime"),
	require=require,
	Random=Random,
	RaycastParams=RaycastParams,
	Region3=Region3,
	Ray=Ray,
	Rect=Rect,
	RotationCurveKey=RotationCurveKey,
	Region3int16=Region3int16,
	rawget=rawget,
	rawlen=rawlen,
	rawset=rawset,
	rawequal=rawequal,
	task=task,
	TweenInfo=TweenInfo,
	tostring=tostring,
	tonumber=tonumber,
	table=table,
	time=time,
	tick=tick,
	ypcall=pcall,
	UDim2=UDim2,
	utf8=utf8,
	unpack=unpack,
	UDim=UDim,
	UserSettings=UserSettings,
	ipairs=ipairs,
	os=os,
	OverlapParams=OverlapParams,
	pairs=pairs,
	pcall=pcall,
	plugin=plugin,
	PhysicalProperties=PhysicalProperties,
	PathWaypoint=PathWaypoint,
	printidentity=printidentity,
	Axes=Axes,
	assert=assert,
	script=nil,
	string=string,
	select=select,
	settings=settings,
	spawn=spawn,
	Secret=Secret,
	shared=shared,
	setfenv=setfenv,
	SharedTable=SharedTable,
	setmetatable=setmetatable,
	Spawn=spawn,
	Stats=getFunc("stats"),
	stats=getFunc("stats"),
	DateTime=DateTime,
	debug=debug,
	DockWidgetPluginGuiInfo=DockWidgetPluginGuiInfo,
	delay=delay,
	Delay=delay,
	Font=Font,
	Faces=Faces,
	File=File,
	FloatCurveKey=FloatCurveKey,
	getfenv=getfenv,
	getmetatable=getmetatable,
	gcinfo=gcinfo,
	Game=Game,
	loadstring=loadstring,
	xpcall=xpcall,
	CFrame=CFrame,
	Color3=Color3,
	coroutine=coroutine,
	ColorSequenceKeypoint=ColorSequenceKeypoint,
	ColorSequence=ColorSequence,
	CatalogSearchParams=CatalogSearchParams,
	collectgarbage=getFunc("collectgarbage"),
	Vector3=Vector3,
	Vector2=Vector2,
	Vector2int16=Vector2int16,
	Vector3int16=Vector3int16,
	Version=getFunc("version"),
	version=getFunc("version"),
	BrickColor=BrickColor,
	bit32=bit32,
	buffer=buffer,
	newproxy=newproxy,
	NumberSequence=NumberSequence,
	NumberSequenceKeypoint=NumberSequenceKeypoint,
	NumberRange=NumberRange,
	next=next,
	math=math,
	_G={},
	_VERSION=_VERSION,
	print=printt,
	warn=warnn,
	error=errorr,
	rprint=print,
	rwarn=warn,
	rerror=error
}

local checkEnv = {}
local cindex = 1
for _,v in pairs(luaEnv) do
	checkEnv[cindex] = v
	cindex += 1
end

local senvs = {}
local function getsenv(inst)
	expection(1, "LuaSourceContainer", inst)

	if not inst:IsA("LocalScript") and not inst:IsA("ModuleScript") then return end

	luaEnv.script = inst

	return luaEnv
end

local renv = {}

local function setthreadidentity(num)
	expection(1, "Number", num)
	identity = math.clamp(num, 0, 10)

	if identity <= 2 then
		env.game = origGame
		getgenv().game = origGame
		getfenv().game = origGame
	else
		env.game = game
		getgenv().game = game
		getfenv().game = game
	end
end

local function getthreadidentity()
	return identity
end

local function getRealType(a)
	return typeof(a) == "table" and a.___originalInstance and "Instance" or rTypeof(a)
end

local function getcallingscript() --vxsty made this
	local s = debug.info(1, 's')
	for i, v in next, game:GetDescendants() do
		if v:GetFullName() == s then return v end
	end
	return nil
end

local function hookmetamethod(object, method, callback)
	local meta = getmetatable(object)
	if meta and not hooked[meta] and meta[method] then
		local originalMethod = meta[method]
		local new = {}
		for k, v in pairs(meta) do
			new[k] = v
		end
		new[method] = function(...)
			return callback(originalMethod, ...)
		end
		setmetatable(object, new)
		hooked[new] = true
	end
	return function()
		return meta and meta[method] or nil
	end
end

local function compareinstances(...)
	local args = table.pack(...)
	if #args <= 1 then
		if args[1] then
			if getRealType(args[1]) ~= "Instance" then
				return false
			end
		end
		return true
	end

	local originalInstance = getReal(args[1])

	for i=2, #args do
		local v = args[i]
		if getRealType(v) ~= "Instance" then
			return false
		end
		if getReal(v) ~= originalInstance then
			return false
		end
	end

	return true
end

local cClosures = {}

local function iscclosure(f)
	expection(1, "function", f)
	return cClosures[f] == true
end

local function islclosure(f)
	expection(1, "function", f)
	return not cClosures[f]
end

local checkenv = {}
local function isexecutorclosure(f)
	expection(1, "function", f)
	if table_find(checkEnv, f) then
		return false
	end
	return (iscclosure(f) or table_find(checkenv, f)) and not islclosure(f) or true
end

local function newcclosure(f)
	expection(1, "function", f)
	local cf = clonefunction(f)
	cClosures[cf] = true
	return cf
end

local function appendfile(filename, addcontents)
	local c = readfile(filename)
	if not c then return end
	expection(2, "string", addcontents)
	writefile(filename, c..addcontents)
end

local function loadfile(filename)
	return newLoadstring(readfile(filename))
end

local function dofile(filename, ...)
	return loadfile(filename)(...)
end

local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

local function base64encode(data)
	return ((data:gsub('.', function(x)
		local r,b='',x:byte()
		for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
		return r
	end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
		if (#x < 6) then return '' end
		local c=0
		for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
		return b:sub(c+1,c+1)
	end)..({ '', '==', '=' })[#data%3+1])
end

local function base64decode(data)
	data = string.gsub(data, '[^'..b..'=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then return '' end
		local r,f='',(b:find(x)-1)
		for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
		return r
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c=0
		for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
		return string.char(c)
	end))
end

local function getc(str)
	local sum = 0
	for i,v in pairs(str:split("")) do
		sum += string.byte(sum)
	end

	return sum
end

local undefined = function()end

local crypt
crypt = {
	base64encode = base64encode,
	base64decode = base64decode,
	generatebytes = function(len)
		expection(1, "number", len)
		local bytes = {}
		local generateByte
		function generateByte()
			local skipBytes = {2, 12, 127}
			local b = math.random(1, 255)
			if table.find(skipBytes, b) then
				return generateByte()
			end
			return b
		end
		for i=1, len do
			table.insert(bytes, string.char(generateByte()))
		end
		return crypt.base64encode(table.concat(bytes, ""))
	end,
	base64 = {
		encode = base64encode,
		decode = base64decode
	},
	base64_encode = base64encode,
	base64_decode = base64decode,
	encrypt = function(str, key, iv, cbc)
		iv = iv or "lol"

		local byteChange = (getc(cbc)+getc(iv)+getc(key))%7
		local res = ""
		for _,v in pairs(str:split("")) do
			res = res..(string.char(string.byte(v)+byteChange))
		end

		return res, iv
	end,
	decrypt = function(str, key, iv, cbc)
		local bC = (getc(cbc)+getc(iv)+getc(key))%7
		local res = ""
		for _,v in pairs(str:split("")) do
			res = res..(string.char(string.byte(v)-bC))
		end
		return res
	end,
	generatekey = function()
		return crypt.generatebytes(32)
	end,
	hash=undefined
}

local function getscriptclosure(m)
	expection(1, "ModuleScript", m)
	return function()
		return table_clone(require(metaInstances[m] or m))
	end
end

local function isscriptable(instance, property_name)
	local ok, Result = xpcall(instance.GetPropertyChangedSignal, function(result)
		return result
	end, instance, property_name)

	return ok or not string.find(Result, "scriptable", nil, true)
end

local function getloadedmodules()
	local modules = {}
	for i,v in pairs(getscripts()) do
		if v:IsA("ModuleScript") then
			table.insert(modules, v)
		end
	end
	return modules
end

local function listfiles(folder)
	expection(1, "string", folder)
	if not isfolder(folder) then error(folder.." is not folder!") end

	local files = {}
	for i,v in pairs(_G[localFileSys._GClassName].Files) do
		if i:sub(1, #folder+1) == folder.."/" then
			table.insert(files, i)
		end
	end

	return files
end

local cache = {
	iscached = function(p)
		expection(1, "Instance", p)
		return not p:GetAttribute("_CACHED")
	end,
	invalidate = function(p)
		expection(1, "Instance", p)
		p:SetAttribute("_CACHED", true)
	end,
	replace = function(a, b)
		if rTypeof(a) == "Instance" and not a:GetAttribute("_CACHECONNECTION") then
			a:SetAttribute("_CACHECONNECTION", true)
			a.ChildAdded:Connect(function(c)
				metaInstanceChildAdded(a,true,c)
			end)
		end
		local eq = Instance.new("ObjectValue", (typeof(a) == "table" and a.___originalInstance or rTypeof(a) == "Instance" and a or nil))
		eq.Name = "CACHEDEQ"
		eq.Value = (typeof(b) == "table" and b.___originalInstance or rTypeof(b) == "Instance" and b or nil)
	end,
}

local function checkcaller()
	return true
end

local function getcallbackvalue(i, v)
	expection(1, "Instance", i)
	expection(2, "string", v)

	return i[v]
end

local Drawing = {}

local BaseDrawingProperties = setmetatable({
	Visible = false,
	Color = Color3.new(),
	Transparency = 0
}, {
	__add = function(tbl1, tbl2)
		local new = {}
		for i, v in next, tbl1 do
			new[i] = v
		end
		for i, v in next, tbl2 do
			new[i] = v
		end
		return new
	end
})

local fonts = {
	[0] = Enum.Font.SourceSans,
	[1] = Enum.Font.Arcade,
	[2] = Enum.Font.Code,
	[3] = Enum.Font.Michroma
}
local drawings = {}
local renderUI = Instance.new("ScreenGui", gethui())
renderUI.DisplayOrder = 999999999
renderUI.Name = "Drawings"
renderUI.ResetOnSpawn = false
renderUI.IgnoreGuiInset = true

local function drawLine(UI, z)
	local LineProperties = ({
		To = Vector2.new(),
		From = Vector2.new(),
		Thickness = 1,
	} + BaseDrawingProperties)

	local LineFrame = Instance.new("Frame")
	LineFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	LineFrame.BorderSizePixel = 0

	LineFrame.BackgroundColor3 = LineProperties.Color
	LineFrame.Visible = LineProperties.Visible
	LineFrame.BackgroundTransparency = LineProperties.Transparency
	LineFrame.ZIndex = tonumber(z) or LineFrame.ZIndex

	LineFrame.Parent = UI

	local mt = setmetatable({}, {
		__newindex = (function(self, Property, Value)
			if (Property == "To") then
				local To = Value
				local Direction = (To - LineProperties.From)
				local Center = (To + LineProperties.From) / 2
				local Distance = Direction.Magnitude
				local Theta = math.atan2(Direction.Y, Direction.X)

				LineFrame.Position = UDim2.fromOffset(Center.X, Center.Y)
				LineFrame.Rotation = math.deg(Theta)
				LineFrame.Size = UDim2.fromOffset(Distance, LineProperties.Thickness)

				LineProperties.To = To
			end
			if (Property == "From") then
				local From = Value
				local Direction = (LineProperties.To - From)
				local Center = (LineProperties.To + From) / 2
				local Distance = Direction.Magnitude
				local Theta = math.atan2(Direction.Y, Direction.X)

				LineFrame.Position = UDim2.fromOffset(Center.X, Center.Y)
				LineFrame.Rotation = math.deg(Theta)
				LineFrame.Size = UDim2.fromOffset(Distance, LineProperties.Thickness)


				LineProperties.From = From
			end
			if (Property == "Visible") then
				LineFrame.Visible = Value
				LineProperties.Visible = Value
			end
			if (Property == "Thickness") then
				Value = Value < 1 and 1 or Value

				local Direction = (LineProperties.To - LineProperties.From)
				local Distance = Direction.Magnitude

				LineFrame.Size = UDim2.fromOffset(Distance, Value)

				LineProperties.Thickness = Value
			end
			if (Property == "Transparency") then
				LineFrame.BackgroundTransparency = Value
				LineProperties.Transparency = Value
			end
			if (Property == "Color") then
				LineFrame.BackgroundColor3 = Value
				LineProperties.Color = Value 
			end
		end),
		__index = (function(self, Property)
			if (Property == "Remove" or Property == "Destroy") then
				return (function()
					LineFrame:Destroy()
				end)
			end
			return LineProperties[Property]
		end)
	})

	metaInstances[mt] = true
	table.insert(drawings, mt)
	return mt
end

Drawing.new = function(Type, UI)
	UI = typeof(UI) == "Instance" and UI:IsA("ScreenGui") and UI or renderUI

	if (Type == "Line") then
		return drawLine(UI)
	end

	if (Type == "Circle") then
		local CircleProperties = ({
			Radius = 150,
			Filled = false,
			Position = Vector2.new(),
			Thickness = 1,
		} + BaseDrawingProperties)

		local CircleFrame = Instance.new("Frame")

		CircleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		CircleFrame.BorderSizePixel = 0

		CircleFrame.BackgroundColor3 = CircleProperties.Color
		CircleFrame.Visible = CircleProperties.Visible
		CircleFrame.BackgroundTransparency = CircleProperties.Transparency

		local Corner = Instance.new("UICorner", CircleFrame)
		Corner.CornerRadius = UDim.new(1, 0)
		CircleFrame.Size = UDim2.new(0, CircleProperties.Radius, 0, CircleProperties.Radius)

		CircleFrame.Parent = UI

		local FilledStroke = Instance.new("UIStroke", CircleFrame)
		FilledStroke.Enabled = false

		local mt = setmetatable({}, {
			__newindex = (function(self, Property, Value)
				if (Property == "Radius") then
					CircleProperties.Radius = Value
					CircleFrame.Size = UDim2.new(0, CircleProperties.Radius - (Value and 0 or CircleProperties.Thickness), 0, CircleProperties.Radius - (Value and 0 or CircleProperties.Thickness))
				end
				if (Property == "Position") then
					CircleFrame.Position = UDim2.new(0, Value.X, 0, Value.Y)
				end
				if (Property == "Filled") then
					CircleFrame.BackgroundTransparency = Value and 0 or 1
					CircleProperties.Filled = Value
					FilledStroke.Enabled = not Value
					CircleFrame.Size = UDim2.new(0, CircleProperties.Radius - (Value and 0 or CircleProperties.Thickness), 0, CircleProperties.Radius - (Value and 0 or CircleProperties.Thickness))
				end
				if (Property == "Color") then
					CircleFrame.BackgroundColor3 = Value
					FilledStroke.Color = Value
				end
				if (Property == "Visible") then
					CircleFrame.Visible = Value
				end
				if (Property == "Thickness") then
					FilledStroke.Thickness = Value
					CircleProperties.Thickness = Value
					CircleFrame.Size = UDim2.new(0, CircleProperties.Radius - (Value and 0 or CircleProperties.Thickness), 0, CircleProperties.Radius - (Value and 0 or CircleProperties.Thickness))
				end
				if (Property == "Transparency") then
					CircleFrame.BackgroundTransparency = CircleProperties.Filled and 1 or Value
					FilledStroke.Transparency = 1 - Value
				end
			end),
			__index = (function(self, Property)
				if (Property == "Remove" or Property == "Destroy") then
					return (function()
						CircleFrame:Destroy()
					end)
				end

				return CircleProperties[Property]
			end)
		})

		metaInstances[mt] = true
		table.insert(drawings, mt)
		return mt
	end

	if (Type == "Text") then
		local TextProperties = ({
			Text = "",
			Size = 0,
			Center = false,
			Outline = false,
			Transparency = 1,
			OutlineColor = Color3.new(),
			Position = Vector2.new(),
		} + BaseDrawingProperties)

		local TextLabel = Instance.new("TextLabel")

		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.BorderSizePixel = 0
		TextLabel.Size = UDim2.new(0, 200, 0, 50)
		TextLabel.Font = fonts[0]
		TextLabel.TextSize = 14

		TextLabel.TextColor3 = TextProperties.Color
		TextLabel.Visible = TextProperties.Visible
		TextLabel.BackgroundTransparency = 1
		TextLabel.TextTransparency = 1 - TextProperties.Transparency

		TextLabel.Parent = UI

		local mt = setmetatable({}, {
			__newindex = (function(self, Property, Value)
				if (Property == "Text") then
					TextLabel.Text = Value
				end
				if (Property == "Position") then
					TextLabel.Position = UDim2.new(0, Value.X, 0, Value.Y)
				end
				if (Property == "Size") then
					TextLabel.TextSize = Value
				end
				if (Property == "Color") then
					TextLabel.TextColor3 = Value
				end
				if (Property == "OutlineColor") then
					TextLabel.TextStrokeColor3 = Value
				end
				if (Property == "Outline") then
					TextLabel.TextStrokeTransparency = Value and 1-TextProperties.Transparency or 1
				end
				if (Property == "Transparency") then
					TextLabel.TextTransparency = 1 - Value
					TextProperties.Transparency = Value
				end
				if (Property == "Visible") then
					TextLabel.Visible = Value
				end
				if (Property == "Center") then
					TextLabel.Position = Value == true and UDim2.new(0, workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2, 0)
				end
				if (Property == "Font") then
					TextLabel.Font = fonts[Value] or fonts[0]
				end
			end),
			__index = (function(self, Property)
				if (Property == "Remove" or Property == "Destroy") then
					return (function()
						TextLabel:Destroy()
					end)
				end
				if (Property == "TextBounds") then
					return TextLabel.TextBounds
				end

				return TextProperties[Property]
			end)
		})

		table.insert(drawings, mt)
		metaInstances[mt] = true
		return mt
	end

	if (Type == "Square") then
		local SquareProperties = ({
			Thickness = 1,
			Size = Vector2.new(),
			Position = Vector2.new(),
			Filled = false,
		} + BaseDrawingProperties)

		local SquareFrame = Instance.new("Frame")

		SquareFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		SquareFrame.BorderSizePixel = 0

		SquareFrame.Visible = false
		SquareFrame.Parent = UI

		local FilledStroke = Instance.new("UIStroke", SquareFrame)
		FilledStroke.Enabled = false

		local filled = false

		local mt = setmetatable({}, {
			__newindex = (function(self, Property, Value)
				if (Property == "Size") then
					SquareFrame.Size = UDim2.new(0, Value.X, 0, Value.Y)
					SquareProperties.Text = Value
				end
				if (Property == "Position") then
					SquareFrame.Position = UDim2.new(0, Value.X, 0, Value.Y)
					SquareProperties.Position = Value
				end
				if (Property == "Size") then
					SquareFrame.Size = UDim2.new(0, Value.X - (filled and SquareProperties.Thickness or 0), 0, Value.Y - (filled and SquareProperties.Thickness or 0))
					SquareProperties.Size = Value
				end
				if (Property == "Color") then
					SquareFrame.BackgroundColor3 = Value
					SquareProperties.Color = Value
				end
				if (Property == "Transparency") then
					SquareFrame.BackgroundTransparency = 1 - Value
					SquareProperties.Transparency = Value
				end
				if (Property == "Visible") then
					SquareFrame.Visible = Value
					SquareProperties.Visible = Value
				end
				if (Property == "Filled") then
					FilledStroke = not Value
					SquareFrame.BackgroundTransparency = Value and SquareProperties.Transparency or 1
				end
			end),
			__index = (function(self, Property)
				if (Property == "Remove" or Property == "Destroy") then
					return (function()
						SquareFrame:Destroy()
					end)
				end

				return SquareProperties[Property]
			end)
		})

		table.insert(drawings, mt)
		metaInstances[mt] = true
		return mt
	end

	if (Type == "Image") then
		local Image_Properties = {
			Size = Vector2.new(),
			Position = Vector2.new(),
			Color = Color3.fromRGB(255, 255, 255),
			Data = "",
			Transparency = 1
		}

		local ImageLabel = Instance.new("ImageLabel")

		ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.ScaleType = Enum.ScaleType.Stretch
		ImageLabel.Transparency = 1

		ImageLabel.Visible = false
		ImageLabel.Parent = UI

		local mt = setmetatable({}, {
			__newindex = (function(self, Property, Value)
				if (Property == "Size") then
					ImageLabel.Size = UDim2.new(0, Value.X, 0, Value.Y)
				end
				if (Property == "Position") then
					ImageLabel.Position = UDim2.new(0, Value.X, 0, Value.Y)
				end
				if (Property == "Transparency") then
					ImageLabel.ImageTransparency = 1 - Value
				end
				if (Property == "Visible") then
					ImageLabel.Visible = Value
				end
				if (Property == "Color") then
					ImageLabel.ImageColor3 = Value
				end
				if (Property == "Data") then
					ImageLabel.Image = Value
				end
				Image_Properties[Property] = Value
			end),
			__index = (function(self, Property)
				if (Property == "Remove" or Property == "Destroy") then
					return (function()
						ImageLabel:Destroy()
					end)
				end

				return Image_Properties[Property]
			end)
		})

		table.insert(drawings, mt)
		metaInstances[mt] = true
		return mt
	end

	if (Type == "Quad") then -- will add later
		local mt = setmetatable({}, {
			__newindex = (function(self, Property)

			end),
			__index = (function(self, Property)
				if (Property == "Remove" or Property == "Destroy") then
					return (function()

					end)
				end

				return 
			end)
		})

		table.insert(drawings, mt)
		metaInstances[mt] = true
		return mt
	end

	if (Type == "Triangle") then
		local Triangle_Properties = ({
			PointA = Vector2.new(0,0),
			PointB = Vector2.new(0,0),
			PointC = Vector2.new(0,0),
			Visible = true,
			Color = Color3.fromRGB(255,255,255),
			Thickness = 2,
			Transparency = 0,
			Filled = false
		} + BaseDrawingProperties)

		local lines = {
			[1] = drawLine(UI),
			[2] = drawLine(UI),
			[3] = drawLine(UI)
		}

		local mt = setmetatable({}, {
			__newindex = (function(self, Property, Value)
				Triangle_Properties[Property] = Value
				for i,v in pairs(Triangle_Properties) do
					if i ~= "PointA" and i ~= "PointB" and i ~= "PointC" then
						for idx, val in pairs(lines) do
							val[i] = v
						end
					end
				end

				lines[1].From = Triangle_Properties.PointA
				lines[1].To = Triangle_Properties.PointB

				lines[2].From = Triangle_Properties.PointB
				lines[2].To = Triangle_Properties.PointC

				lines[3].From = Triangle_Properties.PointC
				lines[3].To = Triangle_Properties.PointA
			end),
			__index = (function(self, Property)
				if (Property == "Remove" or Property == "Destroy") then
					return (function()
						for i,v in pairs(lines) do
							v:Destroy()
						end 
						table.clear(lines)
					end)
				end

				return Triangle_Properties[Property]
			end)
		})

		table.insert(drawings, mt)
		metaInstances[mt] = true
		return mt
	end
end
Drawing.Fonts = {
	UI = 0,
	System = 1,
	Plex = 2,
	Monospace = 3
}

local function cleardrawcache()
	for i,v in pairs(drawings) do
		if not v then continue end
		v:Destroy()
		setmetatable(v, emptyT)
	end
	table.clear(drawings)
end
local function isrenderobj(obj)
	return table.find(drawings, obj) ~= nil
end
local function getrenderproperty(obj, prop)
	return obj[prop]
end
local function setrenderproperty(obj, prop, val)
	obj[prop] = val
end

local function lz4compress(raw)
	return table.pack(crypt.encrypt(raw, "lol", "lol", "lol"))[1]
end
local function lz4decompress(raw, len)
	if #raw > len then
		return nil
	else
		return table.pack(crypt.decrypt(raw, "lol", "lol", "lol"))[1]:sub(0, len)
	end
end

local function messagebox(title, content)
	coroutine.wrap(playaudio)(2389339814)
	_G.messagebox().Show(title, content)
end

function returnfps()
	return workspace:GetRealPhysicsFPS()
end
local fpsCap = math.floor(returnfps()*10)/10
local function getfpscap()
	return fpsCap
end
local function setfpscap(val)
	fpsCap = val
end
local WebSocket = {
	connect = undefined
}

local rdebug = debug
local debug = setmetatable({}, {
	__index = function(self, name)
		return rdebug[name] or undefined
	end,
})
local nils = {}
local function filterallInstances(filter)
	local result = {}
	local idx = 1

	for instance in instances_reg do
		if not (filter(instance)) then
			continue
		end
		result[idx] = instance
		idx += 1
	end
	return result
end
local function getnilinstances()
	return filterallInstances(function(instance)
		return instance.Parent == nil
	end)
end

local function c(v)
	if v.Parent == nil then
		table.insert(nils, v)
	else
		local found = table.find(nils, v)
		if found then
			nils[found] = nil
		end
	end
end
local function setupNils(v)
	c(v)
	v:GetPropertyChangedSignal("Parent"):Connect(function()
		c(v)
	end)
end
for i,v in pairs(origGame:GetDescendants()) do
	setupNils(v)
end
origGame.DescendantAdded:Connect(setupNils)

--[[local function getrawmetatable(object)
	return {
		__index = function(self, index)
			return object[index]
		end,
		__lt = function(self, value)
			return object < value
		end,
		__le = function(self, value)
			return object <= value
		end,
		__gc = function(self)

		end,
		__len = function(self)
			return #object
		end,
		__unm = function(self)
			return -object
		end,
		__iter = function(self)
			return next, object
		end,
		__newindex = function(self, index, value)
			object[index] = ismetainstance(value) and value.___originalInstance or value
		end,
		__tostring = function()
			return tostring(object)
		end,
		__eq = function(self, obj)
			return self == obj or object == obj
		end,
		__call = function(self, ...)
			return object(...)
		end,
		__concat = function(self, val)
			return object .. val
		end,
		__add = function(self, value)
			return object + value
		end,
		__sub = function(self, value)
			return object - value
		end,
		__mul = function(self, value)
			return object * value
		end,
		__div = function(self, value)
			return object / value
		end,
		__idiv = function(self, value)
			return object // value
		end,
		__mod = function(self, value)
			return object%value
		end,
		__pow = function(self, value)
			return object ^ value
		end
	}
end]]
local http = {
	request = undefined
}

local function getrawmetatable(obj)
	local mt = typeof(getmetatable(obj)) ~= "string" and getmetatable(obj)
	if not mt then 
		return setmetatable({},{
			__index = function(self, name)
				return obj[name]
			end,
			__newindex = function(self, name, value)
				obj[name] = value
			end,
			__eq = function(self, eq)
				return typeof(eq) == "table"
			end,
			__len = function()
				return #obj
			end,
		})
	else
		return mt
	end
end

--

protectedLimit = 199999
env = {
	-- Undefined

	hookfunction=undefined,
	replaceclosure=undefined,
	rconsoleclear=undefined,
	consoleclear=undefined,
	rconsolecreate=undefined,
	consolecreate=undefined,
	consoledestroy=undefined,
	rconsoledestroy=undefined,
	rconsoleinput=undefined,
	consoleinput=undefined,
	rconsoleprint=undefined,
	consoleprint=undefined,
	rconsoletitle=undefined,
	rconsolename=undefined,
	consolesettitle=undefined,
	fireclickdetector=undefined,
	getconnections=undefined,
	getcustomasset=undefined,
	gethiddenproperty=undefined,
	sethiddenproperty=undefined,
	setscriptable=undefined,
	getnamecallmethod=undefined,
	setrawmetatable=undefined,
	http_request=undefined,
	mouse1click=undefined,
	mouse1press=undefined,
	mouse1release=undefined,
	mouse2click=undefined,
	mouse2press=undefined,
	mouse2release=undefined,
	mousemoveabs=undefined,
	mousemoverel=undefined,
	mousescroll=undefined,
	getgc=undefined,
	getscriptbytecode=undefined,
	dumpstring=undefined,
	getscripthacs=undefined,

	-- Working

	--getrawmetatable=getrawmetatable,
	request=request,
	getscripthash=getscripthash,
	setfpscap=setfpscap,
	getfpscap=getfpscap,
	http=http,
	hookmetamethod=hookmetamethod,
	getrawmetatable=getrawmetatable,
	getnilinstances=getnilinstances,
	getscriptclosure=getscriptclosure,
	playaudio=playaudio,
	playloopedaudio=playloopedaudio,
	listfiles=listfiles,
	cleardrawcache=cleardrawcache,
	Drawing=Drawing,
	getcallbackvalue=getcallbackvalue,
	cache=cache,
	getloadedmodules=getloadedmodules,
	stopaudio=stopaudio,
	getcallingscript=getcallingscript,
	getscriptfunction=getscriptclosure,
	loadfile=loadfile,
	resumeaudio=resumeaudio,
	checkcaller=checkcaller,
	removeaudio=removeaudio,
	audiolooped=audiolooped,
	lz4compress=lz4compress,
	lz4decompress=lz4decompress,
	fireproximityprompt=fireproximityprompt,
	firetouchinterest=firetouchinterest,
	getgenv=getgenv,
	gethui=gethui,
	base64={encode=base64encode,decode=base64decode},
	base64encode=base64encode,
	base64decode=base64decode,
	base64_encode=base64encode,
	base64_decode=base64decode,
	identifyexecutor=identifyexecutor,
	randomstring=randomstring,
	protect_gui=protect_gui,
	appendfile=appendfile,
	decompile=decompile,
	dofile=dofile,
	cloneref=cloneref,
	clonerefs=cloneref,
	writefile=writefile,
	readfile=readfile,
	deletefile=deletefile,
	makefolder=makefolder,
	isfile=isfile,
	isfolder=isfolder,
	isscriptable=isscriptable,
	messagebox=messagebox,
	createfolder=makefolder,
	setclipboard=toclipboard,
	toclipboard=toclipboard,
	getrenv=function()
		luaEnv.script = nil
		return luaEnv
	end,
	compareinstances=compareinstances,
	clonefunction=clonefunction,
	iscclosure=iscclosure,
	islclosure=islclosure,
	newcclosure=newcclosure,
	delfolder=deletefile,
	isexecutorclosure=isexecutorclosure,
	deletefolder=deletefile,
	delfile=deletefile,
	isrbxactive=isrbxactive,
	loadlocalasset=LoadLocalAsset,
	getinstances=function()return Game:GetDescendants()end,
	setrbxclipboard=toclipboard,
	setreadonly=setreadonly,
	isreadonly=isreadonly,
	getexecutorname=identifyexecutor,
	getscripts=getscripts,
	getsenv=getsenv,
	getrunningscripts=getrunningscripts,
	queueonteleport=queueonteleport,
	isgameactive=isrbxactive,
	queue_on_teleport=queueonteleport,
	getthreadidentity=getthreadidentity,
	setthreadidentity=setthreadidentity,
	getidentity=getthreadidentity,
	checkclosure=isexecutorclosure,
	isourclosure=isexecutorclosure,
	getthreadcontext=getthreadidentity,
	setidentity=setthreadidentity,
	setthreadcontext=setthreadidentity,
	crypt=crypt,
	isrenderobj=isrenderobj,
	getrenderproperty=getrenderproperty,
	setrenderproperty=setrenderproperty,
	WebSocket=WebSocket,

	saveinstance=function(...)
		local saved = _G.saveinstance(...)
		if rTypeof(saved) == "function" then
			saved = saved(...)
		end

		return saved
	end,

	_IDENTITY=identity,

	setMaximizeBind=setMaximizeBind,

	runScript = function(name,...)
		return _G[name](...)
	end,

	Instance={new=function(class,parent,...)
		if ismetainstance(parent) then parent = parent.___originalInstance end
		local newInstance = Instance.new(class, parent, ...)
		return convertToMetaInstance(newInstance, {
			BlockMethods = {
				Parent = function(newPar)
					if ismetainstance(newPar) then
						newPar = newPar.___originalInstance
					end
					newInstance.Parent = newPar
				end,
			},
			FixEnvinroment = true
		})
	end},
	require=function(obj)
		return --[[rrequire]]require(ismetainstance(obj) and obj.___originalInstance or obj)
	end--require
	,

	type=function(obj)
		return ismetainstance(obj) and "Instance" or type(obj)
	end,
	typeof=function(obj)
		return ismetainstance(obj) and "Instance" or (typeof or type)(obj)
	end,

	Internal = _G.Internal,
	_CTMI = convertToMetaInstance,

	_ENV=_G.ENV,
	game=game,

	wait=wait,
	workspace=workspace,
	Wait=wait,
	Workspace=workspace,

	Enum=Enum,
	ElapsedTime=getFunc("elapsedTime"),
	elapsedTime=getFunc("elapsedTime"),

	Random=Random,
	RaycastParams=RaycastParams,
	Region3=Region3,
	Ray=Ray,
	Rect=Rect,
	RotationCurveKey=RotationCurveKey,
	Region3int16=Region3int16,
	rawget=rawget,
	rawlen=rawlen,
	rawset=rawset,
	rawequal=rawequal,

	task=task,
	TweenInfo=TweenInfo,
	tostring=tostring,
	tonumber=tonumber,
	table=table,
	time=time,
	tick=tick,
	ypcall=pcall,

	UDim2=UDim2,
	utf8=utf8,
	unpack=unpack,
	UDim=UDim,
	UserSettings=UserSettings,
	ipairs=ipairs,

	os=os,
	OverlapParams=OverlapParams,

	pairs=pairs,
	pcall=pcall,
	plugin=plugin,
	PhysicalProperties=PhysicalProperties,
	PathWaypoint=PathWaypoint,
	printidentity=printidentity,

	Axes=Axes,
	assert=assert,

	script=nil,
	string=string,
	select=select,
	settings=settings,
	spawn=spawn,
	Secret=Secret,
	shared=shared,
	setfenv=setfenv,
	SharedTable=SharedTable,
	setmetatable=setmetatable,
	Spawn=spawn,
	Stats=getFunc("stats"),
	stats=getFunc("stats"),

	DateTime=DateTime,
	debug=debug,
	DockWidgetPluginGuiInfo=DockWidgetPluginGuiInfo,
	delay=delay,
	Delay=delay,

	Font=Font,
	Faces=Faces,
	File=File,
	FloatCurveKey=FloatCurveKey,

	getfenv=getfenv,
	getmetatable=getmetatable,
	gcinfo=gcinfo,
	Game=game,

	loadstring=newLoadstring,

	xpcall=xpcall,

	CFrame=CFrame,
	Color3=Color3,
	coroutine=coroutine,
	ColorSequenceKeypoint=ColorSequenceKeypoint,
	ColorSequence=ColorSequence,
	CatalogSearchParams=CatalogSearchParams,
	collectgarbage=getFunc("collectgarbage"),

	Vector3=Vector3,
	Vector2=Vector2,
	Vector2int16=Vector2int16,
	Vector3int16=Vector3int16,

	Version=getFunc("version"),
	version=getFunc("version"),

	BrickColor=BrickColor,
	bit32=bit32,
	buffer=buffer,

	newproxy=newproxy,
	NumberSequence=NumberSequence,
	NumberSequenceKeypoint=NumberSequenceKeypoint,
	NumberRange=NumberRange,
	next=next,

	math=math,

	_G=_G,
	_VERSION=_VERSION,

	print=printt,
	warn=warnn,
	info=infoo,
	error=errorr,

	loadedLol = true
}

for i,v in pairs(env) do
	if v and rTypeof(v) == "function" then
		cClosures[v] = true
	end
end

_G.ENV = env

cindex = 1
for _,v in pairs(env) do
	checkenv[cindex] = v
	cindex += 1
end

env.setfenv(1.2, genvMeta)
env.setfenv(1, env)
env.setfenv(0, env)
--env.setfenv(env.getfenv(env.version), env)

