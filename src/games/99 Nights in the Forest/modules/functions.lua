local functions = {}
local warn = require("../../../modules/warn")
local player = game:GetService("Players").LocalPlayer
local pfunctions = require("../../../modules/functions")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local remotes = ReplicatedStorage:FindFirstChild("RemoteEvents")

-- get items & characters
function functions.getItems()
	local types = {}

	for _, part in pairs(Workspace:FindFirstChild("Items"):GetChildren()) do
		table.insert(types, part)
	end

	return types
end

function functions.getCharacters()
	local types = {}

	for _, part in pairs(Workspace:FindFirstChild("Characters"):GetChildren()) do
		table.insert(types, part)
	end

	return types
end

-- search items
function functions.searchItems(name)
	local items = {}

	local lowercaseSearchName = string.lower(name)
	for _, part in pairs(Workspace:FindFirstChild("Items"):GetChildren()) do
		local lowercaseName = string.lower(part.Name)
		if string.find(lowercaseName, lowercaseSearchName) then
			table.insert(items, part)
		end
	end

	return items
end

-- open chests
function functions.openChests()
	local chests = {}

	for _, part in pairs(Workspace:FindFirstChild("Items"):GetChildren()) do
		if string.find(part.Name, "Chest") then
			local main = part:FindFirstChild("Main")
			if main then
				local proximityAttachment = main:FindFirstChild("ProximityAttachment")
				if proximityAttachment then
					local proximityInteraction = proximityAttachment:FindFirstChild("ProximityInteraction")
					if proximityInteraction then
						pfunctions.getRoot(player).CFrame = main.CFrame
						task.wait(0.1)
						fireproximityprompt(proximityInteraction)
						task.wait(0.1)
					end
				end
			end
		end
	end

	return chests
end

-- weapon stuff
function functions.getWeapon()
	local weapon
	local highestdamage = 0
	if pfunctions.isAlive(player) then
		if player:FindFirstChild("Inventory") then
			for _, i in pairs(player["Inventory"]:GetChildren()) do
				if i:GetAttribute("WeaponDamage") and i:GetAttribute("WeaponDamage") > highestdamage then
					weapon = i
				end
			end
		end
	end

	return weapon or false
end

function functions.hit(char, tool)
	if remotes then
		remotes.ToolDamageObject:InvokeServer(char, tool, "1_" .. player.UserId, char.PrimaryPart.CFrame)
	end
end

-- bag
function functions.getBag()
	if pfunctions.isAlive(player) then
		if player:FindFirstChild("Inventory") then
			for _, i in pairs(player["Inventory"]:GetChildren()) do
				if i:GetAttribute("ToolName") == "Item Bag" then
					return i
				end
			end
		end
	end

	return false
end

function bagCapacity(bagInstance)
	return bagInstance:GetAttribute("Capacity")
end

function functions.storeItem(bagInstance, item)
	if remotes then
		local baggedItems = bagInstance:GetChildren()
		if bagCapacity(bagInstance) <= #baggedItems then
			warn("Bag is full!")
		else
			table.insert(baggedItems, item)
			remotes.RequestBagStoreItem:InvokeServer(bagInstance, item)
		end
	end
end

function functions.dropItem(bagInstance, cframe) -- u cant pick up if u do this so yea..
	if remotes then
		local baggedItems = bagInstance:GetChildren()
		if #baggedItems > 0 then
			local item = baggedItems[#baggedItems]
			if item:GetAttribute("PlayerBody") then
				item.Parent = ReplicatedStorage.TempStorage
			else
				item:SetAttribute("LastOwner", player.UserId)
				item:SetAttribute("LastDropTime", time())
				item:PivotTo(cframe)
				item.Parent = Workspace.Items
			end
			if item:GetAttribute("RagdollBody") or item:GetAttribute("PlayerBody") then
				for _, i in pairs(item:GetChildren()) do
					if i:IsA("BasePart") and i.Name ~= "HumanoidRootPart" then
						i.CanCollide = true
						i.Massless = true
					end
				end
			end

			remotes.RequestBagDropItem:FireServer(bagInstance, item)
		end
	end
end

-- food stuff
function functions.cook(item)
	if remotes then
		remotes.RequestCookItem:FireServer(
			Workspace:FindFirstChild("Map"):FindFirstChild("Campground"):FindFirstChild("MainFire"),
			item
		)
	end
end

function functions.crockpot(item)
	if remotes then
		remotes.RequestCrockpotItem:InvokeServer(
			Workspace:FindFirstChild("Structures"):FindFirstChild("Crock Pot"),
			item
		)
	end
end

function functions.eat(item)
	if remotes then
		remotes.RequestConsumeItem:InvokeServer(item)
	end
end

-- grab & drop
function functions.grab(item)
	if remotes then
		remotes.RequestStartDraggingItem:FireServer(item)
	end
end

function functions.drop(item)
	if remotes then
		remotes.StopDraggingItem:FireServer(item)
	end
end

-- revive
function functions.revive(plr)
	if remotes then
		remotes.RequestRevivePlayer:FireServer(plr)
	end
end

-- burn & scrap items
function functions.burn(item)
	functions.grab(item)
	task.wait(0.01)
	item:PivotTo(
		Workspace:FindFirstChild("Map"):FindFirstChild("Campground"):FindFirstChild("MainFire").PrimaryPart.CFrame
			+ Vector3.new(math.random(0, 3), math.random(10, 20), math.random(0, 3))
	)
	task.wait(0.01)
	functions.drop(item)
end

function functions.scrap(item)
	functions.grab(item)
	task.wait(0.01)
	item:PivotTo(
		Workspace:FindFirstChild("Map"):FindFirstChild("Campground"):FindFirstChild("CraftingBench").PrimaryPart.CFrame
			+ Vector3.new(0, 5, 0)
	)
	task.wait(0.01)
	functions.drop(item)
end

-- get injured teammates (I HATE MY TEAMMATES)
function functions.getInjuredTeammates()
	local body = {}

	for _, part in pairs(Workspace:FindFirstChild("Characters"):GetChildren()) do
		if part:GetAttribute("PlayerBody") then
			table.insert(body, part)
		end
	end

	return body
end

-- hotbar item
function functions.hotbar(item)
	if remotes then
		remotes.RequestHotbarItem:InvokeServer(item)
	end
end

-- plant item
function functions.plant(item, vector)
	if remotes then
		remotes.RequestPlantItem:InvokeServer(item, vector)
	end
end

-- get closest character
function functions.getClosestChar()
	local closest = nil
	local maxdistance = math.huge

	for _, character in pairs(functions.getCharacters()) do
		if
			character:FindFirstChild("NPC")
			and character["NPC"].Health ~= 0
			and character.PrimaryPart
			and not character:GetAttribute("NotAttackable")
		then
			local oPos = pfunctions.getRoot(player).Position
			local pPos = character.PrimaryPart.Position

			local distance = (oPos - pPos).Magnitude
			if distance < maxdistance then
				closest = character
				maxdistance = distance
			end
		end
	end

	return closest
end

return functions
