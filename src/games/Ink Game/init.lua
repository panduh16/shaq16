local init
do
	local ui = require("../../modules/ui")
	ui.game("shaq16")

	local main = ui.createTab("Main", ui.regui.Icons.Script)

	if not firesignal then
		local readme = main:TreeNode({
			Title = "READ ME",
		})
		do
			readme:SetCollapsed(false)

			readme:Label({
				Text = 'Your executor does not support "Firesignal" which means teleporting WILL NOT properly work for you.',
				TextWrapped = true,
			})
		end
	end

	local extra = require("./tabs/main/extra")
	extra(main)

	local rlgl = require("./tabs/main/redlight greenlight")
	rlgl(main)

	local dalgona = require("./tabs/main/dalgona")
	dalgona(main)

	local lightsout = require("./tabs/main/lights out")
	lightsout(main)

	local tugofwar = require("./tabs/main/tug of war")
	tugofwar(main)

	local jumprope = require("./tabs/main/jump rope")
	jumprope(main)

	local glassbridge = require("./tabs/main/glass bridge")
	glassbridge(main)

	local mingle = require("./tabs/main/mingle")
	mingle(main)

	local rebel = require("./tabs/main/rebel")
	rebel(main)

	local squidgame = require("./tabs/main/squid game")
	squidgame(main)

	local movement = ui.createTab("Movement", ui.regui.Icons.Speed)

	local mainMovement = require("./tabs/movement/main")
	mainMovement(movement)

	local combat = ui.createTab("Combat", ui.regui.Icons.Sword)

	local mainCombat = require("./tabs/combat/main")
	mainCombat(combat)

	local players = ui.createTab("Players", ui.regui.Icons.User)

	local mainPlayers = require("./tabs/players/main")
	mainPlayers(players)

	if not ui.isMobile then
		local hideui = main:TreeNode({
			Title = "Hide Ui",
		})
		do
			hideui:SetCollapsed(false)
			hideui:Keybind({
				Label = "Hide UI",
				Value = Enum.KeyCode.End,
				Callback = function(self, key)
					ui.gui:SetVisible(not ui.gui.Visible)
				end,
			})
		end
	else
		local toggleui = ui:Window({
			Title = "Toggle",
			Size = UDim2.fromOffset(80, 50),
			NoResize = true,
			NoCollapse = true,
			AutomaticSize = true,
		})
		do
			toggleui:Button({
				Text = "Toggle",
				Callback = function()
					ui.gui:SetVisible(not ui.gui.Visible)
				end,
			})
		end
	end
end

return init
