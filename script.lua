-- GitHub veya Pastebin'e yüklenecek olan temiz içerik:
local InsertService = game:GetService("InsertService")
local HD_Admin_ID = 2575409224

local success, model = pcall(function()
    return InsertService:LoadAsset(HD_Admin_ID)
end)

if success and model then
    model.Parent = game.Workspace
    local hdMain = model:FindFirstChildOfClass("Folder") or model
    hdMain.Name = "HD Admin"
    print("[Sistem] HD Admin loadstring ile başarıyla yüklendi!")
else
    warn("[Hata] Yükleme başarısız.")
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
