--[[
    FastyUI - Легкая и красивая библиотека UI для Roblox
    Версия 1.0
]]

local FastyUI = {}
FastyUI.__index = FastyUI

-- Сервисы
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Цвета и стили
local Colors = {
    Background = Color3.fromRGB(25, 25, 25),
    Header = Color3.fromRGB(20, 20, 20),
    TabBar = Color3.fromRGB(30, 30, 30),
    ActiveTab = Color3.fromRGB(40, 40, 40),
    Text = Color3.fromRGB(220, 220, 220),
    Accent = Color3.fromRGB(0, 150, 255),
    Button = Color3.fromRGB(40, 40, 40),
    ButtonHover = Color3.fromRGB(50, 50, 50),
    SliderTrack = Color3.fromRGB(60, 60, 60),
    SliderFill = Color3.fromRGB(0, 150, 255),
    ToggleOn = Color3.fromRGB(0, 200, 0),
    ToggleOff = Color3.fromRGB(200, 0, 0),
    Checkbox = Color3.fromRGB(50, 50, 50),
    CheckboxChecked = Color3.fromRGB(0, 200, 0),
    Dropdown = Color3.fromRGB(40, 40, 40),
    DropdownHover = Color3.fromRGB(50, 50, 50)
}

-- Анимации
local TweenInfo = {
    Fast = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Normal = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Slow = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
}

-- Вспомогательные функции
local function CreateFrame(parent, size, position, bgColor, transparency)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = bgColor or Colors.Background
    frame.BackgroundTransparency = transparency or 0
    frame.BorderSizePixel = 0
    frame.Parent = parent
    return frame
end

local function CreateLabel(parent, text, size, position)
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.TextColor3 = Colors.Text
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

-- Основные функции библиотеки
function FastyUI.New(name)
    local self = setmetatable({}, FastyUI)
    
    -- Создаем основной GUI
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = name or "FastyUI"
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ScreenGui.Parent = game.CoreGui
    
    self.Windows = {}
    self.Elements = {}
    
    return self
end

function FastyUI:Window(title, size, position)
    local window = {
        Title = title,
        Size = size,
        Position = position or UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2),
        Tabs = {},
        Elements = {}
    }
    
    -- Создаем окно
    window.MainFrame = CreateFrame(self.ScreenGui, size, window.Position)
    window.MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    
    -- Заголовок окна
    window.Header = CreateFrame(window.MainFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), Colors.Header)
    window.TitleLabel = CreateLabel(window.Header, title, UDim2.new(0, 200, 1, 0), UDim2.new(0, 10, 0, 0))
    window.TitleLabel.Font = Enum.Font.GothamBold
    
    -- Перетаскивание окна
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        window.MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    window.Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = window.MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    window.Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Закрытие окна
    window.CloseButton = Instance.new("TextButton")
    window.CloseButton.Size = UDim2.new(0, 30, 1, 0)
    window.CloseButton.Position = UDim2.new(1, -30, 0, 0)
    window.CloseButton.BackgroundColor3 = Colors.Header
    window.CloseButton.BorderSizePixel = 0
    window.CloseButton.Text = "X"
    window.CloseButton.TextColor3 = Colors.Text
    window.CloseButton.Font = Enum.Font.GothamBold
    window.CloseButton.TextSize = 14
    window.CloseButton.Parent = window.Header
    
    window.CloseButton.MouseButton1Click:Connect(function()
        window.MainFrame:Destroy()
        for i, w in ipairs(self.Windows) do
            if w == window then
                table.remove(self.Windows, i)
                break
            end
        end
    end)
    
    -- Вкладки
    window.TabButtons = CreateFrame(window.MainFrame, UDim2.new(0, 120, 1, -30), UDim2.new(0, 0, 0, 30), Colors.TabBar)
    window.TabContainer = CreateFrame(window.MainFrame, UDim2.new(1, -120, 1, -30), UDim2.new(0, 120, 0, 30))
    window.TabContainer.BackgroundTransparency = 1
    
    table.insert(self.Windows, window)
    return window
end

function FastyUI:Tab(window, name)
    local tab = {
        Name = name,
        Elements = {}
    }
    
    -- Кнопка вкладки
    tab.Button = Instance.new("TextButton")
    tab.Button.Size = UDim2.new(1, -10, 0, 40)
    tab.Button.Position = UDim2.new(0, 5, 0, #window.Tabs * 40 + 5)
    tab.Button.BackgroundColor3 = #window.Tabs == 0 and Colors.ActiveTab or Colors.TabBar
    tab.Button.BorderSizePixel = 0
    tab.Button.Text = name
    tab.Button.TextColor3 = Colors.Text
    tab.Button.Font = Enum.Font.GothamBold
    tab.Button.TextSize = 12
    tab.Button.Parent = window.TabButtons
    
    -- Контейнер вкладки
    tab.Container = Instance.new("ScrollingFrame")
    tab.Container.Size = UDim2.new(1, -20, 1, -20)
    tab.Container.Position = UDim2.new(0, 10, 0, 10)
    tab.Container.BackgroundTransparency = 1
    tab.Container.BorderSizePixel = 0
    tab.Container.ScrollBarThickness = 3
    tab.Container.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
    tab.Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tab.Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    tab.Container.Visible = #window.Tabs == 0
    tab.Container.Parent = window.TabContainer
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 5)
    UIListLayout.Parent = tab.Container
    
    -- Обработка клика
    tab.Button.MouseButton1Click:Connect(function()
        for _, t in ipairs(window.Tabs) do
            t.Container.Visible = false
            TweenService:Create(t.Button, TweenInfo.Fast, {BackgroundColor3 = Colors.TabBar}):Play()
        end
        tab.Container.Visible = true
        TweenService:Create(tab.Button, TweenInfo.Fast, {BackgroundColor3 = Colors.ActiveTab}):Play()
    end)
    
    table.insert(window.Tabs, tab)
    return tab
end

function FastyUI:Label(tab, text)
    local label = CreateLabel(tab.Container, text, UDim2.new(1, -10, 0, 20), UDim2.new(0, 0, 0, 0))
    table.insert(tab.Elements, label)
    return label
end

function FastyUI:Button(tab, text, callback)
    local button = {
        Text = text,
        Callback = callback
    }
    
    button.Frame = CreateFrame(tab.Container, UDim2.new(1, -10, 0, 30), UDim2.new(0, 0, 0, 0), Colors.Button)
    button.Label = CreateLabel(button.Frame, text, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0))
    button.Label.TextXAlignment = Enum.TextXAlignment.Center
    
    -- Анимации кнопки
    button.Frame.MouseEnter:Connect(function()
        TweenService:Create(button.Frame, TweenInfo.Fast, {BackgroundColor3 = Colors.ButtonHover}):Play()
    end)
    
    button.Frame.MouseLeave:Connect(function()
        TweenService:Create(button.Frame, TweenInfo.Fast, {BackgroundColor3 = Colors.Button}):Play()
    end)
    
    button.Frame.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    table.insert(tab.Elements, button)
    return button
end

function FastyUI:Toggle(tab, text, default, callback)
    local toggle = {
        Value = default or false,
        Callback = callback
    }
    
    toggle.Frame = CreateFrame(tab.Container, UDim2.new(1, -10, 0, 30), UDim2.new(0, 0, 0, 0))
    toggle.Frame.BackgroundTransparency = 1
    
    toggle.Label = CreateLabel(toggle.Frame, text, UDim2.new(0, 200, 1, 0), UDim2.new(0, 0, 0, 0))
    
    toggle.Button = CreateFrame(toggle.Frame, UDim2.new(0, 50, 0, 20), UDim2.new(1, -50, 0.5, -10), toggle.Value and Colors.ToggleOn or Colors.ToggleOff)
    toggle.Indicator = CreateFrame(toggle.Button, UDim2.new(0, 16, 1, -4), toggle.Value and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2), Color3.new(1, 1, 1))
    
    -- Обработка клика
    toggle.Button.MouseButton1Click:Connect(function()
        toggle.Value = not toggle.Value
        TweenService:Create(toggle.Button, TweenInfo.Fast, {
            BackgroundColor3 = toggle.Value and Colors.ToggleOn or Colors.ToggleOff
        }):Play()
        
        local newPos = toggle.Value and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2)
        TweenService:Create(toggle.Indicator, TweenInfo.Fast, {Position = newPos}):Play()
        
        if callback then callback(toggle.Value) end
    end)
    
    table.insert(tab.Elements, toggle)
    return toggle
end

function FastyUI:Slider(tab, text, min, max, default, callback)
    local slider = {
        Min = min,
        Max = max,
        Value = default or min,
        Callback = callback
    }
    
    slider.Frame = CreateFrame(tab.Container, UDim2.new(1, -10, 0, 50), UDim2.new(0, 0, 0, 0))
    slider.Frame.BackgroundTransparency = 1
    
    slider.Label = CreateLabel(slider.Frame, text, UDim2.new(0, 200, 0, 20), UDim2.new(0, 0, 0, 0))
    slider.ValueLabel = CreateLabel(slider.Frame, tostring(default), UDim2.new(0, 50, 0, 20), UDim2.new(1, -50, 0, 0))
    slider.ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    
    slider.Track = CreateFrame(slider.Frame, UDim2.new(1, 0, 0, 5), UDim2.new(0, 0, 1, -15), Colors.SliderTrack)
    slider.Fill = CreateFrame(slider.Track, UDim2.new((default - min) / (max - min), 0, 1, 0), UDim2.new(0, 0, 0, 0), Colors.SliderFill)
    slider.Button = CreateFrame(slider.Track, UDim2.new(0, 10, 0, 15), UDim2.new(slider.Fill.Size.X.Scale, -5, 0, -5), Color3.new(0.9, 0.9, 0.9))
    slider.Button.ZIndex = 2
    
    -- Перетаскивание ползунка
    local dragging = false
    
    slider.Button.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    local function updateSlider(input)
        if dragging then
            local pos = UDim2.new(math.clamp((input.Position.X - slider.Track.AbsolutePosition.X) / slider.Track.AbsoluteSize.X, 0, 1), 0, 0, 0)
            slider.Fill.Size = UDim2.new(pos.X.Scale, 0, 1, 0)
            slider.Button.Position = UDim2.new(pos.X.Scale, -5, 0, -5)
            
            local value = math.floor(min + (max - min) * pos.X.Scale)
            slider.Value = value
            slider.ValueLabel.Text = tostring(value)
            
            if callback then callback(value) end
        end
    end
    
    slider.Button.MouseMoved:Connect(updateSlider)
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            updateSlider(input)
        end
    end)
    
    table.insert(tab.Elements, slider)
    return slider
end

function FastyUI:Dropdown(tab, text, options, default, callback)
    local dropdown = {
        Options = options,
        Selected = default or options[1],
        Callback = callback
    }
    
    dropdown.Frame = CreateFrame(tab.Container, UDim2.new(1, -10, 0, 30), UDim2.new(0, 0, 0, 0))
    dropdown.Frame.BackgroundTransparency = 1
    
    dropdown.Label = CreateLabel(dropdown.Frame, text, UDim2.new(0, 200, 1, 0), UDim2.new(0, 0, 0, 0))
    
    dropdown.Button = CreateFrame(dropdown.Frame, UDim2.new(0, 150, 0, 25), UDim2.new(1, -150, 0.5, -12.5), Colors.Dropdown)
    dropdown.ButtonLabel = CreateLabel(dropdown.Button, dropdown.Selected, UDim2.new(1, -20, 1, 0), UDim2.new(0, 5, 0, 0))
    
    dropdown.Arrow = Instance.new("ImageLabel")
    dropdown.Arrow.Size = UDim2.new(0, 12, 0, 12)
    dropdown.Arrow.Position = UDim2.new(1, -15, 0.5, -6)
    dropdown.Arrow.BackgroundTransparency = 1
    dropdown.Arrow.Image = "rbxassetid://3926305904"
    dropdown.Arrow.ImageRectOffset = Vector2.new(364, 364)
    dropdown.Arrow.ImageRectSize = Vector2.new(36, 36)
    dropdown.Arrow.Parent = dropdown.Button
    
    dropdown.List = CreateFrame(dropdown.Button, UDim2.new(1, 0, 0, 0), UDim2.new(0, 0, 1, 5), Colors.Dropdown)
    dropdown.List.Visible = false
    dropdown.List.ZIndex = 100
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 1)
    UIListLayout.Parent = dropdown.List
    
    for i, option in ipairs(options) do
        local optionButton = CreateFrame(dropdown.List, UDim2.new(1, -5, 0, 25), UDim2.new(0, 2.5, 0, (i-1)*26), Colors.Dropdown)
        optionButton.ZIndex = 101
        
        local optionLabel = CreateLabel(optionButton, option, UDim2.new(1, -10, 1, 0), UDim2.new(0, 5, 0, 0))
        
        optionButton.MouseEnter:Connect(function()
            TweenService:Create(optionButton, TweenInfo.Fast, {BackgroundColor3 = Colors.DropdownHover}):Play()
        end)
        
        optionButton.MouseLeave:Connect(function()
            TweenService:Create(optionButton, TweenInfo.Fast, {BackgroundColor3 = Colors.Dropdown}):Play()
        end)
        
        optionButton.MouseButton1Click:Connect(function()
            dropdown.Selected = option
            dropdown.ButtonLabel.Text = option
            dropdown.List.Visible = false
            TweenService:Create(dropdown.Arrow, TweenInfo.Fast, {Rotation = 0}):Play()
            
            if callback then callback(option) end
        end)
    end
    
    dropdown.Button.MouseButton1Click:Connect(function()
        dropdown.List.Visible = not dropdown.List.Visible
        if dropdown.List.Visible then
            TweenService:Create(dropdown.Arrow, TweenInfo.Fast, {Rotation = 180}):Play()
            TweenService:Create(dropdown.List, TweenInfo.Fast, {
                Size = UDim2.new(1, 0, 0, math.min(#options * 26, 130))
            }):Play()
        else
            TweenService:Create(dropdown.Arrow, TweenInfo.Fast, {Rotation = 0}):Play()
            TweenService:Create(dropdown.List, TweenInfo.Fast, {Size = UDim2.new(1, 0, 0, 0)}):Play()
        end
    end)
    
    local function closeDropdown(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if not dropdown.List:IsDescendantOf(game) then return end
            
            local mousePos = input.Position
            local framePos = dropdown.List.AbsolutePosition
            local frameSize = dropdown.List.AbsoluteSize
            
            if mousePos.X < framePos.X or mousePos.X > framePos.X + frameSize.X or
               mousePos.Y < framePos.Y or mousePos.Y > framePos.Y + frameSize.Y then
                dropdown.List.Visible = false
                TweenService:Create(dropdown.Arrow, TweenInfo.Fast, {Rotation = 0}):Play()
                TweenService:Create(dropdown.List, TweenInfo.Fast, {Size = UDim2.new(1, 0, 0, 0)}):Play()
            end
        end
    end
    
    UserInputService.InputBegan:Connect(closeDropdown)
    
    table.insert(tab.Elements, dropdown)
    return dropdown
end

function FastyUI:Bind(tab, text, default, callback)
    local bind = {
        Key = default or Enum.KeyCode.Unknown,
        Listening = false,
        Callback = callback
    }
    
    bind.Frame = CreateFrame(tab.Container, UDim2.new(1, -10, 0, 30), UDim2.new(0, 0, 0, 0))
    bind.Frame.BackgroundTransparency = 1
    
    bind.Label = CreateLabel(bind.Frame, text, UDim2.new(0, 200, 1, 0), UDim2.new(0, 0, 0, 0))
    
    bind.Button = CreateFrame(bind.Frame, UDim2.new(0, 100, 0, 25), UDim2.new(1, -100, 0.5, -12.5), Colors.Dropdown)
    bind.ButtonLabel = CreateLabel(bind.Button, bind.Key.Name, UDim2.new(1, 0, 1, 0), UDim2.new(0, 0, 0, 0))
    bind.ButtonLabel.TextXAlignment = Enum.TextXAlignment.Center
    
    bind.Button.MouseButton1Click:Connect(function()
        bind.Listening = true
        bind.ButtonLabel.Text = "..."
        bind.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not bind.Listening or gameProcessed then return end
        
        local key
        if input.UserInputType == Enum.UserInputType.Keyboard then
            key = input.KeyCode
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            key = Enum.KeyCode.MouseButton1
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            key = Enum.KeyCode.MouseButton2
        elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
            key = Enum.KeyCode.MouseButton3
        else
            return
        end
        
        bind.Key = key
        bind.ButtonLabel.Text = key.Name
        bind.Button.BackgroundColor3 = Colors.Dropdown
        bind.Listening = false
        
        if callback then callback(key) end
    end)
    
    table.insert(tab.Elements, bind)
    return bind
end

function FastyUI:Checkbox(tab, text, default, callback)
    local checkbox = {
        Value = default or false,
        Callback = callback
    }
    
    checkbox.Frame = CreateFrame(tab.Container, UDim2.new(1, -10, 0, 30), UDim2.new(0, 0, 0, 0))
    checkbox.Frame.BackgroundTransparency = 1
    
    checkbox.Label = CreateLabel(checkbox.Frame, text, UDim2.new(0, 200, 1, 0), UDim2.new(0, 0, 0, 0))
    
    checkbox.Button = CreateFrame(checkbox.Frame, UDim2.new(0, 20, 0, 20), UDim2.new(1, -30, 0.5, -10), checkbox.Value and Colors.CheckboxChecked or Colors.Checkbox)
    checkbox.Button.BorderSizePixel = 1
    checkbox.Button.BorderColor3 = Color3.fromRGB(80, 80, 80)
    
    checkbox.Check = Instance.new("ImageLabel")
    checkbox.Check.Size = UDim2.new(0, 14, 0, 14)
    checkbox.Check.Position = UDim2.new(0.5, -7, 0.5, -7)
    checkbox.Check.BackgroundTransparency = 1
    checkbox.Check.Image = "rbxassetid://3926305904"
    checkbox.Check.ImageRectOffset = Vector2.new(100, 100)
    checkbox.Check.ImageRectSize = Vector2.new(50, 50)
    checkbox.Check.Visible = checkbox.Value
    checkbox.Check.Parent = checkbox.Button
    
    checkbox.Button.MouseButton1Click:Connect(function()
        checkbox.Value = not checkbox.Value
        checkbox.Check.Visible = checkbox.Value
        TweenService:Create(checkbox.Button, TweenInfo.Fast, {
            BackgroundColor3 = checkbox.Value and Colors.CheckboxChecked or Colors.Checkbox
        }):Play()
        
        if callback then callback(checkbox.Value) end
    end)
    
    table.insert(tab.Elements, checkbox)
    return checkbox
end

-- Пример использования:
--[[
local UI = FastyUI.New("MyUI")

local window = UI:Window("FastyUI Example", UDim2.new(0, 500, 0, 400))
local mainTab = UI:Tab(window, "Main")

UI:Label(mainTab, "Welcome to FastyUI!")

UI:Button(mainTab, "Click Me", function()
    print("Button clicked!")
end)

local toggle = UI:Toggle(mainTab, "Enable Feature", false, function(value)
    print("Toggle:", value)
end)

local slider = UI:Slider(mainTab, "Volume", 0, 100, 50, function(value)
    print("Volume:", value)
end)

local dropdown = UI:Dropdown(mainTab, "Options", {"Option 1", "Option 2", "Option 3"}, "Option 1", function(option)
    print("Selected:", option)
end)

local bind = UI:Bind(mainTab, "Key Bind", Enum.KeyCode.F, function(key)
    print("Bind pressed:", key.Name)
end)

local checkbox = UI:Checkbox(mainTab, "Checkbox", true, function(value)
    print("Checkbox:", value)
end)
]]

return FastyUI
