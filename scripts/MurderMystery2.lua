local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local runservice = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local localPlayer = Players.LocalPlayer
local playerGui = game:GetService("CoreGui")

local uiconfig = {
    MainSize = UDim2.new(0, 400, 0, 400),
    Colors = {
        Background = Color3.fromRGB(30, 30, 40),
        Header = Color3.fromRGB(40, 40, 50),
        RoleFrame = Color3.fromRGB(45, 45, 55),
        Murder = Color3.fromRGB(180, 0, 0),
        Sheriff = Color3.fromRGB(0, 100, 200),
        Button = Color3.fromRGB(60, 60, 70),
        ButtonHover = Color3.fromRGB(80, 80, 90),
        ButtonOn = Color3.fromRGB(60, 60, 70),
        ButtonOff = Color3.fromRGB(60, 60, 70),
        ToggleOn = Color3.fromRGB(100, 255, 150),
        ToggleOff = Color3.fromRGB(255, 100, 100),
        TextBox = Color3.fromRGB(50, 50, 60)
    },
    Icons = {
        Murder = "rbxassetid://0",
        Sheriff = "rbxassetid://0"
    }
}

local Maps = {"ResearchFacility","BioLab","House2","Mansion","MilBase","Yacht","Workplace","PoliceStation","Office3","Hotel","BeachResort","Mansion2","Factory","Bank2"}

local playerHighlights = {}
local playerRoles = {}
local autoCoin = false
local currentTween
local teleportCooldown = 1.2
local lastTeleportUse = 0
local murderUI, sheriffUI = {}, {}
local walkSpeed = 16 
local jumpPower = 50 

local function getSearchModels()
    local models = {}
    for _, name in ipairs(Maps) do
        local model = workspace:FindFirstChild(name)
        if model then
            table.insert(models, model)
        end
    end
    return models
end

local function getClosestPlayer()
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local closestPlayer
    local shortestDistance = math.huge
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= localPlayer and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (otherPlayer.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestPlayer = otherPlayer
            end
        end
    end
    return closestPlayer
end

local function teleportAndAttack()
    if tick() - lastTeleportUse < teleportCooldown then return end
    lastTeleportUse = tick()
    
    local target = getClosestPlayer()
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and
       localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then

        localPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        
        local backpack = localPlayer:WaitForChild("Backpack")
        local knife = backpack:FindFirstChild("Knife") or localPlayer.Character:FindFirstChild("Knife")
        if knife then
            knife.Parent = localPlayer.Character
        end
        
        wait(0.1)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end
end

local function findGunDrop()
    for _, model in ipairs(getSearchModels()) do
        for _, child in ipairs(model:GetDescendants()) do
            if child:IsA("BasePart") and child.Name == "GunDrop" then
                return child
            end
        end
    end
end

local function getPlayerThumbnail(userId)
    local success, result = pcall(function()
        return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
    end)
    return success and result or ""
end

local function setHighlight(player, role)
    if not player.Character then return end
    if player == localPlayer then return end
    
    if playerHighlights[player] then
        playerHighlights[player]:Destroy()
        playerHighlights[player] = nil
    end
    
    local highlight = Instance.new("Highlight")
    highlight.Adornee = player.Character
    highlight.Parent = player.Character
    playerHighlights[player] = highlight
    
    if role == "Murder" then
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.OutlineColor = Color3.fromRGB(173, 0, 0)
    elseif role == "Sheriff" then
        highlight.FillColor = Color3.fromRGB(0, 28, 255)
        highlight.OutlineColor = Color3.fromRGB(9, 0, 173)
    else
        highlight.FillColor = Color3.fromRGB(11, 255, 0)
        highlight.OutlineColor = Color3.fromRGB(28, 183, 0)
    end
    
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Died:Connect(function()
                wait(3)
                if player and player.Character then
                    setHighlight(player, role)
                end
            end)
        end
    end
end

local function removeHighlight(player)
    if playerHighlights[player] then
        playerHighlights[player]:Destroy()
        playerHighlights[player] = nil
    end
end

local function checkRole(player)
    if player == localPlayer then return "Innocent" end
    
    local char = player.Character
    local backpack = player:FindFirstChild("Backpack")
    if not char or not backpack then return "Innocent" end
    
    if char:FindFirstChild("Knife") or backpack:FindFirstChild("Knife") then
        return "Murder"
    elseif char:FindFirstChild("Gun") or backpack:FindFirstChild("Gun") or char:GetAttribute("HasWeapon") then
        return "Sheriff"
    end
    return "Innocent"
end

local function refreshUI()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= localPlayer then
            local role = checkRole(plr)
            if playerRoles[plr] ~= role then
                playerRoles[plr] = role
                setHighlight(plr, role)
            end
        end
    end
    
    local murder, sheriff = nil, nil
    for plr, role in pairs(playerRoles) do
        if role == "Murder" then murder = plr end
        if role == "Sheriff" then sheriff = plr end
    end
    
    if murder then
        murderUI.Image.Image = getPlayerThumbnail(murder.UserId)
        murderUI.NameLabel.Text = murder.Name
    else
        murderUI.Image.Image = ""
        murderUI.NameLabel.Text = "Waiting For a Player"
    end
    
    if sheriff then
        sheriffUI.Image.Image = getPlayerThumbnail(sheriff.UserId)
        sheriffUI.NameLabel.Text = sheriff.Name
    else
        sheriffUI.Image.Image = ""
        sheriffUI.NameLabel.Text = "Waiting For a Player"
    end
end

local function setupPlayer(plr)
    if plr == localPlayer then return end
    
    local function connectChar(char)

        setHighlight(plr, "Innocent")
        
        char.ChildAdded:Connect(function(child)
            wait(0.1)
            refreshUI()
        end)
        char.ChildRemoved:Connect(function(child)
            wait(0.1)
            refreshUI()
        end)
        
        local humanoid = char:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            wait(3)
            if plr and plr.Character then
                setHighlight(plr, checkRole(plr))
            end
        end)
    end
    
    if plr.Character then 
        connectChar(plr.Character) 
    end
    
    plr.CharacterAdded:Connect(function(char)
        connectChar(char)
    end)
    
    local backpack = plr:FindFirstChild("Backpack")
    if backpack then
        backpack.ChildAdded:Connect(function(child)
            wait(0.1)
            refreshUI()
        end)
        backpack.ChildRemoved:Connect(function(child)
            wait(0.1)
            refreshUI()
        end)
    end
    
    refreshUI()
end

local function cleanupPlayer(plr)
    removeHighlight(plr)
    playerRoles[plr] = nil
    refreshUI()
end

local function getNearestCoin()
    local hrp = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local closest, dist = nil, math.huge
    for _, model in ipairs(getSearchModels()) do
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name == "Coin_Server" then
                local d = (obj.Position - hrp.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = obj
                end
            end
        end
    end
    return closest
end

local function updateCharacterSpeed()
    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.WalkSpeed = walkSpeed
    end
end

local function updateCharacterJump()
    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.JumpPower = jumpPower
    end
end

local function createModernMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = " "
    screenGui.Parent = playerGui
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 9999
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = uiconfig.MainSize
    mainFrame.Position = UDim2.new(0.5, -uiconfig.MainSize.X.Offset/2, 0.05, 0)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0)
    mainFrame.BackgroundColor3 = uiconfig.Colors.Background
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
    titleBar.BackgroundColor3 = uiconfig.Colors.Header
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
    title.Text = "Murder Mystery 2"
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

    local function createRoleFrame(parent, roleName, color, iconId, position)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.5, -10, 0, 120)
        frame.Position = position
        frame.BackgroundColor3 = uiconfig.Colors.RoleFrame
        frame.BorderSizePixel = 0
        frame.Parent = parent
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 6)
        frameCorner.Parent = frame

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, 0, 0, 25)
        titleLabel.BackgroundColor3 = color
        titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
        titleLabel.Text = roleName:upper()
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextSize = 14
        titleLabel.Parent = frame
        
        local titleCorner = Instance.new("UICorner")
        titleCorner.CornerRadius = UDim.new(0, 6)
        titleCorner.Parent = titleLabel

        local image = Instance.new("ImageLabel")
        image.Size = UDim2.new(0, 60, 0, 60)
        image.Position = UDim2.new(0.5, -30, 0.5, -10)
        image.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        image.BorderSizePixel = 0
        image.Parent = frame
        
        local imageCorner = Instance.new("UICorner")
        imageCorner.CornerRadius = UDim.new(0, 30)
        imageCorner.Parent = image

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, -10, 0, 20)
        nameLabel.Position = UDim2.new(0, 5, 1, -25)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
        nameLabel.Text = "Nenhum"
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.TextSize = 12
        nameLabel.Parent = frame

        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0, 20, 0, 20)
        icon.Position = UDim2.new(1, -25, 0, 5)
        icon.BackgroundTransparency = 1
        icon.Image = iconId
        icon.Parent = frame

        return {Frame=frame, Image=image, NameLabel=nameLabel, Title=titleLabel}
    end

    murderUI = createRoleFrame(mainFrame, "Murder", uiconfig.Colors.Murder, uiconfig.Icons.Murder, UDim2.new(0, 5, 0, 40))
    sheriffUI = createRoleFrame(mainFrame, "Sheriff", uiconfig.Colors.Sheriff, uiconfig.Icons.Sheriff, UDim2.new(0.5, 5, 0, 40))

    local speedFrame = Instance.new("Frame")
    speedFrame.Name = "SpeedFrame"
    speedFrame.Size = UDim2.new(0.5, -10, 0, 30)
    speedFrame.Position = UDim2.new(0, 5, 0, 170)
    speedFrame.BackgroundTransparency = 1
    speedFrame.Parent = mainFrame

    local speedLabel = Instance.new("TextLabel")
    speedLabel.Name = "SpeedLabel"
    speedLabel.Size = UDim2.new(0.5, 0, 1, 0)
    speedLabel.BackgroundTransparency = 1
    speedLabel.Text = "WalkSpeed:"
    speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedLabel.TextSize = 14
    speedLabel.Font = Enum.Font.Gotham
    speedLabel.TextXAlignment = Enum.TextXAlignment.Left
    speedLabel.Parent = speedFrame

    local spdtxtbox = Instance.new("TextBox")
    spdtxtbox.Name = "spdtxtbox"
    spdtxtbox.Size = UDim2.new(0.5, 0, 1, 0)
    spdtxtbox.Position = UDim2.new(0.5, 0, 0, 0)
    spdtxtbox.BackgroundColor3 = uiconfig.Colors.TextBox
    spdtxtbox.TextColor3 = Color3.fromRGB(255, 255, 255)
    spdtxtbox.Text = tostring(walkSpeed)
    spdtxtbox.TextSize = 14
    spdtxtbox.Font = Enum.Font.Gotham
    spdtxtbox.Parent = speedFrame

    local speedCorner = Instance.new("UICorner")
    speedCorner.CornerRadius = UDim.new(0, 6)
    speedCorner.Parent = spdtxtbox

    local jumpFrame = Instance.new("Frame")
    jumpFrame.Name = "JumpFrame"
    jumpFrame.Size = UDim2.new(0.5, -10, 0, 30)
    jumpFrame.Position = UDim2.new(0.5, 5, 0, 170)
    jumpFrame.BackgroundTransparency = 1
    jumpFrame.Parent = mainFrame

    local jumpLabel = Instance.new("TextLabel")
    jumpLabel.Name = "JumpLabel"
    jumpLabel.Size = UDim2.new(0.5, 0, 1, 0)
    jumpLabel.BackgroundTransparency = 1
    jumpLabel.Text = "JumpPower:"
    jumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    jumpLabel.TextSize = 14
    jumpLabel.Font = Enum.Font.Gotham
    jumpLabel.TextXAlignment = Enum.TextXAlignment.Left
    jumpLabel.Parent = jumpFrame

    local jumpTextBox = Instance.new("TextBox")
    jumpTextBox.Name = "JumpTextBox"
    jumpTextBox.Size = UDim2.new(0.5, 0, 1, 0)
    jumpTextBox.Position = UDim2.new(0.5, 0, 0, 0)
    jumpTextBox.BackgroundColor3 = uiconfig.Colors.TextBox
    jumpTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    jumpTextBox.Text = tostring(jumpPower)
    jumpTextBox.TextSize = 14
    jumpTextBox.Font = Enum.Font.Gotham
    jumpTextBox.Parent = jumpFrame

    local jumpCorner = Instance.new("UICorner")
    jumpCorner.CornerRadius = UDim.new(0, 6)
    jumpCorner.Parent = jumpTextBox

    local gunDropButton = Instance.new("TextButton")
    gunDropButton.Name = "GunDropButton"
    gunDropButton.Size = UDim2.new(1, -20, 0, 30)
    gunDropButton.Position = UDim2.new(0, 10, 0, 210)
    gunDropButton.BackgroundColor3 = uiconfig.Colors.Button
    gunDropButton.TextColor3 = Color3.fromRGB(255,255,255)
    gunDropButton.Text = "Teleport to Gun"
    gunDropButton.Font = Enum.Font.GothamBold
    gunDropButton.TextSize = 14
    gunDropButton.Parent = mainFrame
    
    local gunDropCorner = Instance.new("UICorner")
    gunDropCorner.CornerRadius = UDim.new(0, 6)
    gunDropCorner.Parent = gunDropButton

    local teleportAttackButton = Instance.new("TextButton")
    teleportAttackButton.Name = "TeleportAttackButton"
    teleportAttackButton.Size = UDim2.new(1, -20, 0, 30)
    teleportAttackButton.Position = UDim2.new(0, 10, 0, 250)
    teleportAttackButton.BackgroundColor3 = uiconfig.Colors.Button
    teleportAttackButton.TextColor3 = Color3.fromRGB(255,255,255)
    teleportAttackButton.Text = "Kill Someone (Only Murder)"
    teleportAttackButton.Font = Enum.Font.GothamBold
    teleportAttackButton.TextSize = 14
    teleportAttackButton.Parent = mainFrame
    
    local teleportAttackCorner = Instance.new("UICorner")
    teleportAttackCorner.CornerRadius = UDim.new(0, 6)
    teleportAttackCorner.Parent = teleportAttackButton

    local autoCoinToggleFrame = Instance.new("Frame")
    autoCoinToggleFrame.Name = "AutoCoinToggleFrame"
    autoCoinToggleFrame.Size = UDim2.new(1, -20, 0, 30)
    autoCoinToggleFrame.Position = UDim2.new(0, 10, 0, 290)
    autoCoinToggleFrame.BackgroundTransparency = 1
    autoCoinToggleFrame.Parent = mainFrame

    local autoCoinToggleLabel = Instance.new("TextLabel")
    autoCoinToggleLabel.Name = "AutoCoinToggleLabel"
    autoCoinToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    autoCoinToggleLabel.BackgroundTransparency = 1
    autoCoinToggleLabel.Text = "Auto Farm Coins"
    autoCoinToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoCoinToggleLabel.TextSize = 14
    autoCoinToggleLabel.Font = Enum.Font.Gotham
    autoCoinToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    autoCoinToggleLabel.Parent = autoCoinToggleFrame

    local autoCoinToggleButton = Instance.new("TextButton")
    autoCoinToggleButton.Name = "AutoCoinToggleButton"
    autoCoinToggleButton.Size = UDim2.new(0, 50, 0, 25)
    autoCoinToggleButton.Position = UDim2.new(1, -50, 0.5, -12)
    autoCoinToggleButton.BackgroundColor3 = uiconfig.Colors.ButtonOff
    autoCoinToggleButton.Text = ""
    autoCoinToggleButton.Parent = autoCoinToggleFrame

    local autoCoinToggleCorner = Instance.new("UICorner")
    autoCoinToggleCorner.CornerRadius = UDim.new(0, 12)
    autoCoinToggleCorner.Parent = autoCoinToggleButton

    local autoCoinToggleInner = Instance.new("Frame")
    autoCoinToggleInner.Name = "AutoCoinToggleInner"
    autoCoinToggleInner.Size = UDim2.new(0, 21, 0, 21)
    autoCoinToggleInner.Position = UDim2.new(0, 2, 0.5, -10)
    autoCoinToggleInner.BackgroundColor3 = uiconfig.Colors.ToggleOff
    autoCoinToggleInner.Parent = autoCoinToggleButton

    local autoCoinToggleInnerCorner = Instance.new("UICorner")
    autoCoinToggleInnerCorner.CornerRadius = UDim.new(0, 10)
    autoCoinToggleInnerCorner.Parent = autoCoinToggleInner

    local statlabel = Instance.new("TextLabel")
    statlabel.Name = "statlabel"
    statlabel.Size = UDim2.new(1, -20, 0, 20)
    statlabel.Position = UDim2.new(0, 10, 0, 330)
    statlabel.BackgroundTransparency = 1
    statlabel.Text = "Status: Inactive"
    statlabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    statlabel.TextSize = 12
    statlabel.Font = Enum.Font.Gotham
    statlabel.TextXAlignment = Enum.TextXAlignment.Left
    statlabel.Parent = mainFrame

    local function updateAutoCoinToggle()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        if autoCoin then
            local tween = TweenService:Create(autoCoinToggleInner, tweenInfo, {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = uiconfig.Colors.ToggleOn})
            tween:Play()
            autoCoinToggleButton.BackgroundColor3 = uiconfig.Colors.ButtonOn
        else
            local tween = TweenService:Create(autoCoinToggleInner, tweenInfo, {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = uiconfig.Colors.ToggleOff})
            tween:Play()
            autoCoinToggleButton.BackgroundColor3 = uiconfig.Colors.ButtonOff
        end
    end

    spdtxtbox.FocusLost:Connect(function(enterPressed)
        local newSpeed = tonumber(spdtxtbox.Text)
        if newSpeed and newSpeed >= 0 then
            walkSpeed = newSpeed
            updateCharacterSpeed()
            statlabel.Text = "Status: Speed ​​changed to " .. walkSpeed
        else
            spdtxtbox.Text = tostring(walkSpeed)
            statlabel.Text = "Status: Invalid speed value"
        end
    end)

    jumpTextBox.FocusLost:Connect(function(enterPressed)
        local newJump = tonumber(jumpTextBox.Text)
        if newJump and newJump >= 0 then
            jumpPower = newJump
            updateCharacterJump()
            statlabel.Text = "Status: JumpPower to " .. jumpPower
        else
            jumpTextBox.Text = tostring(jumpPower)
            statlabel.Text = "Status: Invalid JumpPower value"
        end
    end)

    gunDropButton.MouseButton1Click:Connect(function()
        local gunDrop = findGunDrop()
        if gunDrop and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            localPlayer.Character.HumanoidRootPart.CFrame = gunDrop.CFrame + Vector3.new(0,0,0)
            statlabel.Text = "Status: Teleported to Gun"
        else
            statlabel.Text = "Status: Gun not found"
        end
    end)

    teleportAttackButton.MouseButton1Click:Connect(function()
        teleportAndAttack()
        statlabel.Text = "Status: Auto Kill Someone Executed"
    end)

    autoCoinToggleButton.MouseButton1Click:Connect(function()
        autoCoin = not autoCoin
        updateAutoCoinToggle()
        statlabel.Text = "Status: Auto Coin " .. (autoCoin and "Enabled" or "Disabled")
        
        if autoCoin then
            statlabel.Text = "Status: Auto Farm Coins Enabled"
        else
            statlabel.Text = "Status: Auto Farm Coins Disabled"
            if currentTween then currentTween:Cancel() end
        end
    end)

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
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

    gunDropButton.MouseEnter:Connect(function()
        TweenService:Create(gunDropButton, TweenInfo.new(0.2), {BackgroundColor3 = uiconfig.Colors.ButtonHover}):Play()
    end)
    gunDropButton.MouseLeave:Connect(function()
        TweenService:Create(gunDropButton, TweenInfo.new(0.2), {BackgroundColor3 = uiconfig.Colors.Button}):Play()
    end)

    teleportAttackButton.MouseEnter:Connect(function()
        TweenService:Create(teleportAttackButton, TweenInfo.new(0.2), {BackgroundColor3 = uiconfig.Colors.ButtonHover}):Play()
    end)
    teleportAttackButton.MouseLeave:Connect(function()
        TweenService:Create(teleportAttackButton, TweenInfo.new(0.2), {BackgroundColor3 = uiconfig.Colors.Button}):Play()
    end)

    updateAutoCoinToggle()

    return {
        updateStatus = function(text)
            statlabel.Text = "Status: " .. text
        end,
        getAutoCoinEnabled = function()
            return autoCoin
        end
    }
end

local menu = createModernMenu()

localPlayer.CharacterAdded:Connect(function(character)
    wait(0.5)
    updateCharacterSpeed()
    updateCharacterJump()
end)

runsee+.Heartbeat:Connect(function()
    if autoCoin and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local coin = getNearestCoin()
        if coin then
            if currentTween then currentTween:Cancel() end
            local hrp = localPlayer.Character.HumanoidRootPart
            local tweenInfo = TweenInfo.new((coin.Position - hrp.Position).Magnitude/200, Enum.EasingStyle.Linear)
            currentTween = TweenService:Create(hrp, tweenInfo, {CFrame = coin.CFrame + Vector3.new(0,0,0)})
            currentTween:Play()
            menu.updateStatus("Collecting Coin")
        end
    end
end)

for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= localPlayer then
        setupPlayer(plr)
    end
end

Players.PlayerAdded:Connect(function(plr)
    if plr ~= localPlayer then
        setupPlayer(plr)
    end
end)

Players.PlayerRemoving:Connect(cleanupPlayer)

while true do
    wait(2)
    refreshUI()
end
