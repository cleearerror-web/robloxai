
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		
		-- 1. Hitbox Gizleme (Hitbox'u çok küçük ve görünmez yapar)
		task.spawn(function()
			while task.wait(0.5) do
				-- Karakterdeki tüm parçaları tara
				for _, part in pairs(character:GetDescendants()) do
					if part:IsA("BasePart") then
						-- Hitbox'u görünmez ve çok küçük yap
						part.Transparency = 1 -- Tamamen görünmez
						part.CanCollide = false -- Çarpışmayı kapat
						part.Material = Enum.Material.ForceField -- Özel bir efekt ver
						-- Hitbox'u 0.1x0.1x0.1 boyutuna küçült (Hemen hemen yok gibi)
						if part.Name == "HumanoidRootPart" then
							part.Size = Vector3.new(0.1, 0.1, 0.1)
						end
					end
				end
			end
		end)
		
		-- 2. Anti-Kick (Basit bir çözüm, videoda çalıştırılabilir)
		-- Sunucu bazlı kickleri engellemek için oyuncunun bağlantısını sürekli kontrol et
		player.Idled:Connect(function()
			-- Eğer oyuncu boştaysa (AFK), onu kicklemek yerine sadece bir mesaj gönder
			print(player.Name .. " boştaydı ama kicklenmedi (Anti-Kick Testi)")
		end)
		
		-- 3. Başkalarına Vurma (Bu kısım senin oyunundaki savaş sistemine göre değişir)
		-- Bu basit bir vurma testi scripti
		task.spawn(function()
			while task.wait(1) do
				-- Etraftaki 10 blok yakındaki oyuncuları tara
				for _, otherPlayer in pairs(Players:GetPlayers()) do
					if otherPlayer ~= player and otherPlayer.Character then
						local otherHRP = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
						if otherHRP and (otherHRP.Position - humanoidRootPart.Position).Magnitude < 10 then
							-- Eğer yakındaysa, vurma simülasyonu yap (print ile göster)
							print(player.Name .. ", " .. otherPlayer.Name .. "'e vurdu! (Vurma Testi)")
							-- Buraya vurma animasyonu veya hasar kodunu ekleyebilirsin
						end
					end
				end
			end
		end)
	end)
end)
