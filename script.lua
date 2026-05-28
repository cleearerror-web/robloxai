-- Basit ve Stabil Kod
local player = game.Players.LocalPlayer
local char = player.Character

-- 1. Görünmezlik (Bunu manuel açıp kapatmak için kodu tekrar execute et)
for _, v in pairs(char:GetDescendants()) do
    if v:IsA("BasePart") then v.Transparency = 1 end
end

-- 2. Hız (Konsola '_G.Speed = 100' yazarsan çalışır)
_G.Speed = 16
game:GetService("RunService").RenderStepped:Connect(function()
    if char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = _G.Speed
    end
end)

-- 3. Uçma (Konsola '_G.Fly = true' yaz)
_G.Fly = false
game:GetService("RunService").RenderStepped:Connect(function()
    if _G.Fly and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.Velocity = Vector3.new(0, 50, 0)
    end
end)

print("Script yüklendi! Hız için: _G.Speed = 100 | Uçmak için: _G.Fly = true")
end
                end
                task.wait(1)
            end
        end)
    end    
})

-- ESP (Duvar Arkası Görme)
MainTab:AddToggle({
    Name = "ESP (Oyuncuları Göster)",
    Default = false,
    Callback = function(Value)
        _G.ESPActive = Value
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                if Value then
                    if not p.Character:FindFirstChild("Highlight") then
                        Instance.new("Highlight", p.Character).FillColor = Color3.fromRGB(255, 0, 0)
                    end
                else
                    if p.Character:FindFirstChild("Highlight") then
                        p.Character.Highlight:Destroy()
                    end
                end
            end
        end
    end    
})

-- HAREKET VE UÇMA SEKRESİ
-- Speed Hack (Kaydırıcı / Slider ile ayarlanabilir)
MovementTab:AddSlider({
    Name = "Yürüme Hızı (Speed)",
    Min = 16,
    Max = 300,
    Default = 16,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Hız",
    Callback = function(Value)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = Value
        end
    end    
})

-- Noclip (Duvarlardan Geçme)
MovementTab:AddToggle({
    Name = "Noclip (Duvar Geçişi)",
    Default = false,
    Callback = function(Value)
        _G.Noclip = Value
        RunService.Stepped:Connect(function()
            if _G.Noclip and LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    end    
})

-- Infinite Jump (Sonsuz Zıplama)
MovementTab:AddToggle({
    Name = "Sonsuz Zıplama (Inf Jump)",
    Default = false,
    Callback = function(Value)
        _G.InfJump = Value
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if _G.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end)
    end    
})

-- Fly (Uçma Modu)
MovementTab:AddToggle({
    Name = "Uçma Modu (Fly)",
    Default = false,
    Callback = function(Value)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            if Value then
                local bv = Instance.new("BodyVelocity", char.HumanoidRootPart)
                bv.Name = "DeltaFly"
                bv.Velocity = Vector3.new(0, 30, 0) -- Havada asılı tutar/yükseltir
                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            else
                if char.HumanoidRootPart:FindFirstChild("DeltaFly") then
                    char.HumanoidRootPart.DeltaFly:Destroy()
                end
            end
        end
    end    
})

OrionLib:Init()
