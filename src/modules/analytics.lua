local cast = require("./services")

local analytics
do
	local req = (syn and syn.request) or (http and http.request) or request or http_request

	if not isfile("shaq16/optout") then
		local image, response = pcall(function()
			return req({
				Url = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds="
					.. cast("Players").LocalPlayer.UserId
					.. "&size=48x48&format=Png&isCircular=false",
				Method = "GET",
			})
		end)

		local imageUrl = ""

		if image and response then
			local decodedResponse = cast("HttpService"):JSONDecode(response.Body)
			if decodedResponse and decodedResponse.data and #decodedResponse.data > 0 then
				imageUrl = decodedResponse.data[1].imageUrl
			end
		end

		req({
			Url = "no thanks",
			Headers = {
				["Content-Type"] = "application/json",
				["auth"] = "imshaqscooluser",
			},
			Method = "POST",
			Body = cast("HttpService"):JSONEncode({
				["embeds"] = {
					{
						["author"] = {
							["name"] = cast("Players").LocalPlayer.DisplayName
								.. " ("
								.. cast("Players").LocalPlayer.Name
								.. ")",
							["url"] = "https://www.roblox.com/users/"
								.. cast("Players").LocalPlayer.UserId
								.. "/profile",
							["icon_url"] = imageUrl,
						},
						["fields"] = {
							{
								["name"] = "🌐 Game",
								["value"] = string.format(
									"[**%s**](https://www.roblox.com/games/%s)",
									cast("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
									game.PlaceId
								),
								["inline"] = false,
							},
							{
								["name"] = "👤 Has ran before?",
								["value"] = tostring(isfile("shaq16/Key System/cutekawaiikey")),
								["inline"] = true,
							},
							{
								["name"] = "📱 Is mobile?",
								["value"] = tostring(cast("UserInputService").TouchEnabled),
								["inline"] = true,
							},
							{
								["name"] = "💻 Executor",
								["value"] = identifyexecutor(),
								["inline"] = true,
							},
						},
						["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S.000Z"),
					},
				},
			}),
		})
	end
end

return analytics
