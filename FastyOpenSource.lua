local FastyUi = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function create(class, props)
	local obj = Instance.new(class)
	for k,v in pairs(props) do
		obj[k] = v
	end
	return obj
end

function FastyUi:CreateWindow(title)
	local screenGui = create("ScreenGui", {
		Name = "FastyUi",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
	})

	local main = create("Frame", {
		Size = UDim2.new(0, 500, 0, 320),
		Position = UDim2.new(0.5, -250, 0.5, -160),
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Parent = screenGui
	})
	main.ClipsDescendants = true
	main.BackgroundTransparency = 0
	main.Active = true
	main.Draggable = true
	create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = main})

	local titleLbl = create("TextLabel", {
		Text = title or "FastyUi",
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(255,255,255),
		Font = Enum.Font.GothamBold,
		TextSize = 20,
		Parent = main
	})

	local tabHolder = create("Frame", {
		Size = UDim2.new(1, 0, 1, -40),
		Position = UDim2.new(0, 0, 0, 40),
		BackgroundTransparency = 1,
		Parent = main
	})

	local tabs = {}

	local tabButtons = create("Frame", {
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = Color3.fromRGB(30,30,30),
		Parent = tabHolder
	})
	create("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = tabButtons
	})

	local tabContent = create("Frame", {
		Size = UDim2.new(1, 0, 1, -30),
		Position = UDim2.new(0, 0, 0, 30),
		BackgroundTransparency = 1,
		Parent = tabHolder
	})

	function FastyUi:CreateTab(tabName)
		local tabBtn = create("TextButton", {
			Text = tabName,
			Size = UDim2.new(0, 100, 1, 0),
			BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			Font = Enum.Font.Gotham,
			TextSize = 16,
			Parent = tabButtons
		})

		local tabFrame = create("ScrollingFrame", {
			Size = UDim2.new(1, 0, 1, 0),
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollBarThickness = 4,
			BackgroundTransparency = 1,
			Visible = false,
			Parent = tabContent
		})
		create("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 6),
			Parent = tabFrame
		})

		tabs[tabName] = tabFrame

		tabBtn.MouseButton1Click:Connect(function()
			for name, frame in pairs(tabs) do
				frame.Visible = false
			end
			tabFrame.Visible = true
		end)

		local API = {}

		function API:AddLabel(text)
			create("TextLabel", {
				Text = text,
				Size = UDim2.new(1, -20, 0, 20),
				BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(255,255,255),
				TextXAlignment = Enum.TextXAlignment.Left,
				Font = Enum.Font.Gotham,
				TextSize = 14,
				Parent = tabFrame
			})
		end

		function API:AddButton(text, callback)
			local btn = create("TextButton", {
				Text = text,
				Size = UDim2.new(1, -20, 0, 30),
				BackgroundColor3 = Color3.fromRGB(40,40,40),
				TextColor3 = Color3.fromRGB(255,255,255),
				Font = Enum.Font.Gotham,
				TextSize = 14,
				Parent = tabFrame
			})
			create("UICorner", {Parent = btn})

			btn.MouseButton1Click:Connect(function()
				if callback then
					callback()
				end
			end)
		end

		function API:AddCheckBox(text, default, callback)
			local cb = create("TextButton", {
				Text = text,
				Size = UDim2.new(1, -20, 0, 30),
				BackgroundColor3 = Color3.fromRGB(50,50,50),
				TextColor3 = Color3.fromRGB(255,255,255),
				Font = Enum.Font.Gotham,
				TextSize = 14,
				Parent = tabFrame
			})
			create("UICorner", {Parent = cb})

			local enabled = default or false

			local tick = create("TextLabel", {
				Text = enabled and "✓" or "",
				Size = UDim2.new(0, 30, 1, 0),
				Position = UDim2.new(1, -30, 0, 0),
				BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(0,255,0),
				Font = Enum.Font.GothamBold,
				TextSize = 16,
				Parent = cb
			})

			cb.MouseButton1Click:Connect(function()
				enabled = not enabled
				tick.Text = enabled and "✓" or ""
				if callback then callback(enabled) end
			end)
		end

		function API:AddSlider(text, min, max, default, callback)
			local sliderHolder = create("Frame", {
				Size = UDim2.new(1, -20, 0, 50),
				BackgroundTransparency = 1,
				Parent = tabFrame
			})

			create("TextLabel", {
				Text = text,
				Size = UDim2.new(1, 0, 0, 20),
				BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(255,255,255),
				TextXAlignment = Enum.TextXAlignment.Left,
				Font = Enum.Font.Gotham,
				TextSize = 14,
				Parent = sliderHolder
			})

			local bar = create("Frame", {
				Size = UDim2.new(1, 0, 0, 10),
				Position = UDim2.new(0, 0, 0, 30),
				BackgroundColor3 = Color3.fromRGB(60, 60, 60),
				Parent = sliderHolder
			})
			create("UICorner", {Parent = bar})

			local fill = create("Frame", {
				Size = UDim2.new((default - min)/(max - min), 0, 1, 0),
				BackgroundColor3 = Color3.fromRGB(0, 200, 255),
				Parent = bar
			})
			create("UICorner", {Parent = fill})

			local dragging = false

			bar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
					fill.Size = UDim2.new(pos, 0, 1, 0)
					local val = math.floor(min + (max - min) * pos)
					if callback then callback(val) end
				end
			end)
		end

		return API
	end

	return FastyUi
end

return FastyUi
