-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomCrosshairUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Settings Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 260, 0, 280)
mainFrame.Position = UDim2.new(0, 30, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Crosshair Settings"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 45)
padding.PaddingLeft = UDim.new(0, 15)
padding.PaddingRight = UDim.new(0, 15)
padding.Parent = mainFrame

-- Default settings variables
local currentShape = "Dot"
local currentColor = Color3.fromRGB(0, 255, 100)
local currentSize = 6

--------------------------------------------------
-- Center Crosshair Dot Creation
--------------------------------------------------
local crosshairFrame = Instance.new("Frame")
crosshairFrame.Name = "CenterDot"
crosshairFrame.AnchorPoint = Vector2.new(0.5, 0.5)
crosshairFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
crosshairFrame.BackgroundTransparency = 0
crosshairFrame.BorderSizePixel = 0
crosshairFrame.Parent = screenGui

local crosshairCorner = Instance.new("UICorner")
crosshairCorner.Parent = crosshairFrame

-- Function to update crosshair style and size
local function updateCrosshairStyle()
	crosshairFrame.BackgroundColor3 = currentColor
	
	if currentShape == "Dot" then
		crosshairFrame.Size = UDim2.new(0, currentSize, 0, currentSize)
		crosshairCorner.CornerRadius = UDim.new(1, 0)
		crosshairFrame.BackgroundTransparency = 0
	elseif currentShape == "Circle" then
		crosshairFrame.Size = UDim2.new(0, currentSize * 2, 0, currentSize * 2)
		crosshairCorner.CornerRadius = UDim.new(1, 0)
		crosshairFrame.BackgroundTransparency = 0.5
	elseif currentShape == "Cross" then
		crosshairFrame.Size = UDim2.new(0, currentSize * 2.5, 0, currentSize)
		crosshairCorner.CornerRadius = UDim.new(0, 0)
		crosshairFrame.BackgroundTransparency = 0
	end
end

updateCrosshairStyle()

--------------------------------------------------
-- Helper Function to Create Control Sections
--------------------------------------------------
local function createDropdownSection(nameText, options, callback)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 60)
	container.BackgroundTransparency = 1
	container.Parent = mainFrame

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 20)
	label.BackgroundTransparency = 1
	label.Text = nameText
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.TextSize = 14
	label.Font = Enum.Font.Gotham
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	local btnContainer = Instance.new("Frame")
	btnContainer.Size = UDim2.new(1, 0, 0, 35)
	btnContainer.Position = UDim2.new(0, 0, 0, 22)
	btnContainer.BackgroundTransparency = 1
	btnContainer.Parent = container

	local grid = Instance.new("UIGridLayout")
	grid.CellSize = UDim2.new(0, 70, 0, 30)
	grid.CellPadding = UDim2.new(0, 5, 0, 0)
	grid.Parent = btnContainer

	for _, opt in ipairs(options) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0, 70, 0, 30)
		btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.TextSize = 12
		btn.Font = Enum.Font.GothamMedium
		btn.Text = opt.text
		btn.Parent = btnContainer

		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 4)
		btnCorner.Parent = btn

		btn.MouseButton1Click:Connect(function()
			callback(opt.value)
		end)
	end
end

--------------------------------------------------
-- 1. Shape Option
--------------------------------------------------
createDropdownSection("1. Crosshair Shape", {
	{text = "Solid Dot", value = "Dot"},
	{text = "Circle", value = "Circle"},
	{text = "Cross", value = "Cross"}
}, function(val)
	currentShape = val
	updateCrosshairStyle()
end)

--------------------------------------------------
-- 2. Color Option
--------------------------------------------------
createDropdownSection("2. Crosshair Color", {
	{text = "Neon Green", value = Color3.fromRGB(0, 255, 100)},
	{text = "Bright Red", value = Color3.fromRGB(255, 50, 50)},
	{text = "Pure White", value = Color3.fromRGB(255, 255, 255)}
}, function(val)
	currentColor = val
	updateCrosshairStyle()
end)

--------------------------------------------------
-- 3. Size Option
--------------------------------------------------
createDropdownSection("3. Crosshair Size", {
	{text = "Small", value = 4},
	{text = "Medium", value = 7},
	{text = "Large", value = 11}
}, function(val)
	currentSize = val
	updateCrosshairStyle()
end)

