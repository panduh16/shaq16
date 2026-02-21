local init
do
	local ui = require("../modules/ui")
	ui.game("shaq16 | DEBUGGING SUITE")

	local home = ui.createTab("Home", ui.regui.Icons.Home)

	local homeT = require("./tabs/home")
	homeT(home)

	local scripts = ui.createTab("Scripts", ui.regui.Icons.Script)

	local scriptsT = require("./tabs/scripts")
	scriptsT(scripts)

	local locations = ui.createTab("Locations", ui.regui.Icons.Globe)

	local locationsT = require("./tabs/locations")
	locationsT(locations)

	if not ui.isMobile then
		local hideui = home:TreeNode({
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
