local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("CharacterMesh") then
				child:Destroy()
			end
		end
	end)
end)
