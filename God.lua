-- [[ JUST STUDIO : AETHER CORE MODULE ]]
local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- [[ SETTINGS ]]
_G.WalkSpeed = 16
_G.Noclip = false

-- [[ TWEEN INFOS ]]
local Instant = TweenInfo.new(0)
local Quick = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local Smooth = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

-- [[ UI CONSTRUCT ]]
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "JustHub_Aether"
ScreenGui.ResetOnSpawn = false

local Canvas = Instance.new("Frame", ScreenGui)
Canvas.Size = UDim2.new(0, 320, 0, 200)
Canvas.Position = UDim2.new(0.5, -160, 0.5, -100)
Canvas.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Canvas.BackgroundTransparency = 0.2
Canvas.BorderSizePixel = 0
Canvas.Active = true
Canvas.Draggable = true
Instance.new("UICorner", Canvas).CornerRadius = UDim.new(0, 16)

-- Subtle Glow
local GlowBkg = Instance.new("ImageLabel", Canvas)
GlowBkg.Size = UDim2.new(1.3, 0, 1.3, 0)
GlowBkg.Position = UDim2.new(-0.15, 0, -0.15, 0)
GlowBkg.BackgroundTransparency = 1
GlowBkg.Image = "rbxassetid://13978345203"
GlowBkg.ImageColor3 = Color3.fromRGB(0, 150, 255)
GlowBkg.ImageTransparency = 0.9
GlowBkg.ZIndex = 0

-- Header
local Header = Instance.new("Frame", Canvas)
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundTransparency = 1
Header.ZIndex = 2

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Text = "JustHub"
Title.TextColor3 = Color3.fromRGB(240, 240, 240)
Title.TextSize = 16
Title.Font = Enum.Font.GothamMedium
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

local Close = Instance.new("TextButton", Header)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -40, 0.5, -15)
Close.Text = "✕"
Close.TextColor3 = Color3.fromRGB(150, 150, 150)
Close.TextSize = 18
Close.BackgroundTransparency = 1
Close.Font = Enum.Font.GothamMedium
Close.ZIndex = 3
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- [[ CONTENT AREA ]]
local Content = Instance.new("Frame", Canvas)
Content.Position = UDim2.new(0, 20, 0, 55)
Content.Size = UDim2.new(1, -40, 1, -70)
Content.BackgroundTransparency = 1
Content.ZIndex = 2

local UIList = Instance.new("UIListLayout", Content)
UIList.Padding = UDim.new(0, 20)
UIList.SortOrder = Enum.SortOrder.LayoutOrder

-- [[ SPEED SLIDER ]]
local SpeedFrame = Instance.new("Frame", Content)
SpeedFrame.Size = UDim2.new(1, 0, 0, 50)
SpeedFrame.BackgroundTransparency = 1

local SpeedTitle = Instance.new("TextLabel", SpeedFrame)
SpeedTitle.Size = UDim2.new(0.5, 0, 0, 20)
SpeedTitle.Text = "WalkSpeed"
SpeedTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SpeedTitle.Font = Enum.Font.GothamMedium
SpeedTitle.TextSize = 13
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left

local SpeedValue = Instance.new("TextLabel", SpeedFrame)
SpeedValue.Size = UDim2.new(0.5, 0, 0, 20)
SpeedValue.Position = UDim2.new(0.5, 0, 0, 0)
SpeedValue.Text = "16"
SpeedValue.TextColor3 = Color3.fromRGB(0, 200, 255)
SpeedValue.Font = Enum.Font.GothamBold
SpeedValue.TextSize = 13
SpeedValue.BackgroundTransparency = 1
SpeedValue.TextXAlignment = Enum.TextXAlignment.Right

local SliderTrack = Instance.new("Frame", SpeedFrame)
SliderTrack.Position = UDim2.new(0, 0, 1, -8)
SliderTrack.Size = UDim2.new(1, 0, 0, 2)
SliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
SliderTrack.BorderSizePixel = 0
Instance.new("UICorner", SliderTrack)

local SliderFill = Instance.new("Frame", SliderTrack)
SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
Instance.new("UICorner", SliderFill)

local SliderKnob = Instance.new("TextButton", SliderTrack)
SliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
SliderKnob.Position = UDim2.new(0, 0, 0.5, 0)
SliderKnob.Size = UDim2.new(0, 12, 0, 12)
SliderKnob.BackgroundColor3 = Color3.new(1, 1, 1)
SliderKnob.Text = ""
Instance.new("UICorner", SliderKnob)

-- [[ SLIDER LOGIC ]]
local isDragging = false
local function updateSlider(input)
	local pos = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
	SliderFill.Size = UDim2.new(pos, 0, 1, 0)
	SliderKnob.Position = UDim2.new(pos, 0, 0.5, 0)
	_G.WalkSpeed = math.floor(16 + (pos * 184))
	SpeedValue.Text = tostring(_G.WalkSpeed)
end

SliderKnob.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDragging = true
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDragging = false
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		updateSlider(input)
	end
end)

-- [[ NOCLIP TOGGLE ]]
local NoclipBtn = Instance.new("TextButton", Content)
NoclipBtn.Size = UDim2.new(1, 0, 0, 42)
NoclipBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 23)
NoclipBtn.Text = "Noclip Status"
NoclipBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
NoclipBtn.Font = Enum.Font.GothamMedium
NoclipBtn.TextSize = 13
Instance.new("UICorner", NoclipBtn).CornerRadius = UDim.new(0, 10)

local ToggleBar = Instance.new("Frame", NoclipBtn)
ToggleBar.Size = UDim2.new(0, 0, 0, 3)
ToggleBar.Position = UDim2.new(0.5, 0, 1, -3)
ToggleBar.AnchorPoint = Vector2.new(0.5, 0)
ToggleBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
Instance.new("UICorner", ToggleBar)

NoclipBtn.MouseButton1Click:Connect(function()
	_G.Noclip = not _G.Noclip
	if _G.Noclip then
		TweenService:Create(ToggleBar, Smooth, {Size = UDim2.new(0.6, 0, 0, 3)}):Play()
		NoclipBtn.TextColor3 = Color3.new(1, 1, 1)
	else
		TweenService:Create(ToggleBar, Smooth, {Size = UDim2.new(0, 0, 0, 3)}):Play()
		NoclipBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
	end
end)

-- [[ ENGINE LOOP ]]
RunService.Stepped:Connect(function()
	pcall(function()
		local char = Player.Character
		if char then
			if char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = _G.WalkSpeed end
			if _G.Noclip then
				for _, v in pairs(char:GetDescendants()) do
					if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
				end
			end
		end
	end)
end)

print("JUST STUDIO : AETHER CORE LOADED")
