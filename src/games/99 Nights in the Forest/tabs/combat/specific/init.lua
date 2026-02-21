local functions = require("../../../modules/functions")
local pfunctions = require("../../../../../modules/functions")

function init(ui)
	local specific = ui:TreeNode({
		Title = "Specific",
	})
	do
		local function getCharsByName()
			local chars = {}

			for _, i in pairs(functions.getCharacters()) do
				if not table.find(chars, i.Name) then
					table.insert(chars, i.Name)
				end
			end

			return chars
		end

		local selectedChar = specific:Combo({
			Label = "Select Character",
			Selected = getCharsByName()[1],
			GetItems = function()
				return getCharsByName()
			end,
		})

		specific:Button({
			Text = "Teleport To",
			Callback = function()
				for _, i in pairs(functions.getCharacters()) do
					if i.Name == selectedChar:GetValue() then
						pfunctions.teleport(i.PrimaryPart.CFrame + Vector3.new(0, 5, 0))
					end
				end
			end,
		})
	end
end

return init
