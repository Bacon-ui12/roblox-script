-- Tap Simulator Auto Tap (Remote-based) + GUI
-- Phím G = Toggle

local P=game.Players.LocalPlayer
local UIS=game:GetService("UserInputService")
local RS=game:GetService("ReplicatedStorage")

_G.Tap=false

-- ===== TÌM REMOTE TAP =====
local TapRemote
for _,v in pairs(RS:GetDescendants()) do
    if v:IsA("RemoteEvent") and string.lower(v.Name):find("tap") then
        TapRemote=v
        break
    end
end

if not TapRemote then
    warn("❌ Không tìm thấy Tap Remote")
else
    warn("✅ Found Tap Remote:",TapRemote.Name)
end

-- ===== GUI =====
pcall(function() game.CoreGui.TapGUI:Destroy() end)

local gui=Instance.new("ScreenGui",game.CoreGui)
gui.Name="TapGUI"

local frame=Instance.new("Frame",gui)
frame.Size=UDim2.new(0,200,0,90)
frame.Position=UDim2.new(0,20,0.4,0)
frame.BackgroundColor3=Color3.fromRGB(30,30,30)
frame.Active=true
frame.Draggable=true

local btn=Instance.new("TextButton",frame)
btn.Size=UDim2.new(1,-20,0,50)
btn.Position=UDim2.new(0,10,0,20)
btn.Text="Auto Tap: OFF"
btn.TextColor3=Color3.new(1,1,1)
btn.BackgroundColor3=Color3.fromRGB(60,60,60)

local function update()
    btn.Text="Auto Tap: "..(_G.Tap and "ON" or "OFF")
end

btn.MouseButton1Click:Connect(function()
    _G.Tap=not _G.Tap
    update()
end)

-- ===== Phím G =====
UIS.InputBegan:Connect(function(i,g)
    if g then return end
    if i.KeyCode==Enum.KeyCode.G then
        _G.Tap=not _G.Tap
        update()
    end
end)

-- ===== AUTO TAP =====
task.spawn(function()
    while task.wait(0.05) do
        if _G.Tap and TapRemote then
            TapRemote:FireServer()
        end
    end
end)
