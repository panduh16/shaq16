local init
do
	local ui = require("../../modules/ui")
	ui.game("shaq16")

	local main = ui.createTab("Main", ui.regui.Icons.Script)

	local mainok = require("./tabs/main")
	mainok(main)

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
