local cast = require("../../../modules/services")

local ReplicatedStorage = cast("ReplicatedStorage")
local Players = cast("Players")
local remotes = ReplicatedStorage:FindFirstChild("Remotes")
local player = Players.LocalPlayer
local Workspace = cast("Workspace")
local functions = {}
local pfunctions = require("../../../modules/functions")

-- teleporting
function functions.teleportTo(cframe)
	local TeleportTo = remotes:FindFirstChild("TeleportTo")
	if TeleportTo then
		firesignal(TeleportTo.OnClientEvent, {
			Pivot = false,
			Cfrm = cframe,
		})
	end
end

-- check game
function functions.checkGame()
	return Workspace:FindFirstChild("Values")
		and Workspace["Values"]:FindFirstChild("GameStarted")
		and Workspace["Values"]["GameStarted"].Value
		and Workspace["Values"]:FindFirstChild("CurrentGame")
		and Workspace["Values"]["CurrentGame"].Value
end

-- dalgona
do
	functions.resetCameraMethod2 = function()
		Workspace.CurrentCamera:Destroy()
		task.wait(0.1)
		repeat
			task.wait()
		until player.Character ~= nil
		Workspace.CurrentCamera.CameraSubject = player.Character:FindFirstChildWhichIsA("Humanoid")
		Workspace.CurrentCamera.CameraType = "Custom"
		player.CameraMinZoomDistance = 0.5
		player.CameraMaxZoomDistance = 400
		player.CameraMode = "Classic"
		player.Character.Head.Anchored = false
	end

	functions.deleteDalgonaFolder = function()
		local effects = ReplicatedStorage:FindFirstChild("Effects")
		if effects then
			local games = effects:FindFirstChild("Games")
			if games then
				local dalgona = games:FindFirstChild("Dalgona")
				if dalgona then
					dalgona:Destroy()
					return true
				end
			end
		end
		return false
	end

	functions.simulateClick = function()
		local replication = ReplicatedStorage:FindFirstChild("Replication")
		if replication then
			local remote = replication:FindFirstChild("Event")

			if remote then
				remote:FireServer({ "Clicked" })
			end
		end
	end

	functions.resetCamera = function()
		local remote = remotes:FindFirstChild("EffectsCharacter")
		if remote then
			if firesignal then
				firesignal(remote.OnClientEvent, {
					EffectName = "BringCameraBack",
				})
			end
		end
	end

	functions.winDalgona = function()
		local deleted = functions.deleteDalgonaFolder()

		if not deleted then
			functions.simulateClick()
			functions.resetCamera()

			local remote = remotes:FindFirstChild("DALGONATEMPREMPTE")

			if remote then
				remote:FireServer({
					Completed = true,
				})
			end
		end
	end
end

-- tug of war
function functions.pull()
	local remote = remotes:FindFirstChild("TemporaryReachedBindable")
	if remote then
		remote:FireServer({
			GameQTE = true,
		})
	end
end

-- glass bridge
do
	local glasstileclones = {}

	function functions.markTiles(step, val)
		local glassbridge = Workspace:FindFirstChild("GlassBridge")
		if glassbridge then
			local glassholder = glassbridge:FindFirstChild("GlassHolder")

			if glassholder then
				for _, glass in pairs(glassholder:GetChildren()) do
					for _, panel in pairs(glass:GetChildren()) do
						local glasspart = panel:FindFirstChild("glasspart")

						if glasspart then
							if not step then
								if glasspart:GetAttribute("ActuallyKilling") then
									glasspart.Color = Color3.fromRGB(255, 0, 0)
								else
									glasspart.Color = Color3.fromRGB(0, 255, 0)
								end
							else
								if val then
									local newGlass = glasspart:Clone()
									newGlass.CFrame = newGlass.CFrame + Vector3.new(0, 0.3, 0)
									newGlass.Size = newGlass.Size + Vector3.new(1, 1, 1)
									newGlass.Transparency = 0.6
									newGlass.Color = Color3.fromRGB(40, 40, 40)
									newGlass.Parent = Workspace

									table.insert(glasstileclones, newGlass)
								else
									for d, i in pairs(glasstileclones) do
										table.remove(glasstileclones, d)
										i:Destroy()
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

-- mingle
function functions.powerHold()
	local character = script.functions.getChar(player)

	if character then
		local remote = character:FindFirstChild("RemoteForQTE")

		if remote then
			remote:FireServer()
		end
	end
end

-- combat
function functions.getClosestPlr()
	local closest = nil
	local maxdistance = math.huge

	local hideandseek = functions.checkGame() == "HideAndSeek"

	for _, opp in pairs(Players:GetPlayers()) do
		if opp ~= player and pfunctions.isAlive(opp) then
			local oPos = pfunctions.getRoot(player).Position
			local pPos = pfunctions.getRoot(opp).Position

			local distance = (oPos - pPos).Magnitude
			if distance < maxdistance then
				if
					hideandseek
					and not (opp["Backpack"]:FindFirstChild("Knife") or pfunctions.getChar(opp):FindFirstChild("Knife"))
				then
					closest = opp
					maxdistance = distance
				elseif not hideandseek then
					closest = opp
					maxdistance = distance
				end
			end
		end
	end

	return closest
end

-- rlgl
do
	function functions.carry(plr)
		local root = pfunctions.getRoot(plr)

		if root then
			local carryprompt = root:FindFirstChild("CarryPrompt")

			if carryprompt then
				if fireproximityprompt then
					fireproximityprompt(carryprompt)
				end
			end
		end
	end

	function functions.drop()
		local remote = remotes:FindFirstChild("ClickedButton")

		if remote then
			remote:FireServer({
				tryingtoleave = true,
			})
		end
	end
end

return functions
