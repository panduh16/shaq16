local cast = require("../../../../../modules/services")

local RunService = cast("RunService")
local functions = require("../../../modules/functions")
local pfunctions = require("../../../../../modules/functions")
local connections = {}
local Players = cast("Players")
local player = Players.LocalPlayer

function init(ui)
	local main = ui:TreeNode({
		Title = "Main",
	})
	do
		main:SetCollapsed(false)

		local rlglsaveonly
		local playersCombo = main:Combo({
			Label = "Players",
			Selected = Players:GetPlayers()[1],
			GetItems = function()
				if not rlglsaveonly or not rlglsaveonly:GetValue() then
					local returnPlayers = {}

					for _, i in pairs(Players:GetPlayers()) do
						if i ~= player then
							table.insert(returnPlayers, i)
						end
					end

					return returnPlayers
				else
					local hplayers = {}

					for _, opp in pairs(Players:GetPlayers()) do
						if opp ~= player then
							local char = pfunctions.getChar(opp)
							if char then
								if
									char:FindFirstChild("InjuredWalking")
									and not char:FindFirstChild("SafeRedLightGreenLight")
									and not char:FindFirstChild("IsBeingHeld")
									and not char:FindFirstChild("InLoopTp")
								then
									table.insert(hplayers, opp)
								end
							end
						end
					end

					return hplayers
				end
			end,
		})

		rlglsaveonly = main:Checkbox({
			Label = "RLGL Savable Only",
		})

		main:Separator()

		main:Button({
			Text = "Teleport To",
			Callback = function()
				local root = pfunctions.getRoot(playersCombo:GetValue())

				functions.teleportTo(root.CFrame)
			end,
		})

		main:Separator()

		local distanceslider

		main:Checkbox({
			Label = "Spam TP",
			Callback = function(self, val)
				if val then
					if connections["Spam TP"] then
						connections["Spam TP"]:Disconnect()
						connections["Spam TP"] = nil
					end
					connections["Spam TP"] = RunService.Heartbeat:Connect(function()
						local plr = playersCombo:GetValue()

						if plr then
							local root = pfunctions.getRoot(playersCombo:GetValue())

							functions.teleportTo(CFrame.new(root.Position) + distanceslider:GetValue().Position)
						end
					end)
				else
					if connections["Spam TP"] then
						connections["Spam TP"]:Disconnect()
						connections["Spam TP"] = nil
					end
				end
			end,
		})

		distanceslider = main:SliderCFrame({
			Label = "Distance From Player",
			Value = CFrame.new(0, 0, 0),
			Minimum = CFrame.new(-5, -5, -5),
			Maximum = CFrame.new(5, 5, 5),
		})

		main:Checkbox({
			Label = "Face Player",
			Callback = function(self, val)
				if val then
					if connections["Face Player"] then
						connections["Face Player"]:Disconnect()
						connections["Face Player"] = nil
					end
					connections["Face Player"] = RunService.Heartbeat:Connect(function()
						local plr = playersCombo:GetValue()

						if plr then
							local root = pfunctions.getRoot(playersCombo:GetValue())

							pfunctions.lookAt(root.CFrame.Position)
						end
					end)
				else
					if connections["Face Player"] then
						connections["Face Player"]:Disconnect()
						connections["Face Player"] = nil
					end
				end
			end,
		})

		main:Separator()

		main:Label({
			Text = "Redlight Greenlight",
		})

		main:Button({
			Text = "Bring",
			Callback = function()
				if functions.checkGame() == "RedLightGreenLight" then
					local char = pfunctions.getChar(playersCombo:GetValue())
					if char:FindFirstChild("InjuredWalking") and not char:FindFirstChild("SafeRedLightGreenLight") then
						local originalPos = pfunctions.getRoot(player).CFrame
						local root = pfunctions.getRoot(playersCombo:GetValue())

						task.spawn(function()
							local start = os.clock()
							repeat
								functions.teleportTo(CFrame.new(root.Position) + Vector3.new(0, 0, -2))
								functions.carry(playersCombo:GetValue())
								task.wait()
							until os.clock() - start > 0.5
						end)
						task.wait(0.2)
						task.spawn(function()
							local start = os.clock()
							repeat
								functions.teleportTo(originalPos)

								task.wait()
							until os.clock() - start > 0.4
						end)
						task.wait(0.1)
						task.spawn(function()
							local start = os.clock()
							repeat
								functions.drop()
								task.wait()
							until os.clock() - start > 0.3
						end)
					end
				end
			end,
		})

		main:Button({
			Text = "Save",
			Callback = function()
				if functions.checkGame() == "RedLightGreenLight" then
					local char = pfunctions.getChar(playersCombo:GetValue())
					if char:FindFirstChild("InjuredWalking") and not char:FindFirstChild("SafeRedLightGreenLight") then
						local originalPos = pfunctions.getRoot(player).CFrame
						local root = pfunctions.getRoot(playersCombo:GetValue())

						task.spawn(function()
							local start = os.clock()
							repeat
								functions.teleportTo(CFrame.new(root.Position) + Vector3.new(0, 0, -2))
								functions.carry(playersCombo:GetValue())
								task.wait()
							until os.clock() - start > 0.5
						end)
						task.wait(0.2)
						task.spawn(function()
							local start = os.clock()
							repeat
								functions.teleportTo(CFrame.new(-45.574, 1024.7, 135.325))
								task.wait()
							until os.clock() - start > 0.4
						end)
						task.wait(0.1)
						task.spawn(function()
							local start = os.clock()
							repeat
								functions.drop()
								task.wait()
							until os.clock() - start > 0.3
						end)
						task.wait(0.2)
						task.spawn(function()
							local start = os.clock()
							repeat
								functions.teleportTo(originalPos)

								task.wait()
							until os.clock() - start > 0.2
						end)
					end
				end
			end,
		})

		main:Button({
			Text = "Take To Start",
			Callback = function()
				if functions.checkGame() == "RedLightGreenLight" then
					local char = pfunctions.getChar(playersCombo:GetValue())
					if char:FindFirstChild("InjuredWalking") and not char:FindFirstChild("SafeRedLightGreenLight") then
						local originalPos = pfunctions.getRoot(player).CFrame
						local root = pfunctions.getRoot(playersCombo:GetValue())

						task.spawn(function()
							local start = os.clock()
							repeat
								functions.teleportTo(CFrame.new(root.Position) + Vector3.new(0, 0, -2))
								functions.carry(playersCombo:GetValue())
								task.wait()
							until os.clock() - start > 0.5
						end)
						task.wait(0.2)
						task.spawn(function()
							local start = os.clock()
							repeat
								functions.teleportTo(CFrame.new(-49.88, 1022.10, -512.15))
								task.wait()
							until os.clock() - start > 0.4
						end)
						task.wait(0.1)
						task.spawn(function()
							local start = os.clock()
							repeat
								functions.drop()
								task.wait()
							until os.clock() - start > 0.3
						end)
						task.wait(0.2)
						task.spawn(function()
							local start = os.clock()
							repeat
								functions.teleportTo(originalPos)

								task.wait()
							until os.clock() - start > 0.2
						end)
					end
				end
			end,
		})
	end
end

return init
