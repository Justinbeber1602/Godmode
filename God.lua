local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- [[ SETTINGS ]]
_G.WalkSpeed = 16
_G.Noclip = false

-- [[ UI CONSTRUCT ]]
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 350, 0, 220)
Main.Position = UDim2.new(0.5, -175, 0.5, -110)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- Header
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "Just"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- [[ SECTION 1: SPEED SLIDER ]]
local SpeedLabel = Instance.new("TextLabel", Main)
SpeedLabel.Position = UDim2.new(0, 20, 0, 55)
SpeedLabel.Size = UDim2.new(0, 200, 0, 20)
SpeedLabel.Text = "WalkSpeed: 16"
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.BackgroundTransparency = 1

local SliderBack = Instance.new("Frame", Main)
SliderBack.Position = UDim2.new(0, 20, 0, 85)
SliderBack.Size = UDim2.new(1, -40, 0, 6)
SliderBack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", SliderBack)

local SliderFill = Instance.new("Frame", SliderBack)
SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
Instance.new("UICorner", SliderFill)

local SliderBtn = Instance.new("TextButton", SliderFill)
SliderBtn.AnchorPoint = Vector2.new(0.5, 0.5)
SliderBtn.Position = UDim2.new(1, 0, 0.5, 0)
SliderBtn.Size = UDim2.new(0, 16, 0, 16)
SliderBtn.BackgroundColor3 = Color3.new(1, 1, 1)
SliderBtn.Text = ""
Instance.new("UICorner", SliderBtn).CornerRadius = UDim.new(1, 0)

-- [[ SECTION 2: NOCLIP TOGGLE ]]
local NoclipBtn = Instance.new("TextButton", Main)
NoclipBtn.Position = UDim2.new(0, 20, 0, 120)
NoclipBtn.Size = UDim2.new(1, -40, 0, 40)
NoclipBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
NoclipBtn.Text = "Noclip: OFF"
NoclipBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
NoclipBtn.Font = Enum.Font.GothamBold
NoclipBtn.TextSize = 14
Instance.new("UICorner", NoclipBtn).CornerRadius = UDim.new(0, 6)

-- [[ LOGIC: SLIDER ]]
local dragging = false
SliderBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

RunService.RenderStepped:Connect(function()
    if dragging then
        local mousePos = UserInputService:GetMouseLocation().X
        local sliderPos = SliderBack.AbsolutePosition.X
        local sliderWidth = SliderBack.AbsoluteSize.X
        local percent = math.clamp((mousePos - sliderPos) / sliderWidth, 0, 1)
        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
        _G.WalkSpeed = math.floor(16 + (percent * 184))
        SpeedLabel.Text = "WalkSpeed: " .. tostring(_G.WalkSpeed)
    end
end)

-- [[ LOGIC: NOCLIP ]]
NoclipBtn.MouseButton1Click:Connect(function()
    _G.Noclip = not _G.Noclip
    if _G.Noclip then
        NoclipBtn.Text = "Noclip: ON"
        NoclipBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
    else
        NoclipBtn.Text = "Noclip: OFF"
        NoclipBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- [[ BYPASS ENGINE (Runs Every Frame) ]]
RunService.Stepped:Connect(function()
    pcall(function()
        local char = Player.Character
        if char then
            -- Speed Bypass
            if char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = _G.WalkSpeed
            end
            -- Noclip Bypass
            if _G.Noclip then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end)

-- Close UI
local Close = Instance.new("TextButton", Header)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -35, 0, 5)
Close.Text = "X"
Close.TextColor3 = Color3.new(1, 0.2, 0.2)
Close.BackgroundTransparency = 1
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
