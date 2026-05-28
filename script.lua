-- Delta Executor ile %100 Uyumlu Gelişmiş Hile Menüsü
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- 1. Pencereyi Oluştur (Ekranın ortasında çok şık bir menü açar)
local Window = OrionLib:MakeWindow({
    Name = "AI Premium Menu v2", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "OrionTest"
})

-- Kısayollar
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- 2. Sekmeleri Oluştur
local MainTab = Window:MakeTab({ Name = "Ana Özellikler", Icon = "rbxassetid://4483345998", Premium = false })
local MovementTab = Window:MakeTab({ Name = "Hareket/Uçma", Icon = "rbxassetid://4483345998", Premium = false })

-- ANA ÖZELLİKLER SEKRESİ
-- Hitbox Silme / Görünmezlik
MainTab:AddToggle({
    Name = "Hitbox'ı Tamamen Sil (Dokunulmazlık)",
    Default = false,
    Callback = function(Value)
        _G.HitboxSil = Value
        task.spawn(function()
            while _G.HitboxSil do
                local char = LocalPlayer.Character
                if char then
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = Value and 1 or 0
                            part.CanCollide = not Value
                        end
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
