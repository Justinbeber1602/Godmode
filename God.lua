local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

_G.WalkSpeed = 16
_G.Noclip = false

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "JustHub_Final"

local Canvas = Instance.new("Frame", ScreenGui)
Canvas.Size = UDim2.new(0, 300, 0, 180)
Canvas.Position = UDim2.new(0.5, -150, 0.5, -90)
Canvas.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Canvas.Active = true
Canvas.Draggable = true
Instance.new("UICorner", Canvas).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Canvas)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "JUST STUDIO HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

local SpeedBtn = Instance.new("TextButton", Canvas)
SpeedBtn.Size = UDim2.new(0.8, 0, 0, 40)
SpeedBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
SpeedBtn.Text = "Speed: 100"
SpeedBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", SpeedBtn)

SpeedBtn.MouseButton1Click:Connect(function()
    if _G.WalkSpeed == 16 then _G.WalkSpeed = 100 else _G.WalkSpeed = 16 end
    SpeedBtn.Text = "Speed: "..tostring(_G.WalkSpeed)
end)

local NoclipBtn = Instance.new("TextButton", Canvas)
NoclipBtn.Size = UDim2.new(0.8, 0, 0, 40)
NoclipBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
NoclipBtn.Text = "Noclip: OFF"
NoclipBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
NoclipBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", NoclipBtn)

NoclipBtn.MouseButton1Click:Connect(function()
    _G.Noclip = not _G.Noclip
    NoclipBtn.Text = "Noclip: " .. (_G.Noclip and "ON" or "OFF")
end)

RunService.Stepped:Connect(function()
    pcall(function()
        if Player.Character then
            if Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.WalkSpeed = _G.WalkSpeed
            end
            if _G.Noclip then
                for _, v in pairs(Player.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end
        end
    end)
end)
