-- CARL VASCAL ON TOP (your original GitHub script placeholder)
print("✅ Carl Vascal on top loaded!")

-- 🔴 RED HIGHLIGHT for all other players (not yourself)
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local function addHighlight(character)
	if character == localPlayer.Character then return end
	if character:FindFirstChild("Highlight") then return end

	local rootPart = character:WaitForChild("HumanoidRootPart", 5)
	if not rootPart then return end

	local highlight = Instance.new("Highlight")
	highlight.Name = "Highlight"
	highlight.Adornee = character
	highlight.FillColor = Color3.fromRGB(255, 0, 0)
	highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = character
end

-- Apply to existing players
for _, player in pairs(Players:GetPlayers()) do
	if player ~= localPlayer and player.Character then
		addHighlight(player.Character)
	end
	player.CharacterAdded:Connect(function(char)
		if player ~= localPlayer then
			addHighlight(char)
		end
	end)
end

-- Apply to future players
Players.PlayerAdded:Connect(function(player)
	if player == localPlayer then return end
	player.CharacterAdded:Connect(addHighlight)
end)
