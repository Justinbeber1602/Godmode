-- [[ JUST STUDIO : AETHER x RAYFIELD (ENGINE PRESERVED) ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- [[ 1. YOUR ORIGINAL SETTINGS & VARIABLES ]]
local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

_G.WalkSpeed = 16
_G.Noclip = false

-- [[ 2. RAYFIELD UI (Replacing your ScreenGui/Frame/Slider Construct) ]]
local Window = Rayfield:CreateWindow({
   Name = "JUSTHUB",
   LoadingTitle = "JustGod",
   LoadingSubtitle = "by JUST STUDIO",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local MainTab = Window:CreateTab("Main Controls", 4483362458)

-- Speed Slider (Linked to your _G.WalkSpeed)
MainTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 200},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "WS_Slider", 
   Callback = function(Value)
      _G.WalkSpeed = Value -- ใช้ตัวแปรเดิมของคุณ
   end,
})

-- Noclip Toggle (Linked to your _G.Noclip)
MainTab:CreateToggle({
   Name = "Noclip Status",
   CurrentValue = false,
   Flag = "Noclip_Toggle",
   Callback = function(Value)
      _G.Noclip = Value -- ใช้ตัวแปรเดิมของคุณ
   end,
})

-- [[ 3. YOUR ORIGINAL ENGINE LOOP (STRICTLY UNCHANGED) ]]
RunService.Stepped:Connect(function()
    pcall(function()
        local char = Player.Character
        if char then
            -- Speed Bypass
            if char:FindFirstChild("Humanoid") then 
                char.Humanoid.WalkSpeed = _G.WalkSpeed 
            end
            -- Noclip Logic
            if _G.Noclip then
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide then 
                        v.CanCollide = false 
                    end
                end
            end
        end
    end)
end)

print("JUST STUDIO")
