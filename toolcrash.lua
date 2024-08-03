local LocalPlayer = game:GetService("Players").LocalPlayer
local Backpack = LocalPlayer.Backpack
local Character = LocalPlayer.Character

for _, tool in Backpack:GetChildren() do
    tool.Parent = Character
    tool.Parent = workspace
    tool:Destroy()
end

for _, tool in Character:GetChildren() do
    if not tool:IsA("Tool") then continue end
    tool.Parent = Character
    tool.Parent = workspace
    tool:Destroy()
end

Backpack.ChildAdded:Connect(function(tool)
    wait()
    tool.Parent = Character
    tool.Parent = workspace
    tool:Destroy()
end)
