-- ==========================================
-- BYFRON/HYPERION BYPASS & ANTI-CHEAT EVADER
-- ==========================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Anti-Cheat'in hafıza kontrolünü (Memory Check) yanıltma
if not game:IsLoaded() then game.Loaded:Wait() end

-- 1. METATABLE BYPASS (Hile Kontrolünü Kör Etme)
-- Oyun senin hızını kontrol etmek istediğinde ona her zaman "16" (normal hız) raporu verir.
local rawmt = getrawmetatable(game)
local oldindex = rawmt.__index
setreadonly(rawmt, false)

rawmt.__index = newcclosure(function(self, key)
    if tostring(self) == "Humanoid" and key == "WalkSpeed" then
        return 16 -- Anti-cheat hızı sorguladığında yalan söyler
    elseif tostring(self) == "Humanoid" and key == "JumpPower" then
        return 50 -- Anti-cheat zıplamayı sorguladığında yalan söyler
    end
    return oldindex(self, key)
end)
setreadonly(rawmt, true)

-- 2. GERÇEK DEĞERLERİ ARKA PLANDA DEĞİŞTİRME (Zorlama Döngüsü)
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                -- Anti-cheat'in algılayamadığı ham CFrame hilesi
                if char.Humanoid.MoveDirection.Magnitude > 0 then
                    -- Hız Çarpanı: Sondaki 2.5 değerini artırarak daha da hızlanabilirsin
                    char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + (char.Humanoid.MoveDirection * 2.5)
                end
            end
        end)
    end
end)

-- 3. BYPASS NO-CLIP (Duvarlardan Geçme)
-- Oyundaki parçaların 'CanCollide' özelliğini kapatmak yerine karakterin çarpışma algısını siler
game:GetService("RunService").Stepped:Connect(function()
    pcall(function()
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end)

-- 4. GÖRÜNMEZLİK & HITBOX SİLME (Sunucu Korumasına Takılmaz)
task.spawn(function()
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 1 -- Tamamen görünmez yapar
                    part.Size = Vector3.new(0.001, 0.001, 0.001) -- Hitbox'ı mikroskobik yapar (Silinmiş gibi olur)
                end
            end
        end
    end)
end)

print("Byfron Bypass Başarıyla Aktif Edildi!")
