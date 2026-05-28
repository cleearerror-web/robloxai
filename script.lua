-- Hile Paneli (GUI)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 300)
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Frame.Draggable = true -- Paneli sürükleyebilirsin

local function CreateButton(name, callback)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(0, 180, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, #Frame:GetChildren() * 45 - 45)
    btn.Text = name
    btn.MouseButton1Click:Connect(callback)
end

-- Özellikler
CreateButton("Uçmayı Aç/Kapa", function()
    local char = game.Players.LocalPlayer.Character
    if char:FindFirstChild("BodyVelocity") then char.BodyVelocity:Destroy()
    else Instance.new("BodyVelocity", char.HumanoidRootPart).MaxForce = Vector3.new(9e9, 9e9, 9e9) end
end)

CreateButton("Noclip Aç/Kapa", function()
    _G.NoClip = not _G.NoClip
    game:GetService("RunService").Stepped:Connect(function()
        if _G.NoClip then game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = false end
    end)
end)

CreateButton("Hız (Speed) 100", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

CreateButton("Sonsuz Zıplama", function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end)
end)

CreateButton("Hitbox'ı Sil", function()
    for _, p in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if p:IsA("BasePart") then p.Transparency = 1 p.CanCollide = false end
    end
end)
