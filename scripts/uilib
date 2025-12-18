local ZoUI = {}

ZoUI.Theme = {
    Primary = Color3.fromRGB(30, 30, 40),
    Secondary = Color3.fromRGB(40, 40, 50),
    Accent = Color3.fromRGB(120, 81, 169),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(200, 200, 200),
    ToggleOff = Color3.fromRGB(255, 100, 100),
    ToggleOn = Color3.fromRGB(100, 255, 100),
    Button = Color3.fromRGB(60, 60, 70),
    Stroke = Color3.fromRGB(80, 80, 100)
}
ZoUI.Font = Enum.Font.Gotham
ZoUI.FontBold = Enum.Font.GothamBold

function ZoUI:Create(className, properties)
    local obj = Instance.new(className)
    for prop, value in pairs(properties) do
        obj[prop] = value
    end
    return obj
end

function ZoUI:CreateWindow(options)
    options = options or {}
    local title = options.Title or "ZoUI Menu"
    local size = options.Size or UDim2.new(0, 300, 0, 400)
    local position = options.Position or UDim2.new(0.5, -150, 0.5, -200)
    
    local screenGui = ZoUI:Create("ScreenGui", {
        Name = "ZoUI_" .. title:gsub("%s+", ""),
        Parent = game:GetService("CoreGui"),
        ResetOnSpawn = false,
        DisplayOrder = 9999,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    
    local mainFrame = ZoUI:Create("Frame", {
        Name = "MainFrame",
        Size = size,
        Position = position,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = ZoUI.Theme.Primary,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = screenGui
    })
    ZoUI:Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = mainFrame})
    ZoUI:Create("UIStroke", {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = ZoUI.Theme.Stroke,
        Thickness = 2,
        Parent = mainFrame
    })
    
    local titleBar = ZoUI:Create("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = ZoUI.Theme.Secondary,
        BorderSizePixel = 0,
        Parent = mainFrame
    })
    ZoUI:Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = titleBar})
    
    local titleLabel = ZoUI:Create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(0.8, 0, 1, 0),
        Position = UDim2.new(0.1, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = ZoUI.Theme.Text,
        TextSize = 18,
        Font = ZoUI.FontBold,
        Parent = titleBar
    })
    
    local closeButton = ZoUI:Create("TextButton", {
        Name = "CloseButton",
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(1, -40, 0, 0),
        BackgroundTransparency = 1,
        Text = "X",
        TextColor3 = ZoUI.Theme.Text,
        TextSize = 18,
        Font = ZoUI.FontBold,
        Parent = titleBar
    })
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    local tabContainer = ZoUI:Create("Frame", {
        Name = "TabContainer",
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 50),
        BackgroundTransparency = 1,
        Parent = mainFrame
    })
    
    local contentFrame = ZoUI:Create("Frame", {
        Name = "ContentFrame",
        Size = UDim2.new(1, -20, 0, size.Y.Offset - 110),
        Position = UDim2.new(0, 10, 0, 90),
        BackgroundTransparency = 1,
        Parent = mainFrame
    })
    
    local statusLabel = ZoUI:Create("TextLabel", {
        Name = "StatusLabel",
        Size = UDim2.new(1, -20, 0, 20),
        Position = UDim2.new(0, 10, 1, -30),
        BackgroundTransparency = 1,
        Text = "Status: Ready",
        TextColor3 = ZoUI.Theme.SubText,
        TextSize = 8,
        Font = ZoUI.Font,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = mainFrame
    })
    
    local window = {
        GUI = screenGui,
        MainFrame = mainFrame,
        Tabs = {},
        CurrentTab = nil,
        Status = statusLabel
    }
    
    function window:SetStatus(text)
        statusLabel.Text = "Status: " .. text
    end
    
    function window:CreateTab(tabName)
        local tabButton = ZoUI:Create("TextButton", {
            Name = tabName .. "TabButton",
            Size = UDim2.new(0, 80, 1, 0),
            BackgroundColor3 = #window.Tabs == 0 and ZoUI.Theme.Accent or ZoUI.Theme.Button,
            Text = tabName,
            TextColor3 = ZoUI.Theme.Text,
            TextSize = 14,
            Font = #window.Tabs == 0 and ZoUI.FontBold or ZoUI.Font,
            Parent = tabContainer
        })
        ZoUI:Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = tabButton})
        
        local tabContent = ZoUI:Create("ScrollingFrame", {
            Name = tabName .. "Content",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 0,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = #window.Tabs == 0,
            Parent = contentFrame
        })
        local listLayout = ZoUI:Create("UIListLayout", {
            Padding = UDim.new(0, 10),
            Parent = tabContent
        })
        
        local tab = {
            Name = tabName,
            Button = tabButton,
            Content = tabContent,
            Elements = {}
        }
        
        tabButton.MouseButton1Click:Connect(function()
            for _, otherTab in pairs(window.Tabs) do
                otherTab.Content.Visible = false
                otherTab.Button.BackgroundColor3 = ZoUI.Theme.Button
                otherTab.Button.Font = ZoUI.Font
            end
            tabContent.Visible = true
            tabButton.BackgroundColor3 = ZoUI.Theme.Accent
            tabButton.Font = ZoUI.FontBold
            window.CurrentTab = tab
        end)
        
        table.insert(window.Tabs, tab)
        if #window.Tabs == 1 then
            window.CurrentTab = tab
        end
        
        for i, t in ipairs(window.Tabs) do
            t.Button.Position = UDim2.new(0, (i-1)*85, 0, 0)
        end
        
        return tab
    end
    
    function tab:AddLabel(text, options)
        options = options or {}
        local labelFrame = ZoUI:Create("Frame", {
            Name = "LabelFrame",
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1,
            Parent = ZoUI.Content
        })
        local label = ZoUI:Create("TextLabel", {
            Name = "Label",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = text,
            TextColor3 = options.Color or ZoUI.Theme.Text,
            TextSize = options.Size or 14,
            Font = options.Bold and ZoUI.FontBold or ZoUI.Font,
            TextXAlignment = options.Alignment or Enum.TextXAlignment.Left,
            Parent = labelFrame
        })
        table.insert(ZoUI.Elements, labelFrame)
        return labelFrame
    end
    
    function tab:AddButton(text, callback, options)
        options = options or {}
        local button = ZoUI:Create("TextButton", {
            Name = text .. "Button",
            Size = UDim2.new(1, 0, 0, 35),
            BackgroundColor3 = options.Color or ZoUI.Theme.Button,
            Text = text,
            TextColor3 = ZoUI.Theme.Text,
            TextSize = 14,
            Font = ZoUI.FontBold,
            Parent = ZoUI.Content
        })
        ZoUI:Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = button})
        button.MouseButton1Click:Connect(callback)
        table.insert(ZoUI.Elements, button)
        return button
    end
    
    function tab:AddToggle(text, default, callback, options)
        options = options or {}
        local toggleFrame = ZoUI:Create("Frame", {
            Name = text .. "ToggleFrame",
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundTransparency = 1,
            Parent = ZoUI.Content
        })
        local toggleLabel = ZoUI:Create("TextLabel", {
            Name = text .. "ToggleLabel",
            Size = UDim2.new(0.7, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = text,
            TextColor3 = ZoUI.Theme.Text,
            TextSize = 14,
            Font = ZoUI.Font,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = toggleFrame
        })
        local toggleButton = ZoUI:Create("TextButton", {
            Name = text .. "ToggleButton",
            Size = UDim2.new(0, 50, 0, 25),
            Position = UDim2.new(1, -50, 0.5, -12),
            BackgroundColor3 = ZoUI.Theme.Button,
            Text = "",
            Parent = toggleFrame
        })
        ZoUI:Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = toggleButton})
        local toggleInner = ZoUI:Create("Frame", {
            Name = text .. "ToggleInner",
            Size = UDim2.new(0, 21, 0, 21),
            Position = UDim2.new(0, 2, 0.5, -10),
            BackgroundColor3 = default and ZoUI.Theme.ToggleOn or ZoUI.Theme.ToggleOff,
            Parent = toggleButton
        })
        ZoUI:Create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = toggleInner})
        
        local state = default or false
        toggleButton.MouseButton1Click:Connect(function()
            state = not state
            toggleInner.BackgroundColor3 = state and ZoUI.Theme.ToggleOn or ZoUI.Theme.ToggleOff
            toggleInner.Position = state and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
            if callback then
                callback(state)
            end
        end)
        if default then
            toggleInner.Position = UDim2.new(1, -23, 0.5, -10)
        end
        
        table.insert(ZoUI.Elements, toggleFrame)
        return toggleFrame
    end
    
    function tab:AddTextBox(placeholder, default, callback, options)
        options = options or {}
        local textBoxFrame = ZoUI:Create("Frame", {
            Name = placeholder .. "TextBoxFrame",
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundTransparency = 1,
            Parent = ZoUI.Content
        })
        local textBoxLabel = ZoUI:Create("TextLabel", {
            Name = placeholder .. "TextBoxLabel",
            Size = UDim2.new(0.4, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = placeholder,
            TextColor3 = ZoUI.Theme.Text,
            TextSize = 14,
            Font = ZoUI.Font,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = textBoxFrame
        })
        local textBox = ZoUI:Create("TextBox", {
            Name = placeholder .. "TextBox",
            Size = UDim2.new(0.5, 0, 0.7, 0),
            Position = UDim2.new(0.5, 5, 0.15, 0),
            BackgroundColor3 = ZoUI.Theme.Button,
            TextColor3 = ZoUI.Theme.Text,
            Text = default or "",
            PlaceholderText = placeholder,
            TextSize = 14,
            Font = ZoUI.Font,
            Parent = textBoxFrame
        })
        ZoUI:Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = textBox})
        textBox.FocusLost:Connect(function()
            if callback then
                callback(textBox.Text)
            end
        end)
        table.insert(ZoUI.Elements, textBoxFrame)
        return textBoxFrame
    end
    
    return window
end

return ZoUI
