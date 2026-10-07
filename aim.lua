local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 120)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Control Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

ToggleButton.Parent = MainFrame
ToggleButton.Position = UDim2.new(0.1, 0, 0.4, 0)
ToggleButton.Size = UDim2.new(0.8, 0, 0.4, 0)
ToggleButton.Text = "Status: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local Enabled = false
ToggleButton.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    if Enabled then
        ToggleButton.Text = "Status: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
    else
        ToggleButton.Text = "Status: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    end
end)
