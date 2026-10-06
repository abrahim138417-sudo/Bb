local P, U, R = game:GetService("Players"), game:GetService("UserInputService"), game:GetService("RunService")
local LP, Cam, Hold = P.LocalPlayer, workspace.CurrentCamera, false

local function isAim(i) 
    return i.UserInputType == Enum.UserInputType.MouseButton2 or i.KeyCode == Enum.KeyCode.ButtonR2 
end

U.InputBegan:Connect(function(i, g) 
    if not g and isAim(i) then Hold = true end 
end)

U.InputEnded:Connect(function(i) 
    if isAim(i) then Hold = false end 
end)

R.RenderStepped:Connect(function()
    if not Hold then return end
    local Target, MinD = nil, 300
    for _, v in pairs(P:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local Pos, OnS = Cam:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            local Dist = (Vector2.new(Pos.X, Pos.Y) - U:GetMouseLocation()).Magnitude
            if OnS and Dist < MinD then 
                MinD, Target = Dist, v.Character.HumanoidRootPart 
            end
        end
    end
    if Target then 
        Cam.CFrame = CFrame.new(Cam.CFrame.Position, Target.Position) 
    end
end)
