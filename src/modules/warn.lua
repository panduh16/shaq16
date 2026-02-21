local ui = require("./ui")

local function warn(text)
	local window = ui.regui:Window({
		Title = "WARNING",
		Size = UDim2.fromOffset(300, 300),
		NoCollapse = true,
	})

    window:Error({
        Text = text
    })

    task.wait(3)

    window:Close()
end

return warn
