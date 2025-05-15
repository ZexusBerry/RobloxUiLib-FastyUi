local FastyUi = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Настройки стилей по умолчанию
local DefaultStyle = {
	BackgroundColor = Color3.fromRGB(30, 30, 30),
	AccentColor = Color3.fromRGB(0, 170, 255),
	TextColor = Color3.fromRGB(255, 255, 255),
	CornerRadius = UDim.new(0, 8),
	ShadowTransparency = 0.5,
	Font = Enum.Font.Gotham,
	AnimationSpeed = 0.3
}

-- Вспомогательная функция для создания анимаций
local function createTween(instance, properties, duration, easingStyle)
	local tweenInfo = TweenInfo.new(duration, easingStyle or Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local tween = TweenService:Create(instance, tweenInfo, properties)
	tween:Play()
	return tween
end

-- Основной класс библиотеки
FastyUi.__index = FastyUi

function FastyUi.new()
	local self = setmetatable({}, FastyUi)
	self.ScreenGui = Instance.new("ScreenGui")
	self.ScreenGui.Name = "FastyUi"
	self.ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
	self.ScreenGui.ResetOnSpawn = false
	return self
end

-- Создание окна
function FastyUi:CreateWindow(title, size)
	local window = Instance.new("Frame")
	window.Size = size or UDim2.new(0, 400, 0, 300)
	window.Position = UDim2.new(0.5, -200, 0.5, -150)
	window.BackgroundColor3 = DefaultStyle.BackgroundColor
	window.BorderSizePixel = 0
	window.Parent = self.ScreenGui
	window.ClipsDescendants = true

	local corner = Instance.new("UICorner")
	corner.CornerRadius = DefaultStyle.CornerRadius
	corner.Parent = window

	local shadow = Instance.new("ImageLabel")
	shadow.Image = "rbxassetid://1316045217"
	shadow.ImageTransparency = DefaultStyle.ShadowTransparency
	shadow.BackgroundTransparency = 1
	shadow.Size = UDim2.new(1, 10, 1, 10)
	shadow.Position = UDim2.new(0, -5, 0, -5)
	shadow.ZIndex = -1
	shadow.Parent = window

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Text = title or "FastyUi"
	titleLabel.Size = UDim2.new(1, 0, 0, 30)
	titleLabel.BackgroundTransparency = 1
	titleLabel.TextColor3 = DefaultStyle.TextColor
	titleLabel.Font = DefaultStyle.Font
	titleLabel.TextSize = 16
	titleLabel.Parent = window

	return window
end

-- Создание кнопки
function FastyUi:CreateButton(parent, text, size, callback)
	local button = Instance.new("TextButton")
	button.Size = size or UDim2.new(0, 150, 0, 40)
	button.Position = UDim2.new(0, 10, 0, 40)
	button.BackgroundColor3 = DefaultStyle.AccentColor
	button.TextColor3 = DefaultStyle.TextColor
	button.Text = text or "Button"
	button.Font = DefaultStyle.Font
	button.TextSize = 14
	button.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = DefaultStyle.CornerRadius
	corner.Parent = button

	-- Анимация при наведении
	button.MouseEnter:Connect(function()
		createTween(button, {BackgroundColor3 = DefaultStyle.AccentColor:Lerp(Color3.new(1, 1, 1), 0.2)}, DefaultStyle.AnimationSpeed)
	end)
	button.MouseLeave:Connect(function()
		createTween(button, {BackgroundColor3 = DefaultStyle.AccentColor}, DefaultStyle.AnimationSpeed)
	end)

	-- Callback при нажатии
	if callback then
		button.MouseButton1Click:Connect(callback)
	end

	return button
end

-- Создание слайдера
function FastyUi:CreateSlider(parent, text, min, max, default, callback)
	local slider = Instance.new("Frame")
	slider.Size = UDim2.new(0, 200, 0, 40)
	slider.BackgroundColor3 = DefaultStyle.BackgroundColor
	slider.BorderSizePixel = 0
	slider.Parent = parent

	local track = Instance.new("Frame")
	track.Size = UDim2.new(1, -20, 0, 6)
	track.Position = UDim2.new(0, 10, 0.5, -3)
	track.BackgroundColor3 = DefaultStyle.AccentColor:Lerp(Color3.new(0, 0, 0), 0.5)
	track.Parent = slider

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fill.BackgroundColor3 = DefaultStyle.AccentColor
	fill.Parent = track

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 4)
	corner.Parent = track
	corner:Clone().Parent = fill

	local label = Instance.new("TextLabel")
	label.Text = text .. ": " .. tostring(default)
	label.Size = UDim2.new(1, 0, 0, 20)
	label.BackgroundTransparency = 1
	label.TextColor3 = DefaultStyle.TextColor
	label.Font = DefaultStyle.Font
	label.TextSize = 12
	label.Parent = slider

	-- Логика слайдера
	local dragging = false
	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
		end
	end)

	track.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local mouseX = input.Position.X
			local trackX = track.AbsolutePosition.X
			local trackWidth = track.AbsoluteSize.X
			local relative = math.clamp((mouseX - trackX) / trackWidth, 0, 1)
			local value = min + (max - min) * relative
			fill.Size = UDim2.new(relative, 0, 1, 0)
			label.Text = text .. ": " .. math.floor(value)
			if callback then
				callback(value)
			end
		end
	end)

	return slider
end

-- Создание метки (Label)
function FastyUi:CreateLabel(parent, text)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0, 200, 0, 30)
	label.BackgroundTransparency = 1
	label.TextColor3 = DefaultStyle.TextColor
	label.Text = text or "Label"
	label.Font = DefaultStyle.Font
	label.TextSize = 14
	label.Parent = parent
	return label
end

-- Создание вкладки (Tab)
function FastyUi:CreateTab(parent, tabs)
	local tabContainer = Instance.new("Frame")
	tabContainer.Size = UDim2.new(1, 0, 0, 40)
	tabContainer.BackgroundTransparency = 1
	tabContainer.Parent = parent

	local content = Instance.new("Frame")
	content.Size = UDim2.new(1, 0, 1, -40)
	content.Position = UDim2.new(0, 0, 0, 40)
	content.BackgroundTransparency = 1
	content.Parent = parent

	local currentTab = nil
	for i, tab in ipairs(tabs) do
		local button = self:CreateButton(tabContainer, tab.name, UDim2.new(1/#tabs, 0, 0, 40), function()
			if currentTab then
				currentTab.Visible = false
			end
			tab.content.Visible = true
			currentTab = tab.content
		end)
		button.Position = UDim2.new((i-1)/#tabs, 0, 0, 0)
		tab.content.Parent = content
		tab.content.Visible = (i == 1)
		if i == 1 then
			currentTab = tab.content
		end
	end

	return content
end

-- Создание выпадающего списка (DropDown)
function FastyUi:CreateDropDown(parent, text, options, callback)
	local dropdown = Instance.new("Frame")
	dropdown.Size = UDim2.new(0, 150, 0, 30)
	dropdown.BackgroundColor3 = DefaultStyle.BackgroundColor
	dropdown.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = DefaultStyle.CornerRadius
	corner.Parent = dropdown

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 1, 0)
	button.BackgroundTransparency = 1
	button.TextColor3 = DefaultStyle.TextColor
	button.Text = text or "Select"
	button.Font = DefaultStyle.Font
	button.TextSize = 14
	button.Parent = dropdown

	local list = Instance.new("Frame")
	list.Size = UDim2.new(1, 0, 0, 0)
	list.Position = UDim2.new(0, 0, 1, 0)
	list.BackgroundColor3 = DefaultStyle.BackgroundColor
	list.ClipsDescendants = true
	list.Visible = false
	list.Parent = dropdown

	local cornerList = Instance.new("UICorner")
	cornerList.CornerRadius = DefaultStyle.CornerRadius
	cornerList.Parent = list

	local uiListLayout = Instance.new("UIListLayout")
	uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uiListLayout.Parent = list

	-- Открытие/закрытие списка
	button.MouseButton1Click:Connect(function()
		list.Visible = not list.Visible
		local height = #options * 30
		createTween(list, {Size = list.Visible and UDim2.new(1, 0, 0, height) or UDim2.new(1, 0, 0, 0)}, DefaultStyle.AnimationSpeed)
	end)

	-- Создание опций
	for i, option in ipairs(options) do
		local optButton = self:CreateButton(list, option, UDim2.new(1, 0, 0, 30), function()
			button.Text = option
			list.Visible = false
			createTween(list, {Size = UDim2.new(1, 0, 0, 0)}, DefaultStyle.AnimationSpeed)
			if callback then
				callback(option)
			end
		end)
	end

	return dropdown
end

-- Создание чекбокса
function FastyUi:CreateCheckBox(parent, text, default, callback)
	local checkbox = Instance.new("Frame")
	checkbox.Size = UDim2.new(0, 200, 0, 30)
	checkbox.BackgroundTransparency = 1
	checkbox.Parent = parent

	local box = Instance.new("Frame")
	box.Size = UDim2.new(0, 20, 0, 20)
	box.BackgroundColor3 = default and DefaultStyle.AccentColor or DefaultStyle.BackgroundColor
	box.Parent = checkbox

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 4)
	corner.Parent = box

	local label = Instance.new("TextLabel")
	label.Text = text or "Checkbox"
	label.Size = UDim2.new(1, -30, 1, 0)
	label.Position = UDim2.new(0, 30, 0, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = DefaultStyle.TextColor
	label.Font = DefaultStyle.Font
	label.TextSize = 14
	label.Parent = checkbox

	local checked = default
	box.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			checked = not checked
			createTween(box, {BackgroundColor3 = checked and DefaultStyle.AccentColor or DefaultStyle.BackgroundColor}, DefaultStyle.AnimationSpeed)
			if callback then
				callback(checked)
			end
		end
	end)

	return checkbox
end

-- Создание переключателя (Toggle)
function FastyUi:CreateToggle(parent, text, default, callback)
	local toggle = Instance.new("Frame")
	toggle.Size = UDim2.new(0, 60, 0, 30)
	toggle.BackgroundColor3 = DefaultStyle.BackgroundColor
	toggle.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 15)
	corner.Parent = toggle

	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 24, 0, 24)
	knob.Position = default and UDim2.new(1, -28, 0, 3) or UDim2.new(0, 4, 0, 3)
	knob.BackgroundColor3 = DefaultStyle.AccentColor
	knob.Parent = toggle

	local cornerKnob = Instance.new("UICorner")
	cornerKnob.CornerRadius = UDim.new(0, 12)
	cornerKnob.Parent = knob

	local label = Instance.new("TextLabel")
	label.Text = text or "Toggle"
	label.Size = UDim2.new(0, 100, 1, 0)
	label.Position = UDim2.new(1, 10, 0, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = DefaultStyle.TextColor
	label.Font = DefaultStyle.Font
	label.TextSize = 14
	label.Parent = toggle

	local enabled = default
	toggle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			enabled = not enabled
			createTween(knob, {Position = enabled and UDim2.new(1, -28, 0, 3) or UDim2.new(0, 4, 0, 3)}, DefaultStyle.AnimationSpeed)
			createTween(toggle, {BackgroundColor3 = enabled and DefaultStyle.AccentColor:Lerp(Color3.new(0, 0, 0), 0.5) or DefaultStyle.BackgroundColor}, DefaultStyle.AnimationSpeed)
			if callback then
				callback(enabled)
			end
		end
	end)

	return toggle
end

-- Создание привязки клавиш (Bind)
function FastyUi:CreateBind(parent, text, defaultKey, callback)
	local bind = Instance.new("TextButton")
	bind.Size = UDim2.new(0, 150, 0, 30)
	bind.BackgroundColor3 = DefaultStyle.BackgroundColor
	bind.TextColor3 = DefaultStyle.TextColor
	bind.Text = text .. ": " .. (defaultKey and defaultKey.Name or "None")
	bind.Font = DefaultStyle.Font
	bind.TextSize = 14
	bind.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = DefaultStyle.CornerRadius
	corner.Parent = bind

	local binding = false
	bind.MouseButton1Click:Connect(function()
		bind.Text = text .. ": ..."
		binding = true
	end)

	UserInputService.InputBegan:Connect(function(input)
		if binding and input.UserInputType == Enum.UserInputType.Keyboard then
			local key = input.KeyCode
			bind.Text = text .. ": " .. key.Name
			binding = false
			if callback then
				callback(key)
			end
		end
	end)

	return bind
end

return FastyUi
