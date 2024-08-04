local function fireproximityprompt(pp)
	assert(pp:IsA("ProximityPrompt"), "Argument must be a ProximityPrompt")

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
		workspace.CurrentCamera.CFrame = CFrame.lookAt(cf.Position, pos)
		wait(2)
		fire()
		wait(1)
		workspace.CurrentCamera.CFrame = cf
	end

	pp.RequiresLineOfSight = rlof
	pp.HoldDuration = hd
	pp.MaxActivationDistance = mad

	trcon:Disconnect()
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local window = library.CreateLib("Novaz#5792", "BloodTheme")
local main = window:NewTab("Main")
local section = main:NewSection("Main")
local section1 = main:NewSection("ESP")
local main1 = window:NewTab("Misc")
local section2 = main1:NewSection("Local Player")
local plr = game.Players.LocalPlayer

local function getclosestenemy() 
	local closest = nil 
	local maxdist = math.huge
	for i,v in pairs(game.Workspace.NPCs:GetChildren()) do 
		if v.Name == "Tango" or v.Name == "Monsters" then 
			for o,k in pairs(v:GetChildren()) do 
				if k:IsA("Model") and k:FindFirstChild("HumanoidRootPart") then 
					local magnitude = (k:FindFirstChild("HumanoidRootPart").Position - plr.Character.HumanoidRootPart.Position).Magnitude 
					if magnitude < maxdist then 
						closest = k
						maxdist = magnitude 
					end 
				end 
			end 
		end 
	end 
	return closest
end

local function getclosestenemytm() 
	local closest = nil 
	local maxdist = math.huge
	for i,v in pairs(game.Workspace.NPCs:GetChildren()) do 
		if v.Name == "Tango" or v.Name == "Monsters" then 
			for o,k in pairs(v:GetChildren()) do 
				if k:IsA("Model") and k:FindFirstChild("HumanoidRootPart") then 
					local screenpoint = game.Workspace.CurrentCamera:WorldToScreenPoint(k:FindFirstChild("HumanoidRootPart").Position)
					local distance = (Vector2.new(game.Players.LocalPlayer:GetMouse().x, game.Players.LocalPlayer:GetMouse().y) - Vector2.new(screenpoint.x, screenpoint.y)).Magnitude
					if distance < maxdist then 
						closest = k
						maxdist = distance
					end 
				end 
			end 
		end 
	end 
	return closest
end

section:NewToggle("Silent Aim", "", function(c)
	d = c 
	while d and task.wait() do
		pcall(function()
			plr.Character:FindFirstChildOfClass("Tool").Main:FireServer("DAMAGE", {getclosestenemytm():FindFirstChild("Head"), getclosestenemytm():FindFirstChild("Head").Position, 0, false})
		end)
	end 
end) 

local runService = game:GetService("RunService")

section:NewToggle("Kill Closest", "", function(a)
	b = a
	local heartbeatConnection

	if b then
		heartbeatConnection = runService.Heartbeat:Connect(function()
			pcall(function()
				local ammoText = plr.PlayerGui.Crosshair.Counter.StoredAmmo.Text
				local tool = plr.Character:FindFirstChildOfClass("Tool")
				local main = tool.Main

				if tonumber(ammoText) >= 10 then
					main:FireServer("AMMO")
					main:FireServer("MUZZLE", tool.Handle.Barrel)
					local closestEnemyHead = getclosestenemy():FindFirstChild("Head")
					main:FireServer("DAMAGE", {closestEnemyHead, closestEnemyHead.Position, 0, false})
				else
					local oldpos = plr.Character.HumanoidRootPart.Position
					plr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Maps["Chaos Facility"].Misc.Ammo.Box.Main.CFrame
					task.wait(0.5)
					fireproximityprompt(game:GetService("Workspace").Maps["Chaos Facility"].Misc.Ammo.Box.Main:FindFirstChild("Template"))
					task.wait(0.5)
					plr.Character.HumanoidRootPart.CFrame = CFrame.new(oldpos)
				end
			end)
		end)
	else
		if heartbeatConnection then
			heartbeatConnection:Disconnect()
		end
	end
end)

section:NewToggle("Instant Reload", "", function(q)
	r = q 
	while r and task.wait() do 
		pcall(function()
			plr.Character:FindFirstChildOfClass("Tool").Main:FireServer("AMMO")
		end) 
	end 
end)

section:NewButton("Fill Up Ammo", "", function()
    pcall(function()
        local oldpos = plr.Character.HumanoidRootPart.Position 
        wait(.1)
        plr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Maps["Chaos Facility"].Misc.Ammo.Box.Main.CFrame 
	local part = Instance.new("Part")
        part.Size = Vector3.new(5, 1, 5)
        part.Position = oldpos - Vector3.new(0, part.Size.Y / 2, 0)
        part.Anchored = true
        part.Parent = game.Workspace
        wait(.5)
        fireproximityprompt(game:GetService("Workspace").Maps["Chaos Facility"].Misc.Ammo.Box.Main:FindFirstChild("Template"))
        wait(.5)
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(oldpos)
    end)
end)


section1:NewToggle("Enemy ESP", "", function(o)
	oo = o 
	while oo and task.wait() do 
		pcall(function()
			for i,v in pairs(game.Workspace.NPCs:GetChildren()) do 
				if v.Name == "Tango" or v.Name == "Monsters" then 
					for o,k in pairs(v:GetChildren()) do 
						if (not k:FindFirstChildOfClass("Highlight")) and k.Parent.Name == "Tango" then 
							local Highlight = Instance.new("Highlight")
							Highlight.Parent = k
							Highlight.Adornee = k
							Highlight.OutlineColor = Color3.fromRGB(1, 1, 1)                             
							Highlight.OutlineTransparency = 0 
							Highlight.FillTransparency = 1
						elseif (not k:FindFirstChildOfClass("Highlight")) and k.Parent.Name == "Monsters" then 
							local Highlight = Instance.new("Highlight")
							Highlight.Parent = k
							Highlight.Adornee = k
							Highlight.OutlineColor = Color3.fromRGB(255, 0, 0)                             
							Highlight.OutlineTransparency = 0 
							Highlight.FillTransparency = 1
						end 
					end 
				end 
			end 
		end) 
	end 
end)
