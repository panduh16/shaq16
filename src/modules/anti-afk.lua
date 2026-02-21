if not game.GameId == 7008097940 then
	local cast = require("./services")

	local antiafk
	do
		local VirtualUser = cast("VirtualUser")

		cast("Players").LocalPlayer.Idled:Connect(function()
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
		end)
	end

	return antiafk
end

return nil
