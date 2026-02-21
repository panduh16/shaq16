local cast = require("./services")

local functions = {}
local PathfindingService = cast("PathfindingService")
local player = cast("Players").LocalPlayer
local TweenService = cast("TweenService")

function functions.getChar(plr: Player)
	if not plr then
		return player.Character
	else
		return plr.Character
	end
end

function functions.getHumanoid(plr: Player)
	local character = functions.getChar(plr)

	return character:FindFirstChild("Humanoid") or nil
end

function functions.isAlive(plr: Player)
	local character = functions.getChar(plr)

	return character
		and functions.getHumanoid(plr)
		and character.Humanoid.Health > 0
		and character:FindFirstChild("HumanoidRootPart")
end

function functions.getRoot(plr: Player)
	if functions.isAlive(plr) then
		local character = functions.getChar(plr)

		return character and character:FindFirstChild("HumanoidRootPart")
			or character:FindFirstChild("Torso")
			or character.PrimaryPart
	end
end

function functions.teleport(cframe: CFrame)
	if functions.isAlive(player) then
		local root = functions.getRoot(player)

		root:PivotTo(cframe)
	end
end

function functions.tweenteleport(cframe: CFrame)
	if functions.isAlive(player) then
		local root = functions.getRoot(player)
		local distance = (root.CFrame.Position - cframe.Position).Magnitude
		local duration = math.clamp(distance / 10, 0.2, 10)
		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
		local tween = TweenService:Create(root, tweenInfo, {
			CFrame = cframe,
		})

		tween:Play()

		return tween
	end
end

function functions.moveTo(cframe: CFrame)
	if functions.isAlive(player) then
		local root = functions.getRoot(player)
		local humanoid = functions.getHumanoid(player)

		local path = PathfindingService:CreatePath({
			AgentRadius = 2,
			AgentHeight = 5,
			AgentCanJump = true,
		})

		path:ComputeAsync(root.CFrame.Position, cframe.Position)

		if path.Status == Enum.PathStatus.Success then
			local waypoints = path:GetWaypoints()

			for _, waypoint in pairs(waypoints) do
				humanoid:MoveTo(waypoint.Position)

				local reachedWaypoint = false
				local connection
				connection = humanoid.MoveToFinished:Connect(function(reached)
					if reached then
						reachedWaypoint = true
					end
				end)

				local timeout = tick() + 5

				while not reachedWaypoint and tick() < timeout and functions.isAlive(player) do
					task.wait(0.1)
					local distanceToWaypoint = (root.Position - waypoint.Position).magnitude
					if distanceToWaypoint < humanoid.WalkSpeed * 0.5 then
						reachedWaypoint = true
					end
				end
				connection:Disconnect()

				if waypoint.Action == Enum.PathWaypointAction.Jump then
					humanoid.Jump = true
				end
			end

			return true
		end
	end
end

function functions.equip(item: Instance)
	local backpack = player:FindFirstChild("Backpack")

	if backpack then
		for _, i in pairs(backpack:GetChildren()) do
			if string.find(i.Name, item) then
				i.Parent = functions.getChar(player)
			end
		end
	end
end

function functions.lookAt(cframe)
	if functions.isAlive(player) then
		local root = functions.getRoot(player)

		local adjusted = Vector3.new(cframe.X, root.CFrame.Y, cframe.Z)

		root.CFrame = CFrame.lookAt(root.CFrame.Position, adjusted)
	end
end

return functions
