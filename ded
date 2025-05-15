--[[
    FastyUI Premium - Ultra Smooth Animated UI Library
    Version: 2.0 Premium
    Features:
    - Buttery smooth animations
    - Modern neomorphic design
    - Fully customizable
    - 60 FPS optimized
    - Advanced elements
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local FastyUI = {Premium = true}
FastyUI.__index = FastyUI

-- Premium Color Themes
FastyUI.Themes = {
    Dark = {
        Main = Color3.fromRGB(30, 30, 35),
        Secondary = Color3.fromRGB(45, 45, 50),
        Text = Color3.fromRGB(240, 240, 240),
        Accent = Color3.fromRGB(0, 170, 255),
        Shadow = Color3.fromRGB(15, 15, 20),
        LightShadow = Color3.fromRGB(60, 60, 65)
    },
    Cyber = {
        Main = Color3.fromRGB(15, 20, 30),
        Secondary = Color3.fromRGB(25, 30, 45),
        Text = Color3.fromRGB(200, 220, 255),
        Accent = Color3.fromRGB(0, 255, 170),
        Shadow = Color3.fromRGB(5, 10, 15),
        LightShadow = Color3.fromRGB(40, 50, 70)
    },
    Light = {
        Main = Color3.fromRGB(245, 245, 245),
        Secondary = Color3.fromRGB(230, 230, 230),
        Text = Color3.fromRGB(50, 50, 50),
        Accent = Color3.fromRGB(0, 120, 215),
        Shadow = Color3.fromRGB(200, 200, 200),
        LightShadow = Color3.fromRGB(255, 255, 255)
    }
}

FastyUI.CurrentTheme = FastyUI.Themes.Dark

-- Premium Animation Settings
FastyUI.AnimationSettings = {
    Duration = 0.25,
    EasingStyle = Enum.EasingStyle.Quint,
    EasingDirection = Enum.EasingDirection.Out,
    ButtonHoverSize = 1.03,
    ButtonPressSize = 0.97
}

-- Utility functions
local function CreateInstance(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties) do
        instance[property] = value
    end
    return instance
end

local function Tween(instance, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(
        duration or FastyUI.AnimationSettings.Duration,
        easingStyle or FastyUI.AnimationSettings.EasingStyle,
        easingDirection or FastyUI.AnimationSettings.EasingDirection
    )
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

local function RippleEffect(button, mouse)
    local ripple = CreateInstance("Frame", {
        Parent = button,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.8,
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0, mouse.X - button.AbsolutePosition.X, 0, mouse.Y - button.AbsolutePosition.Y),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = 10,
        Name = "Ripple"
    })
    
    local corner = CreateInstance("UICorner", {
        Parent = ripple,
        CornerRadius = UDim.new(1, 0)
    })
    
    Tween(ripple, {
        Size = UDim2.new(2, 0, 2, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }, 0.5).Completed:Connect(function()
        ripple:Destroy()
    end)
end

-- Premium Window
function FastyUI:Window(options)
    options = options or {}
    local title = options.Title or "FastyUI Premium"
    local size = options.Size or Vector2.new(500, 450)
    local position = options.Position or Vector2.new(100, 100)
    local theme = options.Theme or "Dark"
    local accent = options.Accent or nil
    
    -- Set theme
    self.CurrentTheme = self.Themes[theme] or self.Themes.Dark
    
    -- Custom accent color
    if accent then
        self.CurrentTheme.Accent = accent
    end
    
    -- Create premium screen gui
    local screenGui = CreateInstance("ScreenGui", {
        Name = "FastyUIPremium",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Global
    })
    
    if gethui then
        screenGui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(screenGui)
        screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    else
        screenGui.Parent = game:GetService("CoreGui")
    end
    
    -- Main window frame
    local windowFrame = CreateInstance("Frame", {
        Parent = screenGui,
        Name = "PremiumWindow",
        Size = UDim2.new(0, size.X, 0, 0),
        Position = UDim2.new(0, position.X, 0, position.Y),
        BackgroundColor3 = self.CurrentTheme.Main,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 1
    })
    
    -- Neomorphic shadow
    local shadow1 = CreateInstance("ImageLabel", {
        Parent = windowFrame,
        Name = "Shadow1",
        Size = UDim2.new(1, 12, 1, 12),
        Position = UDim2.new(0, -6, 0, -6),
        BackgroundTransparency = 1,
        Image = "rbxassetid://1316045217",
        ImageColor3 = self.CurrentTheme.Shadow,
        ImageTransparency = 0.8,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118),
        ZIndex = 0
    })
    
    local shadow2 = CreateInstance("ImageLabel", {
        Parent = windowFrame,
        Name = "Shadow2",
        Size = UDim2.new(1, -12, 1, -12),
        Position = UDim2.new(0, 6, 0, 6),
        BackgroundTransparency = 1,
        Image = "rbxassetid://1316045217",
        ImageColor3 = self.CurrentTheme.LightShadow,
        ImageTransparency = 0.8,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118),
        ZIndex = 0
    })
    
    -- Title bar
    local titleBar = CreateInstance("Frame", {
        Parent = windowFrame,
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = self.CurrentTheme.Secondary,
        BorderSizePixel = 0,
        ZIndex = 2
    })
    
    local titleText = CreateInstance("TextLabel", {
        Parent = titleBar,
        Name = "Title",
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = self.CurrentTheme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        ZIndex = 2
    })
    
    -- Close button
    local closeButton = CreateInstance("TextButton", {
        Parent = titleBar,
        Name = "CloseButton",
        Size = UDim2.new(0, 30, 1, 0),
        Position = UDim2.new(1, -30, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 60, 60),
        BorderSizePixel = 0,
        Text = "×",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        ZIndex = 2
    })
    
    -- Tab container
    local tabContainer = CreateInstance("Frame", {
        Parent = windowFrame,
        Name = "TabContainer",
        Size = UDim2.new(1, -20, 0, 35),
        Position = UDim2.new(0, 10, 0, 35),
        BackgroundTransparency = 1,
        ZIndex = 2
    })
    
    local tabListLayout = CreateInstance("UIListLayout", {
        Parent = tabContainer,
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 5)
    })
    
    -- Content frame
    local contentFrame = CreateInstance("ScrollingFrame", {
        Parent = windowFrame,
        Name = "Content",
        Size = UDim2.new(1, -20, 1, -80),
        Position = UDim2.new(0, 10, 0, 80),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 5,
        ScrollBarImageColor3 = self.CurrentTheme.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ZIndex = 2
    })
    
    -- UIListLayout for content
    local contentListLayout = CreateInstance("UIListLayout", {
        Parent = contentFrame,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10)
    })
    
    local contentPadding = CreateInstance("UIPadding", {
        Parent = contentFrame,
        PaddingTop = UDim.new(0, 5),
        PaddingBottom = UDim.new(0, 5)
    })
    
    -- Make window draggable
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function Update(input)
        local delta = input.Position - dragStart
        local newPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        windowFrame.Position = newPosition
    end
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = windowFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            Update(input)
        end
    end)
    
    -- Close button functionality
    closeButton.MouseButton1Click:Connect(function()
        Tween(windowFrame, {Size = UDim2.new(0, size.X, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In).Completed:Connect(function()
            screenGui:Destroy()
        end)
    end)
    
    -- Hover effects
    closeButton.MouseEnter:Connect(function()
        Tween(closeButton, {BackgroundColor3 = Color3.fromRGB(255, 80, 80)})
    end)
    
    closeButton.MouseLeave:Connect(function()
        Tween(closeButton, {BackgroundColor3 = Color3.fromRGB(255, 60, 60)})
    end)
    
    -- Initialize window with animation
    Tween(windowFrame, {Size = UDim2.new(0, size.X, 0, size.Y)}, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    
    -- Create window object
    local window = {
        ScreenGui = screenGui,
        WindowFrame = windowFrame,
        ContentFrame = contentFrame,
        Tabs = {},
        CurrentTab = nil
    }
    
    -- Add premium methods to window
    function window:Tab(name, icon)
        local tabButton = CreateInstance("TextButton", {
            Parent = tabContainer,
            Name = name .. "TabButton",
            Size = UDim2.new(0, 100, 1, 0),
            BackgroundColor3 = self.CurrentTheme.Main,
            BorderSizePixel = 0,
            Text = " " .. name,
            TextColor3 = self.CurrentTheme.Text,
            Font = Enum.Font.GothamSemibold,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 2
        })
        
        local tabButtonCorner = CreateInstance("UICorner", {
            Parent = tabButton,
            CornerRadius = UDim.new(0, 5)
        })
        
        if icon then
            local tabIcon = CreateInstance("ImageLabel", {
                Parent = tabButton,
                Name = "Icon",
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(0, 8, 0.5, -8),
                BackgroundTransparency = 1,
                Image = icon,
                ImageColor3 = self.CurrentTheme.Text,
                ZIndex = 2
            })
        end
        
        local tabContent = CreateInstance("Frame", {
            Parent = contentFrame,
            Name = name .. "TabContent",
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            Visible = false,
            ZIndex = 2
        })
        
        local tabListLayout = CreateInstance("UIListLayout", {
            Parent = tabContent,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10)
        })
        
        -- Tab selection logic
        tabButton.MouseButton1Click:Connect(function()
            if window.CurrentTab then
                window.CurrentTab.Visible = false
                Tween(tabButton, {BackgroundColor3 = self.CurrentTheme.Main})
            end
            
            window.CurrentTab = tabContent
            tabContent.Visible = true
            Tween(tabButton, {BackgroundColor3 = self.CurrentTheme.Accent})
        end)
        
        -- Hover effect
        tabButton.MouseEnter:Connect(function()
            if window.CurrentTab ~= tabContent then
                Tween(tabButton, {BackgroundColor3 = Color3.fromRGB(
                    self.CurrentTheme.Main.R * 255 + 10,
                    self.CurrentTheme.Main.G * 255 + 10,
                    self.CurrentTheme.Main.B * 255 + 10
                )})
            end
        end)
        
        tabButton.MouseLeave:Connect(function()
            if window.CurrentTab ~= tabContent then
                Tween(tabButton, {BackgroundColor3 = self.CurrentTheme.Main})
            end
        end)
        
        -- Select first tab by default
        if #window.Tabs == 0 then
            window.CurrentTab = tabContent
            tabContent.Visible = true
            Tween(tabButton, {BackgroundColor3 = self.CurrentTheme.Accent})
        end
        
        -- Add tab to window
        table.insert(window.Tabs, {
            Button = tabButton,
            Content = tabContent
        })
        
        -- Create premium tab object with element creation methods
        local tab = {
            Button = tabButton,
            Content = tabContent
        }
        
        -- Premium Button
        function tab:Button(options)
            options = options or {}
            local name = options.Name or "Button"
            local callback = options.Callback or function() end
            local icon = options.Icon or nil
            
            local buttonFrame = CreateInstance("Frame", {
                Parent = tabContent,
                Name = name .. "ButtonFrame",
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundColor3 = self.CurrentTheme.Secondary,
                BorderSizePixel = 0,
                ZIndex = 2
            })
            
            local buttonCorner = CreateInstance("UICorner", {
                Parent = buttonFrame,
                CornerRadius = UDim.new(0, 5)
            })
            
            local button = CreateInstance("TextButton", {
                Parent = buttonFrame,
                Name = name .. "Button",
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "  " .. name,
                TextColor3 = self.CurrentTheme.Text,
                Font = Enum.Font.GothamSemibold,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 2
            })
            
            if icon then
                local buttonIcon = CreateInstance("ImageLabel", {
                    Parent = buttonFrame,
                    Name = "Icon",
                    Size = UDim2.new(0, 20, 0, 20),
                    Position = UDim2.new(0, 8, 0.5, -10),
                    BackgroundTransparency = 1,
                    Image = icon,
                    ImageColor3 = self.CurrentTheme.Text,
                    ZIndex = 2
                })
            end
            
            -- Hover effect
            button.MouseEnter:Connect(function()
                Tween(buttonFrame, {
                    BackgroundColor3 = Color3.fromRGB(
                        self.CurrentTheme.Secondary.R * 255 + 15,
                        self.CurrentTheme.Secondary.G * 255 + 15,
                        self.CurrentTheme.Secondary.B * 255 + 15
                    ),
                    Size = UDim2.new(1, 0, 0, 35) * UDim2.new(0, FastyUI.AnimationSettings.ButtonHoverSize, 0, 1)
                })
            end)
            
            button.MouseLeave:Connect(function()
                Tween(buttonFrame, {
                    BackgroundColor3 = self.CurrentTheme.Secondary,
                    Size = UDim2.new(1, 0, 0, 35)
                })
            end)
            
            -- Click effect
            button.MouseButton1Down:Connect(function()
                Tween(buttonFrame, {
                    Size = UDim2.new(1, 0, 0, 35) * UDim2.new(0, FastyUI.AnimationSettings.ButtonPressSize, 0, 1)
                })
            end)
            
            button.MouseButton1Up:Connect(function()
                Tween(buttonFrame, {
                    Size = UDim2.new(1, 0, 0, 35) * UDim2.new(0, FastyUI.AnimationSettings.ButtonHoverSize, 0, 1)
                })
                RippleEffect(buttonFrame, UserInputService:GetMouseLocation())
                callback()
            end)
            
            -- Animation on creation
            buttonFrame.Size = UDim2.new(1, 0, 0, 0)
            Tween(buttonFrame, {Size = UDim2.new(1, 0, 0, 35)}, 0.2)
            
            return button
        end
        
        -- Premium Label
        function tab:Label(options)
            options = options or {}
            local text = options.Text or "Label"
            local textSize = options.TextSize or 14
            local center = options.Center or false
            
            local labelFrame = CreateInstance("Frame", {
                Parent = tabContent,
                Name = "LabelFrame",
                Size = UDim2.new(1, 0, 0, textSize + 10),
                BackgroundTransparency = 1,
                ZIndex = 2
            })
            
            local label = CreateInstance("TextLabel", {
                Parent = labelFrame,
                Name = "Label",
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = text,
                TextColor3 = self.CurrentTheme.Text,
                TextXAlignment = center and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
                Font = Enum.Font.Gotham,
                TextSize = textSize,
                ZIndex = 2
            })
            
            -- Animation on creation
            labelFrame.Size = UDim2.new(1, 0, 0, 0)
            Tween(labelFrame, {Size = UDim2.new(1, 0, 0, textSize + 10)}, 0.2)
            
            return label
        end
        
        -- Premium Slider
        function tab:Slider(options)
            options = options or {}
            local name = options.Name or "Slider"
            local min = options.Min or 0
            local max = options.Max or 100
            local default = options.Default or min
            local precise = options.Precise or false
            local callback = options.Callback or function() end
            local unit = options.Unit or ""
            
            local sliderFrame = CreateInstance("Frame", {
                Parent = tabContent,
                Name = name .. "SliderFrame",
                Size = UDim2.new(1, 0, 0, 60),
                BackgroundTransparency = 1,
                ZIndex = 2
            })
            
            local titleLabel = CreateInstance("TextLabel", {
                Parent = sliderFrame,
                Name = "Title",
                Size = UDim2.new(1, 0, 0, 15),
                BackgroundTransparency = 1,
                Text = name,
                TextColor3 = self.CurrentTheme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                ZIndex = 2
            })
            
            local valueLabel = CreateInstance("TextLabel", {
                Parent = sliderFrame,
                Name = "Value",
                Size = UDim2.new(0, 100, 0, 15),
                Position = UDim2.new(1, -100, 0, 0),
                BackgroundTransparency = 1,
                Text = tostring(default) .. unit,
                TextColor3 = self.CurrentTheme.Text,
                TextXAlignment = Enum.TextXAlignment.Right,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                ZIndex = 2
            })
            
            local track = CreateInstance("Frame", {
                Parent = sliderFrame,
                Name = "Track",
                Size = UDim2.new(1, 0, 0, 5),
                Position = UDim2.new(0, 0, 0, 30),
                BackgroundColor3 = self.CurrentTheme.Secondary,
                BorderSizePixel = 0,
                ZIndex = 2
            })
            
            local trackCorner = CreateInstance("UICorner", {
                Parent = track,
                CornerRadius = UDim.new(1, 0)
            })
            
            local fill = CreateInstance("Frame", {
                Parent = track,
                Name = "Fill",
                Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = self.CurrentTheme.Accent,
                BorderSizePixel = 0,
                ZIndex = 3
            })
            
            local fillCorner = CreateInstance("UICorner", {
                Parent = fill,
                CornerRadius = UDim.new(1, 0)
            })
            
            local handle = CreateInstance("Frame", {
                Parent = track,
                Name = "Handle",
                Size = UDim2.new(0, 12, 0, 12),
                Position = UDim2.new((default - min) / (max - min), -6, 0.5, -6),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                ZIndex = 4
            })
            
            local handleCorner = CreateInstance("UICorner", {
                Parent = handle,
                CornerRadius = UDim.new(1, 0)
            })
            
            local handleShadow = CreateInstance("ImageLabel", {
                Parent = handle,
                Name = "Shadow",
                Size = UDim2.new(1, 6, 1, 6),
                Position = UDim2.new(0, -3, 0, -3),
                BackgroundTransparency = 1,
                Image = "rbxassetid://1316045217",
                ImageColor3 = Color3.fromRGB(0, 0, 0),
                ImageTransparency = 0.8,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(10, 10, 118, 118),
                ZIndex = 3
            })
            
            local dragging = false
            
            local function updateValue(input)
                local relativeX = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
                local value
                
                if precise then
                    value = min + (max - min) * math.clamp(relativeX, 0, 1)
                    value = math.floor(value * 100) / 100
                else
                    value = math.floor(min + (max - min) * math.clamp(relativeX, 0, 1))
                end
                
                fill.Size = UDim2.new(math.clamp(relativeX, 0, 1), 0, 1, 0)
                handle.Position = UDim2.new(math.clamp(relativeX, 0, 1), -6, 0.5, -6
                valueLabel.Text = tostring(value) .. unit
                
                callback(value)
            end
            
            track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    updateValue(input)
                end
            end)
            
            track.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateValue(input)
                end
            end)
            
            -- Animation on creation
            sliderFrame.Size = UDim2.new(1, 0, 0, 0)
            Tween(sliderFrame, {Size = UDim2.new(1, 0, 0, 60)}, 0.2)
            
            return {
                SetValue = function(self, value)
                    value = math.clamp(value, min, max)
                    fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
                    handle.Position = UDim2.new((value - min) / (max - min), -6, 0.5, -6
                    valueLabel.Text = tostring(value) .. unit
                    callback(value)
                end
            }
        end
        
        -- Premium Toggle
        function tab:Toggle(options)
            options = options or {}
            local name = options.Name or "Toggle"
            local default = options.Default or false
            local callback = options.Callback or function() end
            local locked = options.Locked or false
            
            local toggleFrame = CreateInstance("Frame", {
                Parent = tabContent,
                Name = name .. "ToggleFrame",
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundColor3 = self.CurrentTheme.Secondary,
                BorderSizePixel = 0,
                ZIndex = 2
            })
            
            local toggleCorner = CreateInstance("UICorner", {
                Parent = toggleFrame,
                CornerRadius = UDim.new(0, 5)
            })
            
            local titleLabel = CreateInstance("TextLabel", {
                Parent = toggleFrame,
                Name = "Title",
                Size = UDim2.new(1, -50, 1, 0),
                BackgroundTransparency = 1,
                Text = name,
                TextColor3 = self.CurrentTheme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                ZIndex = 2
            })
            
            local toggleButton = CreateInstance("Frame", {
                Parent = toggleFrame,
                Name = "Toggle",
                Size = UDim2.new(0, 40, 0, 20),
                Position = UDim2.new(1, -45, 0.5, -10),
                BackgroundColor3 = default and self.CurrentTheme.Accent or self.CurrentTheme.Secondary,
                BorderSizePixel = 0,
                ZIndex = 2
            })
            
            local toggleCorner2 = CreateInstance("UICorner", {
                Parent = toggleButton,
                CornerRadius = UDim.new(1, 0)
            })
            
            local toggleCircle = CreateInstance("Frame", {
                Parent = toggleButton,
                Name = "Circle",
                Size = UDim2.new(0, 16, 0, 16),
                Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                ZIndex = 3
            })
            
            local circleCorner = CreateInstance("UICorner", {
                Parent = toggleCircle,
                CornerRadius = UDim.new(1, 0)
            })
            
            local circleShadow = CreateInstance("ImageLabel", {
                Parent = toggleCircle,
                Name = "Shadow",
                Size = UDim2.new(1, 6, 1, 6),
                Position = UDim2.new(0, -3, 0, -3),
                BackgroundTransparency = 1,
                Image = "rbxassetid://1316045217",
                ImageColor3 = Color3.fromRGB(0, 0, 0),
                ImageTransparency = 0.8,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(10, 10, 118, 118),
                ZIndex = 2
            })
            
            local state = default
            
            local function updateToggle()
                if state then
                    Tween(toggleButton, {BackgroundColor3 = self.CurrentTheme.Accent})
                    Tween(toggleCircle, {Position = UDim2.new(1, -18, 0.5, -8)})
                else
                    Tween(toggleButton, {BackgroundColor3 = self.CurrentTheme.Secondary})
                    Tween(toggleCircle, {Position = UDim2.new(0, 2, 0.5, -8)})
                end
                callback(state)
            end
            
            toggleButton.MouseButton1Click:Connect(function()
                if not locked then
                    state = not state
                    updateToggle()
                    RippleEffect(toggleButton, UserInputService:GetMouseLocation())
                end
            end)
            
            -- Set initial state
            updateToggle()
            
            -- Animation on creation
            toggleFrame.Size = UDim2.new(1, 0, 0, 0)
            Tween(toggleFrame, {Size = UDim2.new(1, 0, 0, 35)}, 0.2)
            
            return {
                SetState = function(self, newState)
                    if not locked then
                        state = newState
                        updateToggle()
                    end
                end,
                GetState = function(self)
                    return state
                end,
                Lock = function(self)
                    locked = true
                end,
                Unlock = function(self)
                    locked = false
                end
            }
        end
        
        -- Premium Dropdown
        function tab:Dropdown(options)
            options = options or {}
            local name = options.Name or "Dropdown"
            local items = options.Items or {"Option 1", "Option 2", "Option 3"}
            local default = options.Default or 1
            local callback = options.Callback or function() end
            local search = options.Search or false
            
            local dropdownFrame = CreateInstance("Frame", {
                Parent = tabContent,
                Name = name .. "DropdownFrame",
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundColor3 = self.CurrentTheme.Secondary,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                ZIndex = 2
            })
            
            local dropdownCorner = CreateInstance("UICorner", {
                Parent = dropdownFrame,
                CornerRadius = UDim.new(0, 5)
            })
            
            local titleLabel = CreateInstance("TextLabel", {
                Parent = dropdownFrame,
                Name = "Title",
                Size = UDim2.new(1, -40, 1, 0),
                BackgroundTransparency = 1,
                Text = name,
                TextColor3 = self.CurrentTheme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                ZIndex = 2
            })
            
            local selectedLabel = CreateInstance("TextLabel", {
                Parent = dropdownFrame,
                Name = "Selected",
                Size = UDim2.new(0, 100, 1, 0),
                Position = UDim2.new(1, -105, 0, 0),
                BackgroundTransparency = 1,
                Text = items[default] or "",
                TextColor3 = self.CurrentTheme.Text,
                TextXAlignment = Enum.TextXAlignment.Right,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                ZIndex = 2
            })
            
            local arrow = CreateInstance("ImageLabel", {
                Parent = dropdownFrame,
                Name = "Arrow",
                Size = UDim2.new(0, 15, 0, 15),
                Position = UDim2.new(1, -20, 0.5, -7.5),
                BackgroundTransparency = 1,
                Image = "rbxassetid://9607705595",
                ImageColor3 = self.CurrentTheme.Text,
                Rotation = 0,
                ZIndex = 2
            })
            
            local itemsFrame = CreateInstance("Frame", {
                Parent = dropdownFrame,
                Name = "Items",
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 1, 5),
                BackgroundColor3 = self.CurrentTheme.Secondary,
                BorderSizePixel = 0,
                Visible = false,
                ZIndex = 5
            })
            
            local itemsCorner = CreateInstance("UICorner", {
                Parent = itemsFrame,
                CornerRadius = UDim.new(0, 5)
            })
            
            local itemsListLayout = CreateInstance("UIListLayout", {
                Parent = itemsFrame,
                SortOrder = Enum.SortOrder.LayoutOrder
            })
            
            local itemsPadding = CreateInstance("UIPadding", {
                Parent = itemsFrame,
                PaddingTop = UDim.new(0, 5),
                PaddingBottom = UDim.new(0, 5)
            })
            
            -- Search box (if enabled)
            local searchBox
            if search then
                searchBox = CreateInstance("TextBox", {
                    Parent = itemsFrame,
                    Name = "SearchBox",
                    Size = UDim2.new(1, -10, 0, 25),
                    Position = UDim2.new(0, 5, 0, 0),
                    BackgroundColor3 = self.CurrentTheme.Main,
                    BorderSizePixel = 0,
                    Text = "",
                    PlaceholderText = "Search...",
                    TextColor3 = self.CurrentTheme.Text,
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    ZIndex = 5
                })
                
                local searchBoxCorner = CreateInstance("UICorner", {
                    Parent = searchBox,
                    CornerRadius = UDim.new(0, 5)
                })
                
                local searchPadding = CreateInstance("UIPadding", {
                    Parent = searchBox,
                    PaddingLeft = UDim.new(0, 5)
                })
            end
            
            local opened = false
            local allItems = {}
            
            local function toggleDropdown()
                opened = not opened
                
                if opened then
                    itemsFrame.Visible = true
                    Tween(itemsFrame, {Size = UDim2.new(1, 0, 0, math.min(#items * 25 + (search and 30 or 0), 150))}, 0.2)
                    Tween(arrow, {Rotation = 180}, 0.2)
                else
                    Tween(itemsFrame, {Size = UDim2.new(1, 0, 0, 0)}, 0.2).Completed:Connect(function()
                        itemsFrame.Visible = false
                    end)
                    Tween(arrow, {Rotation = 0}, 0.2)
                end
            end
            
            dropdownFrame.MouseButton1Click:Connect(toggleDropdown)
            
            local function createItem(i, item)
                local itemButton = CreateInstance("TextButton", {
                    Parent = itemsFrame,
                    Name = "Item" .. i,
                    Size = UDim2.new(1, -10, 0, 25),
                    Position = UDim2.new(0, 5, 0, (search and 30 or 0) + (i-1)*25),
                    BackgroundColor3 = self.CurrentTheme.Main,
                    BorderSizePixel = 0,
                    Text = "  " .. item,
                    TextColor3 = self.CurrentTheme.Text,
                    Font = Enum.Font.Gotham,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 5
                })
                
                local itemCorner = CreateInstance("UICorner", {
                    Parent = itemButton,
                    CornerRadius = UDim.new(0, 5)
                })
                
                itemButton.MouseEnter:Connect(function()
                    Tween(itemButton, {BackgroundColor3 = Color3.fromRGB(
                        self.CurrentTheme.Main.R * 255 + 15,
                        self.CurrentTheme.Main.G * 255 + 15,
                        self.CurrentTheme.Main.B * 255 + 15
                    )})
                end)
                
                itemButton.MouseLeave:Connect(function()
                    Tween(itemButton, {BackgroundColor3 = self.CurrentTheme.Main})
                end)
                
                itemButton.MouseButton1Click:Connect(function()
                    selectedLabel.Text = item
                    callback(i, item)
                    toggleDropdown()
                    RippleEffect(itemButton, UserInputService:GetMouseLocation())
                end)
                
                table.insert(allItems, {
                    Button = itemButton,
                    Text = item,
                    Index = i
                })
            end
            
            -- Create dropdown items
            for i, item in ipairs(items) do
                createItem(i, item)
            end
            
            -- Search functionality
            if search then
                searchBox:GetPropertyChangedSignal("Text"):Connect(function()
                    local searchText = string.lower(searchBox.Text)
                    
                    for _, itemData in ipairs(allItems) do
                        if string.find(string.lower(itemData.Text), searchText, 1, true) then
                            itemData.Button.Visible = true
                        else
                            itemData.Button.Visible = false
                        end
                    end
                end)
            end
            
            -- Animation on creation
            dropdownFrame.Size = UDim2.new(1, 0, 0, 0)
            Tween(dropdownFrame, {Size = UDim2.new(1, 0, 0, 35)}, 0.2)
            
            return {
                SetSelected = function(self, index)
                    if items[index] then
                        selectedLabel.Text = items[index]
                        callback(index, items[index])
                    end
                end,
                GetSelected = function(self)
                    return selectedLabel.Text
                end,
                AddItem = function(self, item)
                    table.insert(items, item)
                    createItem(#items, item)
                end,
                RemoveItem = function(self, index)
                    if items[index] then
                        table.remove(items, index)
                        allItems[index].Button:Destroy()
                        table.remove(allItems, index)
                        
                        -- Recreate all items to fix indices
                        for i, item in ipairs(allItems) do
                            item.Button:Destroy()
                        end
                        allItems = {}
                        
                        for i, item in ipairs(items) do
                            createItem(i, item)
                        end
                    end
                end
            }
        end
        
        -- Premium Checkbox
        function tab:Checkbox(options)
            options = options or {}
            local name = options.Name or "Checkbox"
            local default = options.Default or false
            local callback = options.Callback or function() end
            
            local checkboxFrame = CreateInstance("Frame", {
                Parent = tabContent,
                Name = name .. "CheckboxFrame",
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundColor3 = self.CurrentTheme.Secondary,
                BorderSizePixel = 0,
                ZIndex = 2
            })
            
            local checkboxCorner = CreateInstance("UICorner", {
                Parent = checkboxFrame,
                CornerRadius = UDim.new(0, 5)
            })
            
            local titleLabel = CreateInstance("TextLabel", {
                Parent = checkboxFrame,
                Name = "Title",
                Size = UDim2.new(1, -40, 1, 0),
                BackgroundTransparency = 1,
                Text = name,
                TextColor3 = self.CurrentTheme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                ZIndex = 2
            })
            
            local checkboxButton = CreateInstance("Frame", {
                Parent = checkboxFrame,
                Name = "Checkbox",
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(1, -30, 0.5, -10),
                BackgroundColor3 = self.CurrentTheme.Secondary,
                BorderColor3 = self.CurrentTheme.Text,
                BorderSizePixel = 1,
                ZIndex = 2
            })
            
            local checkmark = CreateInstance("ImageLabel", {
                Parent = checkboxButton,
                Name = "Checkmark",
                Size = UDim2.new(1, -4, 1, -4),
                Position = UDim2.new(0, 2, 0, 2),
                BackgroundTransparency = 1,
                Image = "rbxassetid://9607705595",
                ImageColor3 = self.CurrentTheme.Accent,
                Visible = default,
                ZIndex = 3
            })
            
            local state = default
            
            local function updateCheckbox()
                checkmark.Visible = state
                callback(state)
            end
            
            checkboxButton.MouseButton1Click:Connect(function()
                state = not state
                updateCheckbox()
                RippleEffect(checkboxButton, UserInputService:GetMouseLocation())
            end)
            
            -- Animation on creation
            checkboxFrame.Size = UDim2.new(1, 0, 0, 0)
            Tween(checkboxFrame, {Size = UDim2.new(1, 0, 0, 35)}, 0.2)
            
            return {
                SetState = function(self, newState)
                    state = newState
                    updateCheckbox()
                end,
                GetState = function(self)
                    return state
                end
            }
        end
        
        -- Premium Keybind
        function tab:Bind(options)
            options = options or {}
            local name = options.Name or "Bind"
            local default = options.Default or Enum.KeyCode.E
            local callback = options.Callback or function() end
            local hold = options.Hold or false
            
            local bindFrame = CreateInstance("Frame", {
                Parent = tabContent,
                Name = name .. "BindFrame",
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundColor3 = self.CurrentTheme.Secondary,
                BorderSizePixel = 0,
                ZIndex = 2
            })
            
            local bindCorner = CreateInstance("UICorner", {
                Parent = bindFrame,
                CornerRadius = UDim.new(0, 5)
            })
            
            local titleLabel = CreateInstance("TextLabel", {
                Parent = bindFrame,
                Name = "Title",
                Size = UDim2.new(1, -90, 1, 0),
                BackgroundTransparency = 1,
                Text = name,
                TextColor3 = self.CurrentTheme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                ZIndex = 2
            })
            
            local bindButton = CreateInstance("TextButton", {
                Parent = bindFrame,
                Name = "BindButton",
                Size = UDim2.new(0, 80, 0, 25),
                Position = UDim2.new(1, -85, 0.5, -12.5),
                BackgroundColor3 = self.CurrentTheme.Main,
                BorderSizePixel = 0,
                Text = default.Name,
                TextColor3 = self.CurrentTheme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                ZIndex = 2
            })
            
            local bindButtonCorner = CreateInstance("UICorner", {
                Parent = bindButton,
                CornerRadius = UDim.new(0, 5)
            })
            
            local currentKey = default
            local listening = false
            local holding = false
            
            local function setKey(key)
                currentKey = key
                bindButton.Text = key.Name
            end
            
            bindButton.MouseButton1Click:Connect(function()
                listening = true
                bindButton.Text = "..."
                bindButton.BackgroundColor3 = self.CurrentTheme.Accent
            end)
            
            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if listening and not gameProcessed then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        setKey(input.KeyCode)
                    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                        setKey(Enum.KeyCode.MouseButton1)
                    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                        setKey(Enum.KeyCode.MouseButton2)
                    elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
                        setKey(Enum.KeyCode.MouseButton3)
                    end
                    
                    listening = false
                    bindButton.BackgroundColor3 = self.CurrentTheme.Main
                    RippleEffect(bindButton, UserInputService:GetMouseLocation())
                elseif not listening and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentKey then
                    if hold then
                        holding = true
                        callback(true)
                    else
                        callback()
                    end
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input, gameProcessed)
                if hold and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentKey then
                    holding = false
                    callback(false)
                end
            end)
            
            -- Animation on creation
            bindFrame.Size = UDim2.new(1, 0, 0, 0)
            Tween(bindFrame, {Size = UDim2.new(1, 0, 0, 35)}, 0.2)
            
            return {
                SetKey = function(self, key)
                    setKey(key)
                end,
                GetKey = function(self)
                    return currentKey
                end,
                IsHolding = function(self)
                    return holding
                end
            }
        end
        
        -- Premium Textbox
        function tab:Textbox(options)
            options = options or {}
            local name = options.Name or "Textbox"
            local default = options.Default or ""
            local placeholder = options.Placeholder or "Type here..."
            local callback = options.Callback or function() end
            local numeric = options.Numeric or false
            
            local textboxFrame = CreateInstance("Frame", {
                Parent = tabContent,
                Name = name .. "TextboxFrame",
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundColor3 = self.CurrentTheme.Secondary,
                BorderSizePixel = 0,
                ZIndex = 2
            })
            
            local textboxCorner = CreateInstance("UICorner", {
                Parent = textboxFrame,
                CornerRadius = UDim.new(0, 5)
            })
            
            local titleLabel = CreateInstance("TextLabel", {
                Parent = textboxFrame,
                Name = "Title",
                Size = UDim2.new(1, -10, 0, 15),
                Position = UDim2.new(0, 10, 0, 5),
                BackgroundTransparency = 1,
                Text = name,
                TextColor3 = self.CurrentTheme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                ZIndex = 2
            })
            
            local textbox = CreateInstance("TextBox", {
                Parent = textboxFrame,
                Name = "Textbox",
                Size = UDim2.new(1, -20, 0, 20),
                Position = UDim2.new(0, 10, 0, 20),
                BackgroundColor3 = self.CurrentTheme.Main,
                BorderSizePixel = 0,
                Text = default,
                PlaceholderText = placeholder,
                TextColor3 = self.CurrentTheme.Text,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                ClearTextOnFocus = false,
                ZIndex = 2
            })
            
            local textboxPadding = CreateInstance("UIPadding", {
                Parent = textbox,
                PaddingLeft = UDim.new(0, 5),
                PaddingRight = UDim.new(0, 5)
            })
            
            if numeric then
                textbox.Text = tonumber(default) and tostring(default) or ""
                
                textbox:GetPropertyChangedSignal("Text"):Connect(function()
                    local text = textbox.Text
                    if text == "" then return end
                    
                    if not tonumber(text) then
                        textbox.Text = string.gsub(text, "[^%d.]", "")
                    end
                end)
            end
            
            textbox.FocusLost:Connect(function()
                callback(textbox.Text)
            end)
            
            -- Animation on creation
            textboxFrame.Size = UDim2.new(1, 0, 0, 0)
            Tween(textboxFrame, {Size = UDim2.new(1, 0, 0, 35)}, 0.2)
            
            return {
                SetText = function(self, text)
                    textbox.Text = text
                end,
                GetText = function(self)
                    return textbox.Text
                end
            }
        end
        
        return tab
    end
    
    return window
end

return FastyUI
