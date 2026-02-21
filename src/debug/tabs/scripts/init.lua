function init(ui)
	local home = ui:TreeNode({
		Title = "Scripts",
	})
	do
		home:SetCollapsed(false)

		local sigmaspyrow = home:Row()

		sigmaspyrow:Label({
			Text = "Sigma Spy",
		})

		if setclipboard then
			sigmaspyrow:Button({
				Text = "Copy To Clipboard",
				Callback = function()
					setclipboard(
						'loadstring(game:HttpGet("https://raw.githubusercontent.com/depthso/Sigma-Spy/refs/heads/main/Main.lua"), "Sigma Spy")()'
					)
				end,
			})
		end

		sigmaspyrow:Button({
			Text = "Execute",
			Callback = function()
				loadstring(
					game:HttpGet("https://raw.githubusercontent.com/depthso/Sigma-Spy/refs/heads/main/Main.lua"),
					"Sigma Spy"
				)()
			end,
		})

		local httpspyrow = home:Row()

		httpspyrow:Label({
			Text = "Http Spy",
		})

		if setclipboard then
			httpspyrow:Button({
				Text = "Copy To Clipboard",
				Callback = function()
					setclipboard(
						'loadstring(game:HttpGet("https://raw.githubusercontent.com/1-16AM/xena/refs/heads/main/functions/http_spy.lua"))()'
					)
				end,
			})
		end

		httpspyrow:Button({
			Text = "Execute",
			Callback = function()
				loadstring(
					game:HttpGet("https://raw.githubusercontent.com/1-16AM/xena/refs/heads/main/functions/http_spy.lua")
				)()
			end,
		})

		local dexrow = home:Row()

		dexrow:Label({
			Text = "Dex",
		})

		if setclipboard then
			dexrow:Button({
				Text = "Copy To Clipboard",
				Callback = function()
					setclipboard(
						'loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()'
					)
				end,
			})
		end

		dexrow:Button({
			Text = "Execute",
			Callback = function()
				loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()
			end,
		})

		local bypassadonis = home:Row()

		bypassadonis:Label({
			Text = "Bypass Adonis",
		})

		if setclipboard then
			bypassadonis:Button({
				Text = "Copy To Clipboard",
				Callback = function()
					setclipboard(
						'loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua",true))()'
					)
				end,
			})
		end

		bypassadonis:Button({
			Text = "Execute",
			Callback = function()
				loadstring(
					game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua", true)
				)()
			end,
		})
	end
end

return init
