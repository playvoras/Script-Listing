local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local RStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local ChatRemote = RStorage:FindFirstChild("SayMessageRequest", true)

-- Instances:

local Menu = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UIPadding = Instance.new("UIPadding")
local Crash = Instance.new("TextButton")
local UIPadding_2 = Instance.new("UIPadding")
local Amount = Instance.new("TextBox")
local UIPadding_3 = Instance.new("UIPadding")
local Crash_2 = Instance.new("TextButton")
local UIPadding_4 = Instance.new("UIPadding")

--Properties:

Menu.Name = "Menu"
Menu.Parent = CoreGui
Menu.ResetOnSpawn = false
Menu.DisplayOrder = 9e7
Menu.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = Menu
Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.863379538, 0, 0.677383602, 0)
Main.Size = UDim2.new(0.119590782, 0, 0.296230614, 0)
Main.Active = true
Main.Draggable = true

Title.Name = "Title"
Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1.00000012, 0, 0.219760478, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Public Bathroom Fucker"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.TextScaled = true
Title.TextSize = 14.000
Title.TextWrapped = true

UIPadding.Parent = Title
UIPadding.PaddingBottom = UDim.new(0.100000001, 0)
UIPadding.PaddingLeft = UDim.new(0.100000001, 0)
UIPadding.PaddingRight = UDim.new(0.100000001, 0)
UIPadding.PaddingTop = UDim.new(0.100000001, 0)

Crash.Name = "Crash"
Crash.Parent = Main
Crash.BackgroundColor3 = Color3.fromRGB(190, 190, 190)
Crash.BorderColor3 = Color3.fromRGB(0, 0, 0)
Crash.BorderSizePixel = 0
Crash.Position = UDim2.new(0.115959413, 0, 0.527694583, 0)
Crash.Size = UDim2.new(0.765684545, 0, 0.167365357, 0)
Crash.Font = Enum.Font.Gotham
Crash.Text = "Crash"
Crash.TextColor3 = Color3.fromRGB(0, 0, 0)
Crash.TextScaled = true
Crash.TextSize = 14.000
Crash.TextWrapped = true

UIPadding_2.Parent = Crash
UIPadding_2.PaddingBottom = UDim.new(0.100000001, 0)
UIPadding_2.PaddingLeft = UDim.new(0.100000001, 0)
UIPadding_2.PaddingRight = UDim.new(0.100000001, 0)
UIPadding_2.PaddingTop = UDim.new(0.100000001, 0)

Amount.Name = "Amount"
Amount.Parent = Main
Amount.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
Amount.BorderColor3 = Color3.fromRGB(0, 0, 0)
Amount.BorderSizePixel = 0
Amount.Position = UDim2.new(0.111663103, 0, 0.299401194, 0)
Amount.Size = UDim2.new(0.765999973, 0, 0.166999996, 0)
Amount.Font = Enum.Font.Gotham
Amount.PlaceholderText = "default 400"
Amount.Text = ""
Amount.TextColor3 = Color3.fromRGB(0, 0, 0)
Amount.TextScaled = true
Amount.TextSize = 14.000
Amount.TextWrapped = true

UIPadding_3.Parent = Amount
UIPadding_3.PaddingBottom = UDim.new(0.100000001, 0)
UIPadding_3.PaddingLeft = UDim.new(0.100000001, 0)
UIPadding_3.PaddingRight = UDim.new(0.100000001, 0)
UIPadding_3.PaddingTop = UDim.new(0.100000001, 0)

Crash_2.Name = "Crash"
Crash_2.Parent = Main
Crash_2.BackgroundColor3 = Color3.fromRGB(190, 190, 190)
Crash_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Crash_2.BorderSizePixel = 0
Crash_2.Position = UDim2.new(0.115959413, 0, 0.76721555, 0)
Crash_2.Size = UDim2.new(0.765684545, 0, 0.167365357, 0)
Crash_2.Font = Enum.Font.Gotham
Crash_2.Text = "Sit Fling"
Crash_2.TextColor3 = Color3.fromRGB(0, 0, 0)
Crash_2.TextScaled = true
Crash_2.TextSize = 14.000
Crash_2.TextWrapped = true

UIPadding_4.Parent = Crash_2
UIPadding_4.PaddingBottom = UDim.new(0.100000001, 0)
UIPadding_4.PaddingLeft = UDim.new(0.100000001, 0)
UIPadding_4.PaddingRight = UDim.new(0.100000001, 0)
UIPadding_4.PaddingTop = UDim.new(0.100000001, 0)

Crash.Activated:Connect(function()
    local CrashAmount = tonumber(Amount.Text) or 400
    local ClickDetector = workspace["Trash can"].Trash.Can.ClickDetector

    for i = 1, CrashAmount do
        fireclickdetector(ClickDetector)
        task.wait()
    end

    task.wait(0.2)
    ChatRemote:FireServer(";shutdown", "All")

    task.wait(0.2)
    for _, Tool in LocalPlayer.Backpack:GetChildren() do
        if not Tool:IsA("Tool") then continue end
        Tool.Parent = LocalPlayer.Character
        Tool.Parent = workspace
        Tool:Destroy()
    end

    task.wait(0.2)
    local OldPos = LocalPlayer.Character.PrimaryPart.CFrame
    LocalPlayer.Character:BreakJoints()
    LocalPlayer.CharacterAdded:Once(function(Character)
        Character:WaitForChild("HumanoidRootPart").CFrame = OldPos
    end)
end)

Crash_2.Activated:Connect(function()
    local Character = LocalPlayer.Character
    local Humanoid = Character.Humanoid
    local Root = Character.PrimaryPart
    Character.Archivable = true
    
    local Clone = Character:Clone()
    local cRoot = Clone.PrimaryPart
    local cHumanoid = Clone.Humanoid
    Clone.Parent = workspace
    LocalPlayer.Character = Clone
    Camera.CameraSubject = cHumanoid
    Humanoid.Sit = true
    
    local Connections = {}
    
    local BodyParts = {}
    for _, BodyPart in Character:GetChildren() do
        if not BodyPart:IsA("BasePart") then continue end
        BodyPart.Transparency = 0.5
        BodyParts[#BodyParts + 1] = BodyPart
    end
    
    for _, BodyPart in Clone:GetChildren() do
        if not BodyPart:IsA("BasePart") then continue end
        BodyParts[#BodyParts + 1] = BodyPart
    end
    
    Connections[#Connections + 1] = RunService.Stepped:Connect(function()
        for _, BodyPart in BodyParts do
            BodyPart.CanCollide = false
        end
        Root.CFrame = cRoot.CFrame
        Root.Velocity = Vector3.new(0, 9e8, 0)
    end)
    
    Connections[#Connections + 1] = RunService.Heartbeat:Connect(function()
        Root.CFrame = cRoot.CFrame
    end)
    
    Connections[#Connections + 1] = cHumanoid:GetPropertyChangedSignal("Health"):Connect(function()
        local New = cHumanoid.Health
        if New <= 0 then
            LocalPlayer.Character = Character
            Camera.CameraSubject = Humanoid
            Humanoid.Health = 0
            Clone:Destroy()
    
            for _, Connection in Connections do
                Connection:Disconnect()
            end
        end
    end)
end)
