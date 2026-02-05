-- Auto Tap Simulator + Auto Rebirth + GUI
-- G = Auto Tap | H = Auto Rebirth

local P=game.Players.LocalPlayer
local UIS=game:GetService("UserInputService")
local RS=game:GetService("ReplicatedStorage")

_G.Tap,_G.Rebirth=false,false

-- ===== GUI =====
local gui=Instance.new("ScreenGui",game.CoreGui)
gui.Name="TapGUI"

local frame=Instance.new("Frame",gui)
frame.Size=UDim2.new(0,200,0,120)
frame.Position=UDim2.new(0,20,0.4,0)
frame.BackgroundColor3=Color3.fromRGB(30,30,30)
frame.Active=true
frame.Draggable=true

local function mkBtn(text,y)
    local b=Instance.new("TextButton",frame)
    b.Size=UDim2.new(1,-20,0,40)
    b.Position=UDim2.new(0,10,0,y)
    b.Text=text
    b.TextColor3=Color3.new(1,1,1)
    b.BackgroundColor3=Color3.fromRGB(60,60,60)
    return b
end

local tapBtn=mkBtn("Auto Tap: OFF",10)
local rebBtn=mkBtn("Auto Rebirth: OFF",60)

tapBtn.MouseButton1Click:Connect(function()
    _G.Tap=not _G.Tap
    tapBtn.Text="Auto Tap: "..(_G.Tap and "ON" or "OFF")
end)

rebBtn.MouseButton1Click:Connect(function()
    _G.Rebirth=not _G.Rebirth
    rebBtn.Text="Auto Rebirth: "..(_G.Rebirth and "ON" or "OFF")
end)

-- ===== Phím tắt =====
UIS.InputBegan:Connect(function(i,g)
    if g then return end
    if i.KeyCode==Enum.KeyCode.G then
        _G.Tap=not _G.Tap
        tapBtn.Text="Auto Tap: "..(_G.Tap and "ON" or "OFF")
    elseif i.KeyCode==Enum.KeyCode.H then
        _G.Rebirth=not _G.Rebirth
        rebBtn.Text="Auto Rebirth: "..(_G.Rebirth and "ON" or "OFF")
    end
end)

-- ===== Auto Tap =====
task.spawn(function()
    while task.wait(0.05) do
        if _G.Tap then
            local t=P.Character and P.Character:FindFirstChildOfClass("Tool")
            if t then t:Activate() end
        end
    end
end)

-- ===== Auto Rebirth =====
task.spawn(function()
    while task.wait(1) do
        if _G.Rebirth then
            local r=RS:FindFirstChild("Rebirth") or RS:FindFirstChild("RebirthEvent")
            if r then r:FireServer() end
        end
    end
end)
