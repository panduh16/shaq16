local functions = require("../../../modules/functions")

function init(ui)
	local dalgona = ui:TreeNode({
		Title = "Dalgona",
	})
	do
		dalgona:Label({
			Text = 'Run the "Win Dalgona" button whenever the guard hits you in the cutscene, run it again whenever your cookie disappears/everyone is solving their cookie.',
			TextWrapped = true,
		})

		dalgona:Separator()

		dalgona:Button({
			Text = "Win Dalgona",
			Callback = function()
				functions.winDalgona()
			end,
		})

		dalgona:Button({
			Text = "Reset Camera View [ USE IF WIN DALGONA DOESNT DO IT ]",
			Callback = function()
				script.functions.resetCameraMethod2()
			end,
		})
	end
end

return init
