local ReplicatedStorage = game:GetService("ReplicatedStorage")
local functions = {}
local pfunctions = require("../../../modules/functions")
local player = game:GetService("Players").LocalPlayer
local remotes = ReplicatedStorage:FindFirstChild("Remotes")

functions.getTypes = function()
	local types = {}

	for _, brainrot in pairs(ReplicatedStorage:FindFirstChild("BrainrotsFoldered"):GetChildren()) do
		table.insert(types, brainrot)
	end

	return types
end

function functions.getBrainrots(body)
	local brainrots = {}

	for _, brainrot in pairs(ReplicatedStorage:FindFirstChild("BrainrotsFoldered"):GetChildren()) do
		if brainrot.Name == body then
			for _, part in pairs(brainrot:GetChildren()) do
				table.insert(brainrots, part)
			end
		end
	end

	return brainrots
end

function functions.spawn(brainrot)
	local remote = remotes:FindFirstChild("placeBrainrot")

	if remote then
		remote:FireServer(brainrot, pfunctions.getRoot(player).CFrame)
	end
end

return functions
