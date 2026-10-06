local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local Cam = workspace.CurrentCamera

local ScriptEnabled = false

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local EnableBtn = Instance.new("TextButton")
local DisableBtn = Instance.new("TextButton")

ScreenGui.Name = "AimControlGui"
ScreenGui.Parent = LP:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.5, -125, 0.4, -75)
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true

local FrameCorner = Instance.new("UICorner", MainFrame)
FrameCorner.CornerRadius = UDim.new(0, 10)

Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Enable Auto Aim?"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

EnableBtn.Parent = MainFrame
EnableBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
EnableBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
EnableBtn.Size = UDim2.new(0.8, 0, 0.22, 0)
EnableBtn.Font = Enum.Font.SourceSansBold
EnableBtn.Text = "Enable"
EnableBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnableBtn.TextSize = 16
Instance.new("UICorner", EnableBtn).CornerRadius = UDim.new(0, 6)

DisableBtn.Parent = MainFrame
DisableBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
DisableBtn.Position = UDim2.new(0.1, 0, 0.72, 0)
DisableBtn.Size = UDim2.new(0.8, 0, 0.22, 0)
DisableBtn.Font = Enum.Font.SourceSansBold
DisableBtn.Text = "Disable"
DisableBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DisableBtn.TextSize = 16
Instance.new("UICorner", DisableBtn).CornerRadius = UDim.new(0, 6)

-- Button Logic
EnableBtn.MouseButton1Click:Connect(function()
    ScriptEnabled = true
    MainFrame.Visible = false
end)

DisableBtn.MouseButton1Click:Connect(function()
    ScriptEnabled = false
    MainFrame.Visible = false
end)

-- Auto Lock Logic (Automatic without holding L2)
RunService.RenderStepped:Connect(function()
    if not ScriptEnabled then return end
    
    local Target, MinD = nil, 300
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local Pos, OnS = Cam:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            local Dist = (Vector2.new(Pos.X, Pos.Y) - UserInputService:GetMouseLocation()).Magnitude
            if OnS and Dist < MinD then 
                MinD, Target = Dist, v.Character.HumanoidRootPart 
            end
        end
    end
    
    if Target then 
        Cam.CFrame = CFrame.new(Cam.CFrame.Position, Target.Position) 
    end
end)
