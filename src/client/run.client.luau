local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local UIS = game:GetService("UserInputService")

-- load your non-sword run animation
local runNoSword = humanoid:LoadAnimation(game.StarterPlayer.StarterCharacterScripts.Animate.run.RunAnim)
local walkNoSword = humanoid:LoadAnimation(game.StarterPlayer.StarterCharacterScripts.Animate.walk.WalkAnim)
local idleNoSword = humanoid:LoadAnimation(game.StarterPlayer.StarterCharacterScripts.Animate.idle.Animation1)

local isHoldingShift = false
local currentState = "Idle"

UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	if input.KeyCode == Enum.KeyCode.LeftShift then
		isHoldingShift = true
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		isHoldingShift = false
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	-- only run this if katana is NOT equipped
	local tool = char:FindFirstChildOfClass("Tool")
	if tool and tool.Name == "Katana" then
		return
	end

	local moving = humanoid.MoveDirection.Magnitude > 0

	if moving and isHoldingShift and currentState ~= "Run" then
		idleNoSword:Stop()
		walkNoSword:Stop()
		runNoSword:Play()
		currentState = "Run"
	elseif moving and not isHoldingShift and currentState ~= "Walk" then
		idleNoSword:Stop()
		runNoSword:Stop()
		walkNoSword:Play()
		currentState = "Walk"
	elseif not moving and currentState ~= "Idle" then
		walkNoSword:Stop()
		runNoSword:Stop()
		idleNoSword:Play()
		currentState = "Idle"
	end
end)
