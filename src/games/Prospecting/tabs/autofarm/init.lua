local RunService = game:GetService("RunService")
local functions = require("../../modules/functions")
local connections = {}
local misc = require("../../modules/misc")
local locations = require("../../modules/locations")
local pfunctions = require("../../../../modules/functions")
local player = game:GetService("Players").LocalPlayer

function init(ui)
	local autofarm = ui:TreeNode({
		Title = "Autofarm",
	})
	do
		autofarm:SetCollapsed(false)

		local function getLocations()
			local locationss = {}

			for location, _ in pairs(locations.Fill) do
				table.insert(locationss, location)
			end

			return locationss
		end

		autofarm:Combo({
			Label = "Auto-Location",
			Selected = "Starter",
			GetItems = function()
				return getLocations()
			end,
			Callback = function(self, val)
				misc.currentLocation = val
			end,
		})

		local afActive

		afActive = autofarm:Checkbox({
			Label = "Autofarm",
			Callback = function(self, val)
				if val then
					misc.justEnabledAutoFarm = true

					if connections["Autofarm"] then
						misc.shaking = false
						functions.stopDigAnim()
						connections["Autofarm"]:Disconnect()
						connections["Autofarm"] = nil
					end

					repeat
						task.wait()
					until pfunctions.moveTo(functions.getLocation("Fill"))

					misc.justEnabledAutoFarm = false

					if afActive:GetValue() then
						connections["Autofarm"] = RunService.Heartbeat:Connect(function()
							pfunctions.equip("Pan")
							if
								player:FindFirstChild("PlayerGui")
								and player["PlayerGui"]:FindFirstChild("ToolUI")
								and player["PlayerGui"]["ToolUI"]:FindFirstChild("FillingPan")
								and player["PlayerGui"]["ToolUI"]["FillingPan"]:FindFirstChild("Bar")
								and player["PlayerGui"]["ToolUI"]["FillingPan"]["Bar"].Size ~= UDim2.new(1, 0, 1, 0)
								and not pfunctions.getChar(player):GetAttribute("Panning")
								and not functions.selling()
							then
								functions.playDigAnim()
								functions.toggleShovel(true)
								pfunctions.teleport(functions.getLocation("Fill"))
								functions.fill()
								misc.shaking = false
							else
								misc.shaking = true
								functions.stopDigAnim()
								functions.toggleShovel(false)
								functions.pan()
								functions.shake()
								pfunctions.teleport(functions.getLocation("Shake"))
							end
						end)
					end
				else
					misc.shaking = false
					functions.stopDigAnim()
					if connections["Autofarm"] then
						connections["Autofarm"]:Disconnect()
						connections["Autofarm"] = nil
					end
				end
			end,
		})

		autofarm:Separator()

		autofarm:Checkbox({
			Label = "Auto Fill",
			Callback = function(self, val)
				if val then
					if connections["Auto Fill"] then
						functions.stopDigAnim()
						functions.toggleShovel(false)
						connections["Auto Fill"]:Disconnect()
						connections["Auto Fill"] = nil
					end
					connections["Auto Fill"] = RunService.Heartbeat:Connect(function()
						functions.playDigAnim()
						functions.toggleShovel(true)
						functions.fill()
					end)
				else
					functions.stopDigAnim()
					functions.toggleShovel(false)
					if connections["Auto Fill"] then
						connections["Auto Fill"]:Disconnect()
						connections["Auto Fill"] = nil
					end
				end
			end,
		})

		autofarm:Checkbox({
			Label = "Auto Shake",
			Callback = function(self, val)
				if val then
					if connections["Auto Shake"] then
						functions.stopDigAnim()
						functions.toggleShovel(false)
						connections["Auto Shake"]:Disconnect()
						connections["Auto Shake"] = nil
					end
					connections["Auto Shake"] = RunService.Heartbeat:Connect(function()
						functions.pan()
						functions.shake()
					end)
				else
					functions.stopDigAnim()
					functions.toggleShovel(false)
					if connections["Auto Shake"] then
						connections["Auto Shake"]:Disconnect()
						connections["Auto Shake"] = nil
					end
				end
			end,
		})
	end
end

return init
