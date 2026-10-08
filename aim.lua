local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function loadScript()
    task.wait(1)
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/mshyasamh74-code/Aim.-lua/refs/heads/main/Aim.%20lua"))()
    end)
end

if LocalPlayer.Character then
    loadScript()
end

LocalPlayer.CharacterAdded:Connect(function()
    loadScript()
end)
