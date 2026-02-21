local cast = require("../../../../../modules/services")

local RunService = cast("RunService")
local functions = require("../../../modules/functions")
local pfunctions = require("../../../../../modules/functions")
local connections = {}
local player = cast("Players").LocalPlayer

function init(ui)
	local main = ui:TreeNode({
		Title = "Main",
	})
	do
		main:SetCollapsed(false)

		main:Button({
			Text = "Enable Phantom Step",
			Callback = function()
				player:SetAttribute("_EquippedPower", "PHANTOM STEP")
			end,
		})

		main:Separator()

		local wsrow = main:Row()

		local wsvalue
		local wsenabled

		wsenabled = wsrow:Checkbox({
			Label = "Walkspeed",
			Callback = function(self, val)
				if val then
					if connections["Walkspeed"] then
						connections["Walkspeed"]:Disconnect()
						connections["Walkspeed"] = nil
					end
					connections["Walkspeed"] = RunService.Heartbeat:Connect(function()
						local root = pfunctions.getRoot(player)
						if root then
							local moveDirection = pfunctions.getHumanoid(player).MoveDirection
							if moveDirection.Magnitude > 0 then
								local dt = RunService.RenderStepped:Wait()
								root.CFrame = root.CFrame + (moveDirection * wsvalue:GetValue() * dt)
							end
						end
					end)
				else
					if connections["Walkspeed"] then
						connections["Walkspeed"]:Disconnect()
						connections["Walkspeed"] = nil
					end
				end
			end,
		})

		wsrow:Keybind({
			Label = "",
			Value = Enum.KeyCode.X,
			Callback = function(self, key)
				wsenabled:Toggle()
			end,
		})

		wsvalue = main:SliderInt({
			Label = "",
			Value = 10,
			Minimum = 0,
			Maximum = 250,
		})

		main:Separator()

		main:Checkbox({
			Label = "No Slowdown",
			Callback = function(self, val)
				if val then
					if connections["No Slowdown"] then
						connections["No Slowdown"]:Disconnect()
						connections["No Slowdown"] = nil
					end
					connections["No Slowdown"] = RunService.Heartbeat:Connect(function()
						local char = pfunctions.getChar(player)

						if char:FindFirstChild("InjuredWalking") then
							char["InjuredWalking"]:Destroy()
						end
						if char:FindFirstChild("Stun") then
							char["Stun"]:Destroy()
						end
						if char:FindFirstChild("CantRun") then
							char["CantRun"]:Destroy()
						end
						if char:FindFirstChild("Anchor") then
							char["Anchor"]:Destroy()
						end
						if char:FindFirstChild("RotateDisabled") then
							char["RotateDisabled"]:Destroy()
						end
						if char:FindFirstChild("MovedRecentlyRedLight") then
							char["MovedRecentlyRedLight"]:Destroy()
						end
						if char:FindFirstChild("StaminaVal") then
							char["StaminaVal"].Value = 100
						end
					end)
				else
					if connections["No Slowdown"] then
						connections["No Slowdown"]:Disconnect()
						connections["No Slowdown"] = nil
					end
				end
			end,
		})

		main:Separator()

		main:Checkbox({
			Label = "Noclip",
			Callback = function(self, val)
				if val then
					if connections["Noclip"] then
						connections["Noclip"]:Disconnect()
						connections["Noclip"] = nil
					end
					connections["Noclip"] = RunService.Heartbeat:Connect(function()
						local character = pfunctions.getChar(player)

						if character then
							for _, part in pairs(character:GetChildren()) do
								if part:IsA("BasePart") then
									part.CanCollide = false
								end
							end
						end
					end)
				else
					if connections["Noclip"] then
						connections["Noclip"]:Disconnect()
						connections["Noclip"] = nil

						local character = pfunctions.getChar(player)

						if character then
							for _, part in pairs(character:GetChildren()) do
								if part:IsA("BasePart") then
									part.CanCollide = true
								end
							end
						end
					end
				end
			end,
		})

		main:Separator()

		local tprow = main:Row()

		local clicktotp

		clicktotp = tprow:Checkbox({
			Label = "Click To TP",
		})

		tprow:Keybind({
			Label = "",
			Value = Enum.KeyCode.V,
			Callback = function(self, key)
				if clicktotp:GetValue() == true then
					local mouse = player:GetMouse()

					functions.teleportTo(CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0)))
				end
			end,
		})
	end
end

return init
