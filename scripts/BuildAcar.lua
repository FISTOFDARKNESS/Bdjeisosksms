local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local function createModernMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = " "
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 9999
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 250, 0, 200)
    mainFrame.Position = UDim2.new(0.5, -125, 0.5, -100)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame

    local stroke = Instance.new("UIStroke")
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(80, 80, 100)
    stroke.Thickness = 2
    stroke.Parent = mainFrame

    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = titleBar

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(0.8, 0, 1, 0)
    title.Position = UDim2.new(0.1, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Build a car "
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 14
    title.Font = Enum.Font.GothamBold
    title.Parent = titleBar

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 14
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = titleBar

    local teleportToggleFrame = Instance.new("Frame")
    teleportToggleFrame.Name = "TeleportToggleFrame"
    teleportToggleFrame.Size = UDim2.new(1, -20, 0, 30)
    teleportToggleFrame.Position = UDim2.new(0, 10, 0, 40)
    teleportToggleFrame.BackgroundTransparency = 1
    teleportToggleFrame.Parent = mainFrame

    local teleportToggleLabel = Instance.new("TextLabel")
    teleportToggleLabel.Name = "TeleportToggleLabel"
    teleportToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    teleportToggleLabel.BackgroundTransparency = 1
    teleportToggleLabel.Text = "Auto Farm"
    teleportToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    teleportToggleLabel.TextSize = 14
    teleportToggleLabel.Font = Enum.Font.Gotham
    teleportToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    teleportToggleLabel.Parent = teleportToggleFrame

    local teleportToggleButton = Instance.new("TextButton")
    teleportToggleButton.Name = "TeleportToggleButton"
    teleportToggleButton.Size = UDim2.new(0, 50, 0, 25)
    teleportToggleButton.Position = UDim2.new(1, -50, 0.5, -12)
    teleportToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    teleportToggleButton.Text = ""
    teleportToggleButton.Parent = teleportToggleFrame

    local teleportToggleCorner = Instance.new("UICorner")
    teleportToggleCorner.CornerRadius = UDim.new(0, 12)
    teleportToggleCorner.Parent = teleportToggleButton

    local teleportToggleInner = Instance.new("Frame")
    teleportToggleInner.Name = "TeleportToggleInner"
    teleportToggleInner.Size = UDim2.new(0, 21, 0, 21)
    teleportToggleInner.Position = UDim2.new(0, 2, 0.5, -10)
    teleportToggleInner.BackgroundColor3 = Color3.fromRGB(255, 150, 100)
    teleportToggleInner.Parent = teleportToggleButton

    local teleportToggleInnerCorner = Instance.new("UICorner")
    teleportToggleInnerCorner.CornerRadius = UDim.new(0, 10)
    teleportToggleInnerCorner.Parent = teleportToggleInner

    local loadstringToggleFrame = Instance.new("Frame")
    loadstringToggleFrame.Name = "LoadstringToggleFrame"
    loadstringToggleFrame.Size = UDim2.new(1, -20, 0, 30)
    loadstringToggleFrame.Position = UDim2.new(0, 10, 0, 80)
    loadstringToggleFrame.BackgroundTransparency = 1
    loadstringToggleFrame.Parent = mainFrame

    local loadstringToggleLabel = Instance.new("TextLabel")
    loadstringToggleLabel.Name = "LoadstringToggleLabel"
    loadstringToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    loadstringToggleLabel.BackgroundTransparency = 1
    loadstringToggleLabel.Text = "Auto Buy Items Shop"
    loadstringToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadstringToggleLabel.TextSize = 14
    loadstringToggleLabel.Font = Enum.Font.Gotham
    loadstringToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    loadstringToggleLabel.Parent = loadstringToggleFrame

    local loadstringToggleButton = Instance.new("TextButton")
    loadstringToggleButton.Name = "LoadstringToggleButton"
    loadstringToggleButton.Size = UDim2.new(0, 50, 0, 25)
    loadstringToggleButton.Position = UDim2.new(1, -50, 0.5, -12)
    loadstringToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    loadstringToggleButton.Text = ""
    loadstringToggleButton.Parent = loadstringToggleFrame

    local loadstringToggleCorner = Instance.new("UICorner")
    loadstringToggleCorner.CornerRadius = UDim.new(0, 12)
    loadstringToggleCorner.Parent = loadstringToggleButton

    local loadstringToggleInner = Instance.new("Frame")
    loadstringToggleInner.Name = "LoadstringToggleInner"
    loadstringToggleInner.Size = UDim2.new(0, 21, 0, 21)
    loadstringToggleInner.Position = UDim2.new(0, 2, 0.5, -10)
    loadstringToggleInner.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
    loadstringToggleInner.Parent = loadstringToggleButton

    local loadstringToggleInnerCorner = Instance.new("UICorner")
    loadstringToggleInnerCorner.CornerRadius = UDim.new(0, 10)
    loadstringToggleInnerCorner.Parent = loadstringToggleInner

    local loadstringButton = Instance.new("TextButton")
    loadstringButton.Name = "LoadstringButton"
    loadstringButton.Size = UDim2.new(1, -20, 0, 30)
    loadstringButton.Position = UDim2.new(0, 10, 0, 120)
    loadstringButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    loadstringButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadstringButton.Text = "Build a simple car"
    loadstringButton.TextSize = 14
    loadstringButton.Font = Enum.Font.Gotham
    loadstringButton.Parent = mainFrame

    local loadstringButtonCorner = Instance.new("UICorner")
    loadstringButtonCorner.CornerRadius = UDim.new(0, 4)
    loadstringButtonCorner.Parent = loadstringButton

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Size = UDim2.new(1, -20, 0, 20)
    statusLabel.Position = UDim2.new(0, 10, 1, -30)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Status: Inactive"
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusLabel.TextSize = 12
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = mainFrame

    local teleportEnabled = false
    local loadstringPeriodicEnabled = false
    local teleportThread = nil
    local loadstringThread = nil

    local function updateTeleportToggle()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        if teleportEnabled then
            local tween = TweenService:Create(teleportToggleInner, tweenInfo, {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(100, 255, 150)})
            tween:Play()
        else
            local tween = TweenService:Create(teleportToggleInner, tweenInfo, {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 100, 100)})
            tween:Play()
        end
    end

    local function updateLoadstringToggle()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        if loadstringPeriodicEnabled then
            local tween = TweenService:Create(loadstringToggleInner, tweenInfo, {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(100, 255, 150)})
            tween:Play()
        else
            local tween = TweenService:Create(loadstringToggleInner, tweenInfo, {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 100, 100)})
            tween:Play()
        end
    end

    local function startTeleportLoop()
        if teleportThread then
            task.cancel(teleportThread)
            teleportThread = nil
        end

        teleportThread = task.spawn(function()
            while teleportEnabled do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    statusLabel.Text = "Status: Spawning vehicle..."
                    
                    pcall(function()
                        workspace:WaitForChild("__THINGS"):WaitForChild("__REMOTES"):WaitForChild("vehicle_spawn"):InvokeServer()
                    end)
                    
                    task.wait(1)
                    
                    statusLabel.Text = "Status: Teleporting..."
                    
                    local humanoidRootPart = player.Character.HumanoidRootPart
                    local startTime = tick()

                    while tick() - startTime < 15 and teleportEnabled do
                        humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 500000, 500000)
                        task.wait(0.1)
                    end

                    statusLabel.Text = "Status: Stopping vehicle..."
                    
                    pcall(function()
                        workspace:WaitForChild("__THINGS"):WaitForChild("__REMOTES"):WaitForChild("vehicle_stop"):InvokeServer()
                    end)

                    task.wait(1)
                else
                    statusLabel.Text = "Status: Character not found!"
                    teleportEnabled = false
                    updateTeleportToggle()
                end
            end

            statusLabel.Text = "Status: Teleport finished"
            teleportEnabled = false
            updateTeleportToggle()
        end)
    end

    teleportToggleButton.MouseButton1Click:Connect(function()
        teleportEnabled = not teleportEnabled
        updateTeleportToggle()
        statusLabel.Text = "Status: Teleport " .. (teleportEnabled and "Enabled" or "Disabled")
        
        if teleportEnabled then
            startTeleportLoop()
        elseif teleportThread then
            task.cancel(teleportThread)
            teleportThread = nil
        end
    end)

    local function startLoadstringLoop()
        if loadstringThread then
            task.cancel(loadstringThread)
            loadstringThread = nil
        end

        loadstringThread = task.spawn(function()
            while loadstringPeriodicEnabled do
                statusLabel.Text = "Status: Executing Loadstring..."
                pcall(function()
                    loadstring(game:HttpGet("https://pastebin.com/raw/Cxh96exZ"))()
                end)
                statusLabel.Text = "Status: Loadstring executed!"
                task.wait(10)
            end
            statusLabel.Text = "Status: Loadstring finished"
        end)
    end

    loadstringToggleButton.MouseButton1Click:Connect(function()
        loadstringPeriodicEnabled = not loadstringPeriodicEnabled
        updateLoadstringToggle()
        statusLabel.Text = "Status: Periodic Loadstring " .. (loadstringPeriodicEnabled and "Enabled" or "Disabled")
        
        if loadstringPeriodicEnabled then
            startLoadstringLoop()
        elseif loadstringThread then
            task.cancel(loadstringThread)
            loadstringThread = nil
        end
    end)

    loadstringButton.MouseButton1Click:Connect(function()
        statusLabel.Text = "Status: Executing Loadstring..."
        pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/Da0bg6E1"))()
        end)
        statusLabel.Text = "Status: Loadstring executed!"
    end)

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        if teleportThread then
            task.cancel(teleportThread)
        end
        if loadstringThread then
            task.cancel(loadstringThread)
        end
    end)

    local dragging
    local dragInput
    local dragStart
    local startPos

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
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
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    updateTeleportToggle()
    updateLoadstringToggle()

    return {
        updateStatus = function(text)
            statusLabel.Text = "Status: " .. text
        end,
        getTeleportEnabled = function()
            return teleportEnabled
        end,
        getLoadstringPeriodicEnabled = function()
            return loadstringPeriodicEnabled
        end
    }
end

local menu = createModernMenu()
