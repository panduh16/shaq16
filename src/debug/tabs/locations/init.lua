local RunService = game:GetService("RunService")
local pfunctions = require("../../../modules/functions")
local player = game:GetService("Players").LocalPlayer
local Workspace = game:GetService("Workspace")
local mathfloor = math.floor

function init(ui)
	local home = ui:TreeNode({
		Title = "Locations",
	})
	do
		home:SetCollapsed(false)

		-- current position
		do
			local cposrow = home:Row()
			local currentPosition

			currentPosition = cposrow:Label({
				Text = "Your current position : ",
			})

			RunService.Heartbeat:Connect(function()
				local pos = pfunctions.getRoot(player).CFrame.p
				local aPos = Vector3.new(mathfloor(pos.x), mathfloor(pos.y), mathfloor(pos.z))
				currentPosition.Text = "Your current position : " .. tostring(aPos)
			end)

			if setclipboard then
				cposrow:Button({
					Text = "Copy To Clipboard",
					Callback = function()
						setclipboard("CFrame.new(" .. currentPosition.Text .. ")")
					end,
				})
			end
		end

		home:Separator()

		local firstPos = Vector3.new(0, 0, 0)
		local secondPos = Vector3.new(0, 0, 0)
		-- set 2 positions
		do
			local firstrow = home:Row()
			local firstOk = firstrow:Label({
				Text = "1st Position : " .. tostring(firstPos),
			})
			firstrow:Button({
				Text = "Update Position",
				Callback = function()
					local apos = pfunctions.getRoot(player).CFrame.p
					firstPos = Vector3.new(mathfloor(apos.x), mathfloor(apos.y), mathfloor(apos.z))
					firstOk.Text = "1st Position : " .. tostring(firstPos)
				end,
			})

			if setclipboard then
				firstrow:Button({
					Text = "Copy To Clipboard",
					Callback = function()
						setclipboard("CFrame.new(" .. tostring(firstPos) .. ")")
					end,
				})
			end

			local secondrow = home:Row()
			local secondOk = secondrow:Label({
				Text = "2nd Position : " .. tostring(secondPos),
			})
			secondrow:Button({
				Text = "Update Position",
				Callback = function()
					local apos = pfunctions.getRoot(player).CFrame.p
					secondPos = Vector3.new(mathfloor(apos.x), mathfloor(apos.y), mathfloor(apos.z))
					secondOk.Text = "2nd Position : " .. tostring(secondPos)
				end,
			})

			if setclipboard then
				secondrow:Button({
					Text = "Copy To Clipboard",
					Callback = function()
						setclipboard("CFrame.new(" .. tostring(secondPos) .. ")")
					end,
				})
			end
		end

		-- distance
		do
			local distancerow = home:Row()
			local distances = distancerow:Label({
				Text = "Distance : ",
			})

			RunService.Heartbeat:Connect(function()
				distances.Text = "Distance : " .. mathfloor((firstPos - secondPos).Magnitude)
			end)

			if setclipboard then
				distancerow:Button({
					Text = "Copy To Clipboard",
					Callback = function()
						setclipboard(tostring(mathfloor((firstPos - secondPos).Magnitude)))
					end,
				})
			end
		end

		-- raycast check
		do
			local hit = home:Label({
				Text = "Raycast Hit : ",
			})
			local hitPos = home:Label({
				Text = "Raycast Hit Position : ",
			})
			local hitNothing = home:Label({
				Text = "Raycast Hit Nothing!",
			})

			hit.Visible = false
			hitPos.Visible = false
			hitNothing.Visible = false

			while task.wait(1) do
				local direction = secondPos - firstPos

				local raycastResult = Workspace:Raycast(firstPos, direction)

				if raycastResult then
					hit.Visible = true
					hitPos.Visible = true
					hitNothing.Visible = false
					hit.Text = "Raycast Hit : "
						.. tostring(raycastResult.Instance.Name)
						.. " | "
						.. tostring(raycastResult.Instance:GetFullName())
					hitPos.Text = "Raycast Hit : " .. tostring(raycastResult.Position)
				else
					hit.Visible = false
					hitPos.Visible = false
					hitNothing.Visible = true
				end
			end
		end
	end
end

return init
