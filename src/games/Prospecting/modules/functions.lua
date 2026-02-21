local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remotes = ReplicatedStorage:FindFirstChild("Remotes")
local invRemotes = remotes:FindFirstChild("Inventory")
local shopRemotes = remotes:FindFirstChild("Shop")
local player = game:GetService("Players").LocalPlayer
local pfunctions = require("../../../modules/functions")
local functions = {}
local animator = pfunctions.getHumanoid(player):WaitForChild("Animator")
local panningAnimations = ReplicatedStorage.Assets.Animations.Panning
local digWindUpAnimation = animator:LoadAnimation(panningAnimations.DigWindUp)
local locations = require("./locations")
local misc = require("./misc")
local rarities = require("./rarities")

function functions.shake()
	for _, i in pairs(pfunctions.getChar(player):GetChildren()) do
		if string.find(i.Name, "Pan") or string.find(i.Name, "Worldshaker") then
			local scripts = i:FindFirstChild("Scripts")
			if scripts then
				local shake = scripts:FindFirstChild("Shake")
				if shake then
					shake:FireServer()
				end
			end
		end
	end
end

function functions.pan()
	for _, i in pairs(pfunctions.getChar(player):GetChildren()) do
		if string.find(i.Name, "Pan") or string.find(i.Name, "Worldshaker") then
			local scripts = i:FindFirstChild("Scripts")
			if scripts then
				local pan = scripts:FindFirstChild("Pan")
				if pan then
					pan:InvokeServer()
				end
			end
		end
	end
end

function functions.fill()
	for _, i in pairs(pfunctions.getChar(player):GetChildren()) do
		if string.find(i.Name, "Pan") or string.find(i.Name, "Worldshaker") then
			local scripts = i:FindFirstChild("Scripts")
			if scripts then
				local fill = scripts:FindFirstChild("Collect")
				if fill then
					fill:InvokeServer()
					fill:InvokeServer(9e9)
				end
			end
		end
	end
end

function functions.toggleShovel(val)
	for _, i in pairs(pfunctions.getChar(player):GetChildren()) do
		if string.find(i.Name, "Pan") or string.find(i.Name, "Worldshaker") then
			local scripts = i:FindFirstChild("Scripts")
			if scripts then
				local toggleShovel = scripts:FindFirstChild("ToggleShovelActive")
				if toggleShovel then
					toggleShovel:FireServer(val)
				end
			end
		end
	end
end

function functions.sell(ore)
	if shopRemotes then
		local sellall = shopRemotes:FindFirstChild("SellAll")
		if sellall then
			sellall:InvokeServer(ore)
		end
	end
end

function functions.lock(ore)
	if invRemotes then
		local togglelock = invRemotes:FindFirstChild("ToggleLock")
		if togglelock then
			togglelock:FireServer(ore)
		end
	end
end

function functions.playDigAnim()
	if pfunctions.getChar(player):FindFirstChild("Shovel") then
		animator = pfunctions.getHumanoid(player):WaitForChild("Animator")
		digWindUpAnimation:Play(0.25)
	end
end

function functions.stopDigAnim()
	digWindUpAnimation:Stop()
end

function functions.getLocation(type)
	return locations[type][misc.currentLocation][1]
end

function functions.selling()
	for _, i in pairs(rarities) do
		if i["Selling"] and i["Selling"] == true then
			return true
		end
	end

	return false
end

return functions
