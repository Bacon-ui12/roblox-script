local P=game.Players.LocalPlayer
local UIS=game:GetService("UserInputService")
local RS=game:GetService("ReplicatedStorage")

_G.Tap,_G.Rebirth=false,false

UIS.InputBegan:Connect(function(i,g)
    if g then return end
    if i.KeyCode==Enum.KeyCode.G then
        _G.Tap=not _G.Tap
    elseif i.KeyCode==Enum.KeyCode.H then
        _G.Rebirth=not _G.Rebirth
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        if _G.Tap then
            local t=P.Character and P.Character:FindFirstChildOfClass("Tool")
            if t then t:Activate() end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if _G.Rebirth then
            local r=RS:FindFirstChild("Rebirth") or RS:FindFirstChild("RebirthEvent")
            if r then r:FireServer() end
        end
    end
end)
