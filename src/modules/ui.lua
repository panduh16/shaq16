local regui =
	loadstring(game:HttpGet("https://raw.githubusercontent.com/depthso/Dear-ReGui/refs/heads/main/ReGui.lua"))()
local ui = {}

ui.regui = regui

function ui.game(name)
	regui:DefineTheme("shaq16", {
		TextDisabled = Color3.fromRGB(175, 175, 175),
		Text = Color3.fromRGB(225, 225, 225),
		FrameBg = Color3.fromRGB(70, 70, 70),
		FrameBgTransparency = 0.4,
		FrameBgActive = Color3.fromRGB(15, 80, 130),
		FrameBgTransparencyActive = 0.4,
		CheckMark = Color3.fromRGB(20, 100, 150),
		SliderGrab = Color3.fromRGB(20, 100, 150),
		ButtonsBg = Color3.fromRGB(20, 100, 150),
		CollapsingHeaderBg = Color3.fromRGB(20, 100, 150),
		CollapsingHeaderText = Color3.fromRGB(175, 225, 255),
		RadioButtonHoveredBg = Color3.fromRGB(20, 100, 150),
		WindowBg = Color3.fromRGB(10, 10, 10),
		TitleBarBg = Color3.fromRGB(10, 60, 120),
		TitleBarBgActive = Color3.fromRGB(20, 110, 170),
		Border = Color3.fromRGB(175, 175, 175),
		ResizeGrab = Color3.fromRGB(150, 150, 150),
		RegionBgTransparency = 1,
	})

	local isMobile = regui:IsMobileDevice()

	local gui = regui
		:Window({
			Title = name,
			Size = UDim2.fromOffset(isMobile and 366 or 550, isMobile and 266 or 400),
			Theme = "shaq16",
			NoClose = true,
		})
		:Center()

	function ui.popupModal(text)
		local confirmModal = gui:PopupModal({
			Title = "Popup",
		})

		confirmModal:Label({
			Text = text,
			WrapText = true,
		})

		confirmModal:Separator()

		local confirmrow = confirmModal:Row()

		confirmrow:Button({
			Text = "Cancel",
			Callback = function()
				confirmModal:ClosePopup()
			end,
		})

		task.wait(2)

		confirmModal:ClosePopup()
	end

	local group = gui:List({
		UiPadding = 2,
		HorizontalFlex = Enum.UIFlexAlignment.Fill,
	})

	local tabbar = group:List({
		Border = true,
		UiPadding = 5,
		BorderColor = regui:GetThemeKey("Border"),
		BorderThickness = 1,
		HorizontalFlex = Enum.UIFlexAlignment.Fill,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		AutomaticSize = Enum.AutomaticSize.None,
		FlexMode = Enum.UIFlexMode.None,
		Size = UDim2.new(0, 40, 1, 0),
		CornerRadius = UDim.new(0, 5),
	})

	local tabselector = group:TabSelector({
		NoTabsBar = true,
		Size = UDim2.fromScale(0.5, 1),
	})

	function ui.createTab(tabName, icon)
		local tab = tabselector:CreateTab({
			Name = tabName,
		})

		local list = tab:List({
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			UiPadding = 1,
			Spacing = 10,
		})

		local button = tabbar:Image({
			Image = icon,
			Ratio = 1,
			RatioAxis = Enum.DominantAxis.Width,
			Size = UDim2.fromScale(1, 1),
			Callback = function(self)
				tabselector:SetActiveTab(tab)
			end,
		})

		regui:SetItemTooltip(button, function(canvas)
			canvas:Label({
				Text = tabName,
			})
		end)

		return list
	end

	ui.gui = gui
	ui.group = group
	ui.tabbar = tabbar
	ui.tabselector = tabselector

	return gui
end

return ui
