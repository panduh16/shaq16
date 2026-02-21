local keySystem
do
	local ui = require("../modules/ui.lua")
	local folderName = "shaq16"

	-- ! KEY KEY KEY OK
	-- * KEY KEY KEy OK

	local actualkey = "wearesoud"

	-- ! KEY KEY KEY OK
	-- * KEY KEY KEy OK

	-- tostring(
	-- 				game:HttpGet("https://raw.githubusercontent.com/possibIy/xena/refs/heads/main/key.txt")
	-- 					:gsub("[\n\r]", "")

	if isfolder and not isfolder(folderName .. "/Key System") then
		makefolder(folderName .. "/Key System")
	end

	if isfile and isfile(folderName .. "/Key System/cutekawaiikey") then
		if readfile(folderName .. "/Key System/cutekawaiikey") == actualkey then
			keyConfirmed = true
		end
	end

	if not keyConfirmed then
		local keysys = ui.regui
			:Window({
				Title = "Key system",
				Size = UDim2.fromOffset(300, 100),
				NoCollapse = true,
				NoResize = true,
				NoScroll = true,
			})
			:Center()
		do
			keysys:Button({
				Text = "Get Key Here!",
				Callback = function()
					local confirmModal = keysys:PopupModal({
						Title = "Copy To Clipboard",
					})

					confirmModal:InputText({
						Label = "",
						Value = "discord.gg/VSKCM7rXVY",
					})

					confirmModal:Label({
						Text = '📎 How to get the key 📎\n\nGo to the channel "📎｜get-script"\n\nCopy the text for the key (ONLY THE ACTUAL KEY)\nPaste the key into the "Key Here" text-input\n\nPress the "Submit Key" button',
						TextWrapped = true,
					})

					confirmModal:Separator()

					local confirmrow = confirmModal:Row()

					confirmrow:Button({
						Text = "Copy Discord To Clipboard",
						Callback = function()
							if setclipboard then
								setclipboard("discord.gg/VSKCM7rXVY")
							end
							confirmModal:ClosePopup()
						end,
					})

					confirmrow:Button({
						Text = "Cancel",
						Callback = function()
							confirmModal:ClosePopup()
						end,
					})
				end,
			})

			local key = keysys:InputText({
				Label = "Key",
				Placeholder = "Key Here",
				Value = "",
			})

			keysys:Button({
				Text = "Submit Key",
				Callback = function()
					if key:GetValue() == actualkey then
						keysys:Close()
						keyConfirmed = true
						writefile(folderName .. "/Key System/cutekawaiikey", key:GetValue())
					else
						key:SetLabel("Wrong Key!")
						task.wait(2)
						key:SetLabel("Key")
					end
				end,
			})
		end

		repeat
			task.wait()
		until keyConfirmed
	end
end

return keySystem
