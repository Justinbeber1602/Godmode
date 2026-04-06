local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- [[ SETTINGS ]]
_G.WalkSpeed = 16
_G.Noclip = false

-- [[ TWEEN INFOS (For Global Smoothness) ]]
local Instant = TweenInfo.new(0)
local Quick = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local Smooth = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local Slow = TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

-- [[ UI CONSTRUCT: AETHER INTERFACE ]]
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "Aether_Interface"
ScreenGui.ResetOnSpawn = false

-- Main Canvas (Floating Panel with Glassmorphism)
local Canvas = Instance.new("Frame", ScreenGui)
Canvas.Size = UDim2.new(0, 320, 0, 200)
Canvas.Position = UDim2.new(0.5, -160, 0.5, -100)
Canvas.BackgroundColor3 = Color3.fromRGB(10, 10, 12) -- Ultra Dark
Canvas.BackgroundTransparency = 0.2 -- Slightly transparent for blur effect (requires special executor support for real blur)
Canvas.BorderSizePixel = 0
Canvas.Active = true
Canvas.Draggable = true
Canvas.ClipsDescendants = false -- Allow glow to spill out
Instance.new("UICorner", Canvas).CornerRadius = UDim.new(0, 16)

-- Subtle Blue Glow Background
local GlowBkg = Instance.new("ImageLabel", Canvas)
GlowBkg.Size = UDim2.new(1.3, 0, 1.3, 0)
GlowBkg.Position = UDim2.new(-0.15, 0, -0.15, 0)
GlowBkg.BackgroundTransparency = 1
GlowBkg.Image = "rbxassetid://13978345203" -- Radial Gradient Image
GlowBkg.ImageColor3 = Color3.fromRGB(0, 150, 255)
GlowBkg.ImageTransparency = 0.9 -- Very subtle
GlowBkg.ZIndex = 0

-- Header Area (No Background, just Text and Close)
local Header = Instance.new("Frame", Canvas)
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundTransparency = 1
Header.ZIndex = 2

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Text = "JustHub"
Title.TextColor3 = Color3.fromRGB(240, 240, 240) -- Pure White
Title.TextSize = 16
Title.Font = Enum.Font.GothamMedium -- Clean Font
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Elegant Close Button (Icon only)
local Close = Instance.new("TextButton", Header)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -40, 0.5, -15)
Close.Text = "✕" -- Clean X character
Close.TextColor3 = Color3.fromRGB(150, 150, 150) -- Faded Gray
Close.TextSize = 18
Close.BackgroundTransparency = 1
Close.Font = Enum.Font.GothamMedium
Close.ZIndex = 3
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- CLOSE BUTTON ANIMATION
Close.MouseEnter:Connect(function() TweenService:Create(Close, Quick, {TextColor3 = Color3.fromRGB(255, 80, 80)}):Play() end)
Close.MouseLeave:Connect(function() TweenService:Create(Close, Quick, {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play() end)

-- [[ CONTENT CONTAINER ]]
local Content = Instance.new("Frame", Canvas)
Content.Position = UDim2.new(0, 20, 0, 55)
Content.Size = UDim2.new(1, -40, 1, -70)
Content.BackgroundTransparency = 1
Content.ZIndex = 2

local UIList = Instance.new("UIListLayout", Content)
UIList.Padding = UDim.new(0, 20)
UIList.SortOrder = Enum.SortOrder.LayoutOrder

-- [[ SPEED SLIDER (Minimalist Fluid Design) ]]
local SpeedFrame = Instance.new("Frame", Content)
SpeedFrame.Size = UDim2.new(1, 0, 0, 50)
SpeedFrame.BackgroundTransparency = 1
SpeedFrame.LayoutOrder = 1

local SpeedLabelFrame = Instance.new("Frame", SpeedFrame)
SpeedLabelFrame.Size = UDim2.new(1, 0, 0, 20)
SpeedLabelFrame.BackgroundTransparency = 1

local SpeedTitle = Instance.new("TextLabel", SpeedLabelFrame)
SpeedTitle.Size = UDim2.new(0.6, 0, 1, 0)
SpeedTitle.Text = "Velocitas" -- Velocitas is Latin for Speed
SpeedTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SpeedTitle.Font = Enum.Font.GothamMedium
SpeedTitle.TextSize = 13
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left

local SpeedValue = Instance.new("TextLabel", SpeedLabelFrame)
SpeedValue.Size = UDim2.new(0.4, 0, 1, 0)
SpeedValue.Position = UDim2.new(0.6, 0, 0, 0)
SpeedValue.Text = "16"
SpeedValue.TextColor3 = Color3.fromRGB(0, 200, 255) -- Cyan Accent
SpeedValue.Font = Enum.Font.GothamBold
SpeedValue.TextSize = 13
SpeedValue.BackgroundTransparency = 1
SpeedValue.TextXAlignment = Enum.TextXAlignment.Right

-- Slider Track (Thinner, cleaner)
local SliderTrack = Instance.new("Frame", SpeedFrame)
SliderTrack.Position = UDim2.new(0, 0, 1, -8)
SliderTrack.Size = UDim2.new(1, 0, 0, 2) -- Very thin track
SliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
SliderTrack.BorderSizePixel = 0
Instance.new("UICorner", SliderTrack).CornerRadius = UDim.new(1, 0)

-- Slider Fill (Glowing Cyan)
local SliderFill = Instance.new("Frame", SliderTrack)
SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
SliderFill.BorderSizePixel = 0
Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

-- Slider Glow Effect
local SliderGlow = Instance.new("Frame", SliderFill)
SliderGlow.Size = UDim2.new(1, 10, 1, 10)
SliderGlow.Position = UDim2.new(0, -5, 0, -5)
SliderGlow.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
SliderGlow.BackgroundTransparency = 0.7 -- Glowing fill
SliderGlow.ZIndex = -1
Instance.new("UICorner", SliderGlow).CornerRadius = UDim.new(1, 0)

-- Slider Knob (Fluid and Reactive)
local SliderKnob = Instance.new("TextButton", SliderTrack)
SliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
SliderKnob.Position = UDim2.new(0, 0, 0.5, 0)
SliderKnob.Size = UDim2.new(0, 12, 0, 12) -- Initially small
SliderKnob.BackgroundColor3 = Color3.new(1, 1, 1)
SliderKnob.Text = ""
SliderKnob.ZIndex = 3
Instance.new("UICorner", SliderKnob).CornerRadius = UDim.new(1, 0)

-- Knob Glow and Hover Animation
local KnobGlow = Instance.new("Frame", SliderKnob)
KnobGlow.Size = UDim2.new(1.8, 0, 1.8, 0)
KnobGlow.Position = UDim2.new(-0.4, 0, -0.4, 0)
KnobGlow.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
KnobGlow.BackgroundTransparency = 1 -- Initially hidden
KnobGlow.ZIndex = -2
Instance.new("UICorner", KnobGlow).CornerRadius = UDim.new(1, 0)

-- KNOB INTERACTION ANIMATION
SliderKnob.MouseEnter:Connect(function()
	TweenService:Create(SliderKnob, Quick, {Size = UDim2.new(0, 16, 0, 16)}):Play() -- Scale up
	TweenService:Create(KnobGlow, Quick, {BackgroundTransparency = 0.6}):Play() -- Show glow
end)
SliderKnob.MouseLeave:Connect(function()
	if not isDraggingSlider then
		TweenService:Create(SliderKnob, Quick, {Size = UDim2.new(0, 12, 0, 12)}):Play() -- Scale down
		TweenService:Create(KnobGlow, Quick, {BackgroundTransparency = 1}):Play() -- Hide glow
	end
end)

-- [[ NOCLIP TOGGLE (Clean minimal button) ]]
local NoclipBtn = Instance.new("TextButton", Content)
NoclipBtn.Size = UDim2.new(1, 0, 0, 42)
NoclipBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 23)
NoclipBtn.Text = "(Noclip)"
NoclipBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
NoclipBtn.Font = Enum.Font.GothamMedium
NoclipBtn.TextSize = 13
NoclipBtn.LayoutOrder = 2
NoclipBtn.AutoButtonColor = false -- Disable default effect
Instance.new("UICorner", NoclipBtn).CornerRadius = UDim.new(0, 10)

-- Toggle State Indicator (Subtle bottom bar)
local ToggleBar = Instance.new("Frame", NoclipBtn)
ToggleBar.Size = UDim2.new(0, 0, 0, 3) -- Initially 0 width
ToggleBar.Position = UDim2.new(0.5, 0, 1, -3)
ToggleBar.AnchorPoint = Vector2.new(0.5, 0)
ToggleBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
ToggleBar.ZIndex = 2
Instance.new("UICorner", ToggleBar).CornerRadius = UDim.new(1, 0)

-- TOGGLE INTERACTION ANIMATION
NoclipBtn.MouseEnter:Connect(function() TweenService:Create(NoclipBtn, Quick, {BackgroundColor3 = Color3.fromRGB(25, 25, 29)}):Play() end)
NoclipBtn.MouseLeave:Connect(function() TweenService:Create(NoclipBtn, Quick, {BackgroundColor3 = Color3.fromRGB(20, 20, 23)}):Play() end)

-- [[ LOGIC: FLUID UNIVERSAL SLIDER (PC & MOBILE) ]]
isDraggingSlider = false

local function updateSlider(input)
	local inputPos = input.Position.X
	if input.UserInputType == Enum.UserInputType.Touch then inputPos = input.Position.X end
	local pos = math.clamp((inputPos - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
	
	-- Animate slider fill and knob position smoothly
	TweenService:Create(SliderFill, Instant, {Size = UDim2.new(pos, 0, 1, 0)}):Play()
	TweenService:Create(SliderKnob, Instant, {Position = UDim2.new(pos, 0, 0.5, 0)}):Play()
	
	_G.WalkSpeed = math.floor(16 + (pos * 184)) -- Range 16-200
	SpeedValue.Text = tostring(_G.WalkSpeed)
end

SliderKnob.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDraggingSlider = true
		updateSlider(input) -- Update immediately on press
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDraggingSlider = false
		-- Scale knob back down if mouse left knob while dragging
		TweenService:Create(SliderKnob, Quick, {Size = UDim2.new(0, 12, 0, 12)}):Play()
		TweenService:Create(KnobGlow, Quick, {BackgroundTransparency = 1}):Play()
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if isDraggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		updateSlider(input)
	end
end)

-- [[ LOGIC: NOCLIP TOGGLE ANIMATION & COLOR ]]
local function updateNoclipUI(status)
	_G.Noclip = status
	if _G.Noclip then
		TweenService:Create(ToggleBar, Smooth, {Size = UDim2.new(0.6, 0, 0, 3)}):Play() -- Expand bar
            TweenService:Create(NoclipBtn, Smooth, {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play() -- Highlight text
        else
		TweenService:Create(ToggleBar, Smooth, {Size = UDim2.new(0, 0, 0, 3)}):Play() -- Retract bar
		TweenService:Create(NoclipBtn, Smooth, {TextColor3 = Color3.fromRGB(180, 180, 180)}):Play() -- Dim text
	end
end

updateNoclipUI(_G.Noclip) -- Initialize state

NoclipBtn.MouseButton1Click:Connect(function()
	updateNoclipUI(not _G.Noclip)
end)

-- [[ BYPASS ENGINE (Runs Every Frame) ]]
RunService.Stepped:Connect(function()
	pcall(function()
		local char = Player.Character
		if char then
			-- Speed Bypass
			if char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = _G.WalkSpeed end
			-- Noclip Logic
			if _G.Noclip then
				for _, part in pairs(char:GetDescendants()) do
					if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
				end
			end
		end
	end)
end)

print("AETHER CORE // LOADED")  
