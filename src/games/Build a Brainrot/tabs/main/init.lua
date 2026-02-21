local functions = require("../../modules/functions")

function init(ui)
	local main = ui:TreeNode({
		Title = "Main",
	})
	do
		main:SetCollapsed(false)

		main:Button({
			Text = "Infinite Yield",
			Callback = function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
			end,
		})

		main:Separator()

		for _, type in pairs(functions.getTypes()) do
			local spawndropdown = main:Combo({
				Label = "SPAWN " .. type.Name,
				Selected = functions.getBrainrots(type.Name)[1],
				GetItems = function()
					return functions.getBrainrots(type.Name)
				end,
			})

			main:Button({
				Text = "Spawn " .. type.Name,
				Callback = function()
					functions.spawn(type.Name .. tostring(spawndropdown:GetValue().Name))
				end,
			})
		end

		main:Separator()

		main:Label({
			Text = "Everything below is so you know the categories of the brainrots",
			TextWrapped = true,
		})

		main:Separator()

		main:Combo({
			Label = "Common",
			Selected = "Trippi Troppi",
			Items = {
				"Trippi Troppi",
				"Burbaloni Loliloli",
				"Boneca Ambalabu",
			},
		})

		main:Combo({
			Label = "Uncommon",
			Selected = "Gangster Footera",
			Items = {
				"Gangster Footera",
				"Svinina Bombardino",
			},
		})

		main:Combo({
			Label = "Rare",
			Selected = "Chef Crabra Cadabra",
			Items = {
				"Chef Crabra Cadabra",
				"Cappuccino Assassino",
			},
		})

		main:Combo({
			Label = "Legendary",
			Selected = "Tung Tung Tung Shaur",
			Items = {
				"Tung Tung Tung Shaur",
				"Tim Cheese",
				"Brr Brr Patapim",
			},
		})

		main:Combo({
			Label = "Mythical",
			Selected = "Chimpanzini Bambini",
			Items = {
				"Chimpanzini Bambini",
				"Ballerina Cappuccina",
			},
		})

		main:Combo({
			Label = "Pristine",
			Selected = "Glorbo Fruttodrille",
			Items = {
				"Glorbo Fruttodrille",
				"Frigo Camelo",
			},
		})

		main:Combo({
			Label = "Divine",
			Selected = "Bombardino Crocodilo",
			Items = {
				"Bombardino Crocodilo",
				"Orangutini Ananassini",
			},
		})

		main:Combo({
			Label = "Eternal",
			Selected = "Cocofanto Elefanto",
			Items = {
				"Cocofanto Elefanto",
				"Tralalero Tralala",
			},
		})

		main:Combo({
			Label = "God",
			Selected = "Tigrullini Watermelllini",
			Items = {
				"Tigrullini Watermelllini",
				"Odin Din Din Dun",
			},
		})
	end
end

return init
