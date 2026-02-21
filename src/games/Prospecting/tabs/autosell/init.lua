local RunService = game:GetService("RunService")
local functions = require("../../modules/functions")
local connections = {}
local misc = require("../../modules/misc")
local rarities = require("../../modules/rarities")
local pfunctions = require("../../../../modules/functions")
local player = game:GetService("Players").LocalPlayer

function init(ui)
	local autosell = ui:TreeNode({
		Title = "Auto Sell",
	})
	do
		local function canYouSell()
			if functions.getLocation("Sell") == CFrame.new(99999, 99999, 99999) then
				return false
			else
				return true
			end
		end

		autosell:SetCollapsed(false)

		local astext = autosell:Label({
			Text = "Able to sell at Autofarm location: " .. tostring(canYouSell()),
		})

		connections["Update Auto Sell Value"] = RunService.Heartbeat:Connect(function()
			astext.Text = "Able to sell at Autofarm location: " .. tostring(canYouSell())
		end)

		autosell:Separator()

		for rarity, raritytable in pairs(rarities) do
			autosell:Checkbox({
				Label = "Auto sell " .. rarity,
				Callback = function(self, val)
					if val then
						connections[rarity] = RunService.Heartbeat:Connect(function()
							for _, i in pairs(player["Backpack"]:GetChildren()) do
								if
									i:GetAttribute("Rarity")
									and i:GetAttribute("Rarity") == rarity
									and not i:GetAttribute("Locked")
									and not misc.justEnabledAutoFarm
									and not misc.shaking
								then
									if
										game:GetService("MarketplaceService")
											:UserOwnsGamePassAsync(player.UserId, 1268428789)
									then
										raritytable["Selling"] = true
										functions.sell(i)
									elseif
										(functions.getLocation("Sell").p - pfunctions.getRoot(player).CFrame.p).Magnitude
										<= 60
									then
										raritytable["Selling"] = true
										pfunctions.teleport(functions.getLocation("Sell"))
										functions.sell(i)
									else
										raritytable["Selling"] = false
									end
								else
									raritytable["Selling"] = false
								end
							end
						end)
					else
						if connections[rarity] then
							connections[rarity]:Disconnect()
							connections[rarity] = nil
						end
					end
				end,
			})
		end
	end
end

return init
