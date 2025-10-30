local Players = game:GetService("Players")

local function enforceBlockyAvatar(player)
	local function removeMeshes(character)
		local humanoid = character:WaitForChild("Humanoid")
		local description = humanoid:GetAppliedDescription()

		description.Head = 0
		description.Torso = 0
		description.LeftArm = 0
		description.RightArm = 0
		description.LeftLeg = 0
		description.RightLeg = 0

		humanoid:ApplyDescription(description)
	end

	player.CharacterAdded:Connect(removeMeshes)
end

local function init()
	Players.PlayerAdded:Connect(enforceBlockyAvatar)
end

return {
	init = init,
}
