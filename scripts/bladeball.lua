local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local clonefunction = clonefunction or function(f) return f end
local cloneref = clonefunction(cloneref) or function(i) return i end

local Services = setmetatable({}, {
    __index = function(self, serviceName)
        local service = cloneref(game:GetService(serviceName))
        self[serviceName] = service
        return service
    end,
})

local workspace = Services.Workspace
local ReplicatedStorage = Services.ReplicatedStorage
local VirtualInputManager = Services.VirtualInputManager
local RunService = Services.RunService
local Debris = Services.Debris
local GameStats = Services.Stats
local VUser = Services.VirtualUser

local Settings = {
    ParryMode = "Machine",
    AutoParry = false,
    AutoSpam = false,
    MaxHits = 10,
    ModDetection = false,
    WalkToBall = false,
    WalkDistance = 60,
}
local DataStoreService = game:GetService("DataStoreService")
local HttpService = game:GetService("HttpService")
local SETTINGS_FILE_NAME = "BladeBall_Zeta_Settings.json"

local function SaveSettings()
    if writefile then
        local data = HttpService:JSONEncode(Settings)
        pcall(writefile, SETTINGS_FILE_NAME, data)
    end
end

local function LoadSettings()
    if readfile and isfile and isfile(SETTINGS_FILE_NAME) then
        local success, loadedData = pcall(readfile, SETTINGS_FILE_NAME)
        if success and loadedData then
            local decoded = HttpService:JSONDecode(loadedData)
            if type(decoded) == "table" then
                for key, value in pairs(decoded) do
                    if Settings[key] ~= nil then
                        Settings[key] = value
                    end
                end
            end
        end
    end
end

local ParryDuration = 0.548
local HitDelayCheck = 0.8
local MinRange = 2.583

local Match = {
    ball = {
        ball_itself = nil,
        client_ball_itself = nil,
        properties = {
            last_sphere_location = Vector3.zero,
            aero_dynamic_time = tick(),
            hell_hook_completed = true,
            last_position = Vector3.zero,
            rotation = Vector3.zero,
            position = Vector3.zero,
            last_warping = tick(),
            parry_remote = nil,
            is_curved = false,
            last_tick = tick(),
            auto_spam = false,
            cooldown = false,
            respawn_time = 0,
            parry_range = 0,
            spam_range = 0,
            maximum_speed = 0,
            old_speed = 0,
            parries = 0,
            direction = 0,
            distance = 0,
            velocity = Vector3.zero,
            last_hit = 0,
            lerp_radians = 0,
            radians = 0,
            speed = 0,
            dot = 0,
        },
    },
    target = {
        current = nil,
        from = nil,
        aim = nil,
    },
    entity_properties = {
        server_position = Vector3.zero,
        velocity = Vector3.zero,
        is_moving = false,
        direction = 0,
        distance = 0,
        speed = 0,
        dot = 0,
    },
}

local Playuh = {
    Entity = {
        properties = {
            sword = "",
            server_position = Vector3.zero,
            velocity = Vector3.zero,
            position = Vector3.zero,
            is_moving = false,
            speed = 0,
            ping = 0,
        },
    },
    properties = {
        grab_animation = nil,
    },
}

local function createModernMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = ""
    screenGui.Parent = game:GetService("CoreGui")
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 9999
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 300, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
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
    titleBar.Size = UDim2.new(1, 0, 0, 40)
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
    title.Text = "Blade Ball ᵇʸ ᵉˣᶜᵃˡⁱᵇᵘʳ ᵗᵉᵃᵐ"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 18
    title.Font = Enum.Font.GothamBold
    title.Parent = titleBar

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 40, 0, 40)
    closeButton.Position = UDim2.new(1, -40, 0, 0)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 18
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = titleBar

    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(1, -20, 0, 30)
    tabContainer.Position = UDim2.new(0, 10, 0, 50)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = mainFrame

    local combatTabButton = Instance.new("TextButton")
    combatTabButton.Name = "CombatTabButton"
    combatTabButton.Size = UDim2.new(0, 80, 1, 0)
    combatTabButton.Position = UDim2.new(0, 0, 0, 0)
    combatTabButton.BackgroundColor3 = Color3.fromRGB(120, 81, 169)
    combatTabButton.Text = "Combat"
    combatTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    combatTabButton.TextSize = 14
    combatTabButton.Font = Enum.Font.GothamBold
    combatTabButton.Parent = tabContainer

    local combatCorner = Instance.new("UICorner")
    combatCorner.CornerRadius = UDim.new(0, 4)
    combatCorner.Parent = combatTabButton

    local creditsTabButton = Instance.new("TextButton")
    creditsTabButton.Name = "CreditsTabButton"
    creditsTabButton.Size = UDim2.new(0, 80, 1, 0)
    creditsTabButton.Position = UDim2.new(0, 85, 0, 0)
    creditsTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    creditsTabButton.Text = "Credits"
    creditsTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    creditsTabButton.TextSize = 14
    creditsTabButton.Font = Enum.Font.Gotham
    creditsTabButton.Parent = tabContainer

    local creditsCorner = Instance.new("UICorner")
    creditsCorner.CornerRadius = UDim.new(0, 4)
    creditsCorner.Parent = creditsTabButton

    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -20, 0, 290)
    contentFrame.Position = UDim2.new(0, 10, 0, 90)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    local combatContent = Instance.new("ScrollingFrame")
    combatContent.Name = "CombatContent"
    combatContent.Size = UDim2.new(1, 0, 1, 0)
    combatContent.BackgroundTransparency = 1
    combatContent.BorderSizePixel = 0
    combatContent.ScrollBarThickness = 0
    combatContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    combatContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    combatContent.Parent = contentFrame

    local creditsContent = Instance.new("ScrollingFrame")
    creditsContent.Name = "CreditsContent"
    creditsContent.Size = UDim2.new(1, 0, 1, 0)
    creditsContent.BackgroundTransparency = 1
    creditsContent.BorderSizePixel = 0
    creditsContent.ScrollBarThickness = 0
    creditsContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    creditsContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    creditsContent.Visible = false
    creditsContent.Parent = contentFrame

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Padding = UDim.new(0, 10)
    uiListLayout.Parent = combatContent

    local creditsListLayout = Instance.new("UIListLayout")
    creditsListLayout.Padding = UDim.new(0, 10)
    creditsListLayout.Parent = creditsContent

    local autoParryToggleFrame = Instance.new("Frame")
    autoParryToggleFrame.Name = "AutoParryToggleFrame"
    autoParryToggleFrame.Size = UDim2.new(1, 0, 0, 30)
    autoParryToggleFrame.BackgroundTransparency = 1
    autoParryToggleFrame.Parent = combatContent

    local autoParryToggleLabel = Instance.new("TextLabel")
    autoParryToggleLabel.Name = "AutoParryToggleLabel"
    autoParryToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    autoParryToggleLabel.BackgroundTransparency = 1
    autoParryToggleLabel.Text = "Auto Parry"
    autoParryToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoParryToggleLabel.TextSize = 14
    autoParryToggleLabel.Font = Enum.Font.Gotham
    autoParryToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    autoParryToggleLabel.Parent = autoParryToggleFrame

    local autoParryToggleButton = Instance.new("TextButton")
    autoParryToggleButton.Name = "AutoParryToggleButton"
    autoParryToggleButton.Size = UDim2.new(0, 50, 0, 25)
    autoParryToggleButton.Position = UDim2.new(1, -50, 0.5, -12)
    autoParryToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    autoParryToggleButton.Text = ""
    autoParryToggleButton.Parent = autoParryToggleFrame

    local autoParryToggleCorner = Instance.new("UICorner")
    autoParryToggleCorner.CornerRadius = UDim.new(0, 12)
    autoParryToggleCorner.Parent = autoParryToggleButton

    local autoParryToggleInner = Instance.new("Frame")
    autoParryToggleInner.Name = "AutoParryToggleInner"
    autoParryToggleInner.Size = UDim2.new(0, 21, 0, 21)
    autoParryToggleInner.Position = UDim2.new(0, 2, 0.5, -10)
    autoParryToggleInner.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    autoParryToggleInner.Parent = autoParryToggleButton

    local autoParryToggleInnerCorner = Instance.new("UICorner")
    autoParryToggleInnerCorner.CornerRadius = UDim.new(0, 10)
    autoParryToggleInnerCorner.Parent = autoParryToggleInner

    local autoSpamToggleFrame = Instance.new("Frame")
    autoSpamToggleFrame.Name = "AutoSpamToggleFrame"
    autoSpamToggleFrame.Size = UDim2.new(1, 0, 0, 30)
    autoSpamToggleFrame.BackgroundTransparency = 1
    autoSpamToggleFrame.Parent = combatContent

    local autoSpamToggleLabel = Instance.new("TextLabel")
    autoSpamToggleLabel.Name = "AutoSpamToggleLabel"
    autoSpamToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    autoSpamToggleLabel.BackgroundTransparency = 1
    autoSpamToggleLabel.Text = "Auto Spam"
    autoSpamToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoSpamToggleLabel.TextSize = 14
    autoSpamToggleLabel.Font = Enum.Font.Gotham
    autoSpamToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    autoSpamToggleLabel.Parent = autoSpamToggleFrame

    local autoSpamToggleButton = Instance.new("TextButton")
    autoSpamToggleButton.Name = "AutoSpamToggleButton"
    autoSpamToggleButton.Size = UDim2.new(0, 50, 0, 25)
    autoSpamToggleButton.Position = UDim2.new(1, -50, 0.5, -12)
    autoSpamToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    autoSpamToggleButton.Text = ""
    autoSpamToggleButton.Parent = autoSpamToggleFrame

    local autoSpamToggleCorner = Instance.new("UICorner")
    autoSpamToggleCorner.CornerRadius = UDim.new(0, 12)
    autoSpamToggleCorner.Parent = autoSpamToggleButton

    local autoSpamToggleInner = Instance.new("Frame")
    autoSpamToggleInner.Name = "AutoSpamToggleInner"
    autoSpamToggleInner.Size = UDim2.new(0, 21, 0, 21)
    autoSpamToggleInner.Position = UDim2.new(0, 2, 0.5, -10)
    autoSpamToggleInner.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    autoSpamToggleInner.Parent = autoSpamToggleButton

    local autoSpamToggleInnerCorner = Instance.new("UICorner")
    autoSpamToggleInnerCorner.CornerRadius = UDim.new(0, 10)
    autoSpamToggleInnerCorner.Parent = autoSpamToggleInner

    local modDetectionToggleFrame = Instance.new("Frame")
    modDetectionToggleFrame.Name = "ModDetectionToggleFrame"
    modDetectionToggleFrame.Size = UDim2.new(1, 0, 0, 30)
    modDetectionToggleFrame.BackgroundTransparency = 1
    modDetectionToggleFrame.Parent = combatContent

    local modDetectionToggleLabel = Instance.new("TextLabel")
    modDetectionToggleLabel.Name = "ModDetectionToggleLabel"
    modDetectionToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    modDetectionToggleLabel.BackgroundTransparency = 1
    modDetectionToggleLabel.Text = "Mod Detection"
    modDetectionToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    modDetectionToggleLabel.TextSize = 14
    modDetectionToggleLabel.Font = Enum.Font.Gotham
    modDetectionToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    modDetectionToggleLabel.Parent = modDetectionToggleFrame

    local modDetectionToggleButton = Instance.new("TextButton")
    modDetectionToggleButton.Name = "ModDetectionToggleButton"
    modDetectionToggleButton.Size = UDim2.new(0, 50, 0, 25)
    modDetectionToggleButton.Position = UDim2.new(1, -50, 0.5, -12)
    modDetectionToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    modDetectionToggleButton.Text = ""
    modDetectionToggleButton.Parent = modDetectionToggleFrame

    local modDetectionToggleCorner = Instance.new("UICorner")
    modDetectionToggleCorner.CornerRadius = UDim.new(0, 12)
    modDetectionToggleCorner.Parent = modDetectionToggleButton

    local modDetectionToggleInner = Instance.new("Frame")
    modDetectionToggleInner.Name = "ModDetectionToggleInner"
    modDetectionToggleInner.Size = UDim2.new(0, 21, 0, 21)
    modDetectionToggleInner.Position = UDim2.new(0, 2, 0.5, -10)
    modDetectionToggleInner.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    modDetectionToggleInner.Parent = modDetectionToggleButton

    local modDetectionToggleInnerCorner = Instance.new("UICorner")
    modDetectionToggleInnerCorner.CornerRadius = UDim.new(0, 10)
    modDetectionToggleInnerCorner.Parent = modDetectionToggleInner

    local walkToBallToggleFrame = Instance.new("Frame")
    walkToBallToggleFrame.Name = "WalkToBallToggleFrame"
    walkToBallToggleFrame.Size = UDim2.new(1, 0, 0, 30)
    walkToBallToggleFrame.BackgroundTransparency = 1
    walkToBallToggleFrame.Parent = combatContent

    local walkToBallToggleLabel = Instance.new("TextLabel")
    walkToBallToggleLabel.Name = "WalkToBallToggleLabel"
    walkToBallToggleLabel.Size = UDim2.new(0.7, 0,  -2, 0)
    walkToBallToggleLabel.BackgroundTransparency = 1
    walkToBallToggleLabel.Text = "Follow the ball + Anti-Afk"
    walkToBallToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    walkToBallToggleLabel.TextSize = 14
    walkToBallToggleLabel.Font = Enum.Font.Gotham
    walkToBallToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    walkToBallToggleLabel.Parent = walkToBallToggleFrame

    local walkToBallToggleButton = Instance.new("TextButton")
    walkToBallToggleButton.Name = "WalkToBallToggleButton"
    walkToBallToggleButton.Size = UDim2.new(0, 50, 0, 25)
    walkToBallToggleButton.Position = UDim2.new(1, -50,  -1, -12)
    walkToBallToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    walkToBallToggleButton.Text = ""
    walkToBallToggleButton.Parent = walkToBallToggleFrame

    local walkToBallToggleCorner = Instance.new("UICorner")
    walkToBallToggleCorner.CornerRadius = UDim.new(0, 12)
    walkToBallToggleCorner.Parent = walkToBallToggleButton

    local walkToBallToggleInner = Instance.new("Frame")
    walkToBallToggleInner.Name = "WalkToBallToggleInner"
    walkToBallToggleInner.Size = UDim2.new(0, 21, 0, 21)
    walkToBallToggleInner.Position = UDim2.new(0, 2, 0.5, -10)
    walkToBallToggleInner.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    walkToBallToggleInner.Parent = walkToBallToggleButton

    local walkToBallToggleInnerCorner = Instance.new("UICorner")
    walkToBallToggleInnerCorner.CornerRadius = UDim.new(0, 10)
    walkToBallToggleInnerCorner.Parent = walkToBallToggleInner

    local walkDistanceFrame = Instance.new("Frame")
    walkDistanceFrame.Name = "WalkDistanceFrame"
    walkDistanceFrame.Size = UDim2.new(1, 0, 0, 30)
    walkDistanceFrame.BackgroundTransparency = 1
    walkDistanceFrame.Parent = combatContent

    local walkDistanceLabel = Instance.new("TextLabel")
    walkDistanceLabel.Name = "WalkDistanceLabel"
    walkDistanceLabel.Size = UDim2.new(0.7, 0, 1, 0)
    walkDistanceLabel.Transparency = 1
    walkDistanceLabel.BackgroundTransparency = 1
    walkDistanceLabel.Text = "Walk Distance:"
    walkDistanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    walkDistanceLabel.TextSize = 14
    walkDistanceLabel.Font = Enum.Font.Gotham
    walkDistanceLabel.TextXAlignment = Enum.TextXAlignment.Left
    walkDistanceLabel.Parent = walkDistanceFrame

    local walkDistanceBox = Instance.new("TextBox")
    walkDistanceBox.Name = "WalkDistanceBox"
    walkDistanceBox.Transparency = 1
    walkDistanceBox.Size = UDim2.new(0.25, 0, 0.7, 0)
    walkDistanceBox.Position = UDim2.new(0.75, -95, 0.15, 0)
    walkDistanceBox.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    walkDistanceBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    walkDistanceBox.Text = "60"
    walkDistanceBox.TextSize = 14
    walkDistanceBox.Font = Enum.Font.Gotham
    walkDistanceBox.Parent = walkDistanceFrame

    local walkDistanceCorner = Instance.new("UICorner")
    walkDistanceCorner.CornerRadius = UDim.new(0, 4)
    walkDistanceCorner.Parent = walkDistanceBox

    local fpsBoostButton = Instance.new("TextButton")
    fpsBoostButton.Name = "FPSBoostButton"
    fpsBoostButton.Size = UDim2.new(1, 0, 0, 35)
    fpsBoostButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    fpsBoostButton.Text = "FPS Boost"
    fpsBoostButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    fpsBoostButton.TextSize = 14
    fpsBoostButton.Font = Enum.Font.GothamBold
    fpsBoostButton.Parent = combatContent

    local fpsBoostCorner = Instance.new("UICorner")
    fpsBoostCorner.CornerRadius = UDim.new(0, 4)
    fpsBoostCorner.Parent = fpsBoostButton

    local serverHopButton = Instance.new("TextButton")
    serverHopButton.Name = "ServerHopButton"
    serverHopButton.Size = UDim2.new(1, 0, 0, 35)
    serverHopButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    serverHopButton.Text = "Server Hop"
    serverHopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    serverHopButton.TextSize = 14
    serverHopButton.Font = Enum.Font.GothamBold
    serverHopButton.Parent = combatContent

    local serverHopCorner = Instance.new("UICorner")
    serverHopCorner.CornerRadius = UDim.new(0, 4)
    serverHopCorner.Parent = serverHopButton
    
    local madeByButton = Instance.new("TextButton")
    madeByButton.Name = "MadeByButton"
    madeByButton.Size = UDim2.new(1, 0, 0, 35)
    madeByButton.BackgroundColor3 = Color3.fromRGB(120, 81, 169)
    madeByButton.Text = "Made by _.yzero"
    madeByButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    madeByButton.TextSize = 14
    madeByButton.Font = Enum.Font.GothamBold
    madeByButton.Parent = creditsContent

    local madeByCorner = Instance.new("UICorner")
    madeByCorner.CornerRadius = UDim.new(0, 4)
    madeByCorner.Parent = madeByButton

    local discordButton = Instance.new("TextButton")
    discordButton.Name = "DiscordButton"
    discordButton.Size = UDim2.new(1, 0, 0, 35)
    discordButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    discordButton.Text = "CLICK TO COPY THE DISCORD"
    discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    discordButton.TextSize = 12
    discordButton.Font = Enum.Font.Gotham
    discordButton.Parent = creditsContent

    local discordCorner = Instance.new("UICorner")
    discordCorner.CornerRadius = UDim.new(0, 4)
    discordCorner.Parent = discordButton

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Size = UDim2.new(1, -20, 0, 20)
    statusLabel.Position = UDim2.new(0, 10, 1, -30)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Status: Ready"
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusLabel.TextSize = 8
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = mainFrame

    local dragging
    local dragInput
    local dragStart
    local startPos

    local function updateToggle(toggleInner, value)
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        if value then
            local tween = TweenService:Create(toggleInner, tweenInfo, {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(100, 255, 150)})
            tween:Play()
        else
            local tween = TweenService:Create(toggleInner, tweenInfo, {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 100, 100)})
            tween:Play()
        end
    end

    updateToggle(autoParryToggleInner, Settings.AutoParry)
    updateToggle(autoSpamToggleInner, Settings.AutoSpam)
    updateToggle(modDetectionToggleInner, Settings.ModDetection)
    updateToggle(walkToBallToggleInner, Settings.WalkToBall)

    autoParryToggleButton.MouseButton1Click:Connect(function()
        Settings.AutoParry = not Settings.AutoParry
        updateToggle(autoParryToggleInner, Settings.AutoParry)
        SaveSettings()
    end)

    autoSpamToggleButton.MouseButton1Click:Connect(function()
        Settings.AutoSpam = not Settings.AutoSpam
        updateToggle(autoSpamToggleInner, Settings.AutoSpam)
        SaveSettings()
    end)

    modDetectionToggleButton.MouseButton1Click:Connect(function()
        Settings.ModDetection = not Settings.ModDetection
        updateToggle(modDetectionToggleInner, Settings.ModDetection)
        SaveSettings()
    end)

    local walkConnection
    local function WalkBall()
        if walkConnection then
            walkConnection:Disconnect()
        end

        walkConnection = RunService.Heartbeat:Connect(function()
            if not Settings.WalkToBall then
                return
            end

            local char = LocalPlayer.Character
            if not char then return end

            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local rootPart = char:FindFirstChild("HumanoidRootPart")

            if not humanoid or not rootPart or humanoid.Health <= 0 then
                return
            end

            local ball = Match.get_ball()
            if not ball then
                humanoid:Move(Vector3.zero)
                return
            end

            local distance = (ball.Position - rootPart.Position).Magnitude
            if distance <= Settings.WalkDistance then
                humanoid:Move(Vector3.zero)
                return
            end

            local direction = (ball.Position - rootPart.Position).Unit
            humanoid:MoveTo(
                rootPart.Position +
                direction * math.min(distance - Settings.WalkDistance, humanoid.WalkSpeed * 0.1)
            )
        end)
    end
    
    walkToBallToggleButton.MouseButton1Click:Connect(function()
        Settings.WalkToBall = not Settings.WalkToBall
        updateToggle(walkToBallToggleInner, Settings.WalkToBall)
        SaveSettings()
        if Settings.WalkToBall then
            WalkBall()
        end
    end)

    walkDistanceBox.FocusLost:Connect(function(enterPressed)
        local num = tonumber(walkDistanceBox.Text)
        if num and num >= 0 then
            Settings.WalkDistance = num
            walkDistanceBox.Text = tostring(num)
            SaveSettings()
        else
            walkDistanceBox.Text = tostring(Settings.WalkDistance)
        end
    end)

    fpsBoostButton.MouseButton1Click:Connect(function()
        statusLabel.Text = "Status: Applying FPS Boost..."
        
        local RunService = game:GetService("RunService")
        local Lighting = game:GetService("Lighting")
        local Terrain = workspace:FindFirstChildWhichIsA("Terrain")

        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 1
        end

        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1e10
        Lighting.FogStart = 0
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

        local objects = game:GetDescendants()
        local index = 1
        local accumulator = 0
        local PARTS_PER_SECOND = 300

        local function processObject(o)
            if o:IsA("BasePart") then
                o.CastShadow = false
                o.Material = Enum.Material.Plastic
                o.Reflectance = 0
            elseif o:IsA("Beam")
                or o:IsA("Trail")
                or o:IsA("ParticleEmitter")
                or o:IsA("Fire")
                or o:IsA("Smoke")
                or o:IsA("Sparkles")
                or o:IsA("Decal")
                or o:IsA("Texture")
                or o:IsA("PointLight")
                or o:IsA("SurfaceAppearance") then
                o:Destroy()
            elseif o:IsA("MeshPart") then
                o.TextureId = ""
                o.MeshId = ""
            end
        end

        RunService.PreRender:Connect(function(deltaTime)
            accumulator += deltaTime
            if accumulator >= 1 then
                accumulator = 0
                for i = 1, PARTS_PER_SECOND do
                    local obj = objects[index]
                    if not obj then return end
                    processObject(obj)
                    index += 1
                end
            end
        end)

        workspace.DescendantAdded:Connect(function(o)
            task.defer(function()
                processObject(o)
            end)
        end)

        statusLabel.Text = "Status: FPS Boost Applied"
    end)

    serverHopButton.MouseButton1Click:Connect(function()
        statusLabel.Text = "Status: Server Hopping..."
        loadstring(game:HttpGet("https://pastefy.app/Oa8ml7J4/raw"))()
    end)

    madeByButton.MouseButton1Click:Connect(function()
        setclipboard("_.yzero")
        statusLabel.Text = "Status: Copied to clipboard"
    end)

    discordButton.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/Vqt5U2fSNK")
        statusLabel.Text = "Status: Discord link copied"
    end)

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    combatTabButton.MouseButton1Click:Connect(function()
        combatContent.Visible = true
        creditsContent.Visible = false
        combatTabButton.BackgroundColor3 = Color3.fromRGB(120, 81, 169)
        combatTabButton.Font = Enum.Font.GothamBold
        creditsTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        creditsTabButton.Font = Enum.Font.Gotham
    end)

    creditsTabButton.MouseButton1Click:Connect(function()
        combatContent.Visible = false
        creditsContent.Visible = true
        creditsTabButton.BackgroundColor3 = Color3.fromRGB(120, 81, 169)
        creditsTabButton.Font = Enum.Font.GothamBold
        combatTabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        combatTabButton.Font = Enum.Font.Gotham
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

    return screenGui, {
        autoParryToggleInner = autoParryToggleInner,
        autoSpamToggleInner = autoSpamToggleInner,
        modDetectionToggleInner = modDetectionToggleInner,
        walkToBallToggleInner = walkToBallToggleInner,
        walkDistanceBox = walkDistanceBox,
    }
end
LoadSettings()
local menu, uiElements = createModernMenu()
updateToggle(uiElements.autoParryToggleInner, Settings.AutoParry)
updateToggle(uiElements.autoSpamToggleInner, Settings.AutoSpam)
updateToggle(uiElements.modDetectionToggleInner, Settings.ModDetection)
updateToggle(uiElements.walkToBallToggleInner, Settings.WalkToBall)

local function LerpRadians(from, to, alpha)
    return from + ((to - from) * alpha)
end

local function GetPointer()
    local mouseLocation = UserInputService:GetMouseLocation()
    local screenRay = workspace.CurrentCamera:ScreenPointToRay(mouseLocation.X, mouseLocation.Y, 0)
    return CFrame.lookAt(screenRay.Origin, screenRay.Origin + screenRay.Direction)
end

function Match.get_ball()
    for _, v in workspace.Balls:GetChildren() do
        if v:GetAttribute("realBall") then
            return v
        end
    end
end

function Match.get_client_ball()
    for _, v in workspace.Balls:GetChildren() do
        if not v:GetAttribute("realBall") then
            return v
        end
    end
end

function Match.get_parry_remote()
    local services = {Services.AnimationFromVideoCreatorService, Services.AdService}
    for _, service in services do
        local remoteEvent = service:FindFirstChildOfClass("RemoteEvent")
        if remoteEvent and remoteEvent.Name:find("\n") then
            Match.ball.properties.parry_remote = remoteEvent
            return
        end
    end
end

Match.get_parry_remote()

function Playuh.get_aim_entity()
    local closestEntity, highestDot = nil, -math.huge
    local cameraLook = workspace.CurrentCamera.CFrame.LookVector

    for _, playerModel in workspace.Alive:GetChildren() do
        if playerModel and playerModel.Name ~= LocalPlayer.Name then
            local hrp = playerModel:FindFirstChild("HumanoidRootPart")
            if hrp then
                local direction = (hrp.Position - workspace.CurrentCamera.CFrame.Position).Unit
                local dot = cameraLook:Dot(direction)
                if dot > highestDot then
                    highestDot = dot
                    closestEntity = playerModel
                end
            end
        end
    end
    return closestEntity
end

function Playuh.get_closest_player_to_cursor()
    local closestPlayer, highestDot = nil, -math.huge
    local pointer = GetPointer()

    for _, playerModel in workspace.Alive:GetChildren() do
        if playerModel ~= LocalPlayer.Character and playerModel.Parent == workspace.Alive then
            local direction = (playerModel.PrimaryPart.Position - workspace.CurrentCamera.CFrame.Position).Unit
            local dot = pointer.LookVector:Dot(direction)
            if dot > highestDot then
                highestDot = dot
                closestPlayer = playerModel
            end
        end
    end
    return closestPlayer
end

function Match.perform_grab_animation()
    local equippedSword = Playuh.Entity.properties.sword
    if not equippedSword or equippedSword == "Titan Blade" then return end

    local grabParryAnim = ReplicatedStorage.Shared.SwordAPI.Collection.Default:FindFirstChild("GrabParry")
    if not grabParryAnim then return end

    local swordData = ReplicatedStorage.Shared.ReplicatedInstances.Swords.GetSword:Invoke(equippedSword)
    if not swordData or not swordData.AnimationType then return end

    local playerChar = LocalPlayer.Character
    if not playerChar or not playerChar:FindFirstChild("Humanoid") then return end

    local swordModel = ReplicatedStorage.Shared.SwordAPI.Collection:FindFirstChild(swordData.AnimationType)
    if swordModel then
        local anim = swordModel:FindFirstChild("GrabParry") or swordModel:FindFirstChild("Grab")
        if anim then
            grabParryAnim = anim
            if anim.Name == "Grab" then
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0.001)
            end
        end
    end

    Playuh.properties.grab_animation = playerChar.Humanoid:LoadAnimation(grabParryAnim)
    Playuh.properties.grab_animation:Play()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0.0001)
end

function Match.perform_parry()
    local props = Match.ball.properties
    if props.cooldown and not props.auto_spam then return end

    props.parries = props.parries + 1
    props.last_hit = tick()

    if not props.auto_spam then
        Match.perform_grab_animation()
        props.cooldown = true
    end

    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0.0001)

    task.delay(HitDelayCheck, function()
        if props.parries > 0 then
            props.parries = props.parries - 1
        end
    end)
end

function Match.reset()
    local props = Match.ball.properties
    props.is_curved = false
    props.auto_spam = false
    props.cooldown = false
    props.maximum_speed = 0
    props.parries = 0
    Match.entity_properties.server_position = Vector3.zero
    Match.target.current = nil
    Match.target.from = nil
end

function Match.is_curved()
    local target = Match.target.current
    if not target then return false end

    local props = Match.ball.properties
    local targetName = target.Name

    if target.PrimaryPart:FindFirstChild("MaxShield") and targetName ~= LocalPlayer.Name and props.distance < 50 then
        return false
    end

    if Match.ball.ball_itself:FindFirstChild("TimeHole1") and targetName ~= LocalPlayer.Name and props.distance < 100 then
        props.auto_spam = false
        return false
    end

    if Match.ball.ball_itself:FindFirstChild("WEMAZOOKIEGO") and targetName ~= LocalPlayer.Name and props.distance < 100 then
        return false
    end

    if Match.ball.ball_itself:FindFirstChild("At2") and props.speed <= 0 then
        return true
    end

    local aeroVFX = Match.ball.ball_itself:FindFirstChild("AeroDynamicSlashVFX")
    if aeroVFX then
        Debris:AddItem(aeroVFX, 0)
        props.auto_spam = false
        props.aero_dynamic_time = tick()
    end

    local tornado = workspace.Runtime:FindFirstChild("Tornado")
    if tornado and props.distance > 5 then
        local tornadoTime = tornado:GetAttribute("TornadoTime") or 1
        if (tick() - props.aero_dynamic_time) < (tornadoTime + 0.314159) then
            return true
        end
    end

    if not props.hell_hook_completed and targetName == LocalPlayer.Name and props.distance > (5 - math.random()) then
        return true
    end

    local predictedPos = props.position + (props.velocity * (props.distance / props.maximum_speed))
    local lastCurvePos = props.last_curve_position or props.position
    local dirChange = (predictedPos - lastCurvePos).Unit
    local velDirection = props.velocity.Unit:Dot(dirChange)
    local angleDelta = math.acos(math.clamp(velDirection, -1, 1))

    local speedFactor = math.min(props.speed / 100, 40)
    local dotFactor = 40.046 * math.max(props.dot, 0)
    local ping = Playuh.Entity.properties.ping
    local travelTime = (props.distance / (props.velocity.Magnitude + 0.01)) - (ping / 1000)

    local curveThreshold = (15 - math.min(props.distance / 1000, 15)) + dotFactor + speedFactor

    if props.maximum_speed > 100 and travelTime > (ping / 10) then
        curveThreshold = math.max(curveThreshold - 15, 15)
    end

    if props.distance < curveThreshold then return false end

    if angleDelta > (0.5 + (props.speed / 310)) then
        props.auto_spam = false
        return true
    end

    if props.lerp_radians < 0.018 then
        props.last_curve_position = props.position
        props.last_warping = tick()
    end

    if (tick() - props.last_warping) < (travelTime / 1.5) then
        return true
    end

    props.last_curve_position = props.position
    return props.dot < (ParryDuration - (ping / 950))
end

local lastTargetFrom
function Match.is_spam(ballState)
    if not Settings.AutoSpam or not Match.target.current then return false end

    if Match.target.from ~= LocalPlayer.Character then
        lastTargetFrom = Match.target.from
    end

    if ballState.parries < (3 - 1) and Match.target.from == lastTargetFrom then
        return false
    end

    local ping = Playuh.Entity.properties.ping
    local spamThreshold = (ballState.spam_accuracy / 3.5) + (ping / 80)
    local props = Match.ball.properties
    local travelTime = (props.distance / props.maximum_speed) - (ping / 1000)

    if (tick() - ballState.last_hit) > 0.8 and ballState.entity_distance > spamThreshold and ballState.parries < 3 then
        ballState.parries = 1
        return false
    end

    if props.lerp_radians > 0.028 then
        if ballState.parries < 2 then ballState.parries = 1 end
        return false
    end

    if (tick() - props.last_warping) < (travelTime / 1.3) and ballState.entity_distance > spamThreshold and ballState.parries < 4 then
        if ballState.parries < 3 then ballState.parries = 1 end
        return false
    end

    if math.abs(ballState.speed - ballState.old_speed) < 5.2 and ballState.entity_distance > spamThreshold and ballState.speed < 60 and ballState.parries < 3 then
        if ballState.parries < 3 then ballState.parries = 0 end
        return false
    end

    if ballState.speed < 10 then
        ballState.parries = 1
        return false
    end

    if ballState.maximum_speed < ballState.speed and ballState.entity_distance > spamThreshold then
        ballState.parries = 1
        return false
    end

    if ballState.entity_distance > ballState.range and ballState.entity_distance > spamThreshold then
        if ballState.parries < 2 then ballState.parries = 1 end
        return false
    end

    if ballState.ball_distance > ballState.range and ballState.entity_distance > spamThreshold then
        if ballState.parries < 2 then ballState.parries = 2 end
        return false
    end

    if ballState.last_position_distance > ballState.spam_accuracy and ballState.entity_distance > spamThreshold then
        if ballState.parries < 4 then ballState.parries = 2 end
        return false
    end

    if ballState.ball_distance > ballState.spam_accuracy and ballState.ball_distance > spamThreshold then
        if ballState.parries < 3 then ballState.parries = 2 end
        return false
    end

    if ballState.entity_distance > ballState.spam_accuracy and ballState.entity_distance > (spamThreshold - math.pi) then
        if ballState.parries < 3 then ballState.parries = 2 end
        return false
    end

    return true
end

RunService:BindToRenderStep("server position simulation", 1, function()
    local char = LocalPlayer.Character
    if char and char.PrimaryPart then
        task.delay(GameStats.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000, function()
            if char and char.PrimaryPart then
                Playuh.Entity.properties.server_position = char.PrimaryPart.Position
            end
        end)
    end
end)

Services.NetworkClient:SetOutgoingKBPSLimit(math.huge)
RunService.PreSimulation:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char.PrimaryPart then return end

    local props = Playuh.Entity.properties
    props.sword = char:GetAttribute("CurrentlyEquippedSword")
    props.ping = GameStats.Network.ServerStatsItem["Data Ping"]:GetValue()
    props.velocity = char.PrimaryPart.AssemblyLinearVelocity
    props.speed = props.velocity.Magnitude
    props.is_moving = props.speed > 30
end)

Match.ball.ball_itself = Match.get_ball()
Match.ball.client_ball_itself = Match.get_client_ball()

RunService.PreSimulation:Connect(function()
    local ballEntity = Match.ball.ball_itself
    if not ballEntity then return end

    local props = Match.ball.properties
    props.position = ballEntity.Position
    props.velocity = ballEntity.AssemblyLinearVelocity

    local zoomies = ballEntity:FindFirstChild("zoomies")
    if zoomies then
        props.velocity = zoomies.VectorVelocity
    end

    props.distance = (Playuh.Entity.properties.server_position - props.position).Magnitude
    props.speed = props.velocity.Magnitude
    props.direction = (Playuh.Entity.properties.server_position - props.position).Unit
    props.dot = props.direction:Dot(props.velocity.Unit)
    props.radians = math.rad(math.asin(props.dot))
    props.lerp_radians = LerpRadians(props.lerp_radians, props.radians, 0.8)

    if props.lerp_radians ~= props.lerp_radians then
        props.lerp_radians = 0.027
    end

    props.maximum_speed = math.max(props.speed, props.maximum_speed)

    Match.target.aim = (not UserInputService.TouchEnabled and Playuh.get_closest_player_to_cursor()) or Playuh.get_aim_entity()

    local targetAttr = ballEntity:GetAttribute("target")
    if targetAttr then
        Match.target.current = workspace.Alive:FindFirstChild(targetAttr)
    end

    local fromAttr = ballEntity:GetAttribute("from")
    if fromAttr then
        Match.target.from = workspace.Alive:FindFirstChild(fromAttr)
    end

    if Match.target.current and Match.target.current.Name == LocalPlayer.Name then
        props.rotation = Match.target.aim.PrimaryPart.Position
        return
    end

    if not Match.target.current then return end

    local targetPos = Match.target.current.PrimaryPart.Position
    local targetVel = Match.target.current.PrimaryPart.AssemblyLinearVelocity

    local entityProps = Match.entity_properties
    entityProps.server_position = targetPos
    entityProps.velocity = targetVel
    entityProps.distance = LocalPlayer:DistanceFromCharacter(targetPos)
    entityProps.direction = (Playuh.Entity.properties.server_position - targetPos).Unit
    entityProps.speed = targetVel.Magnitude
    entityProps.is_moving = targetVel.Magnitude > 0.1
    entityProps.dot = entityProps.is_moving and math.max(entityProps.direction:Dot(targetVel.Unit), 0) or 0
end)

ReplicatedStorage.Remotes.PlrHellHooked.OnClientEvent:Connect(function(recall)
    Match.ball.properties.hell_hook_completed = recall.Name ~= LocalPlayer.Name
end)

ReplicatedStorage.Remotes.PlrHellHookCompleted.OnClientEvent:Connect(function()
    Match.ball.properties.hell_hook_completed = true
end)

LocalPlayer.Idled:Connect(function()
    VUser:CaptureController()
    VUser:ClickButton2(Vector2.zero)
end)

local ModRoles = {"content creator", "contributor", "trial qa", "tester", "mod"}
Players.PlayerAdded:Connect(function(player)
    if not Settings.ModDetection then return end
    local role = tostring(player:GetRoleInGroup(12836673)):lower()
    if table.find(ModRoles, role) then
        game:Shutdown()
    end
end)

local isBallOnGame = false
workspace.Balls.ChildRemoved:Connect(function(v)
    isBallOnGame = false
    if v == Match.ball.ball_itself then
        Match.ball.ball_itself = nil
        Match.ball.client_ball_itself = nil
        Match.reset()
    end
end)

workspace.Balls.ChildAdded:Connect(function()
    if isBallOnGame then return end
    isBallOnGame = true

    local props = Match.ball.properties
    props.respawn_time = tick()
    Match.ball.ball_itself = Match.get_ball()
    Match.ball.client_ball_itself = Match.get_client_ball()

    Match.ball.ball_itself:GetAttributeChangedSignal("target"):Connect(function()
        local target = Match.ball.ball_itself:GetAttribute("target")
        if target == LocalPlayer.Name then
            props.cooldown = false
            return
        end
        props.cooldown = false
        props.old_speed = props.speed
        props.last_position = props.position
        props.parries = props.parries + 1
        task.delay(1, function()
            if props.parries > 0 then
                props.parries = props.parries - 1
            end
        end)
    end)
end)

RunService.PreSimulation:Connect(function()
    if not Match.ball.properties.auto_spam then return end
    task.spawn(function()
        for _ = 1, Settings.MaxHits do
            Match.perform_parry()
        end
    end)
end)

ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function(ball, hitEntity)
    if hitEntity.Parent and hitEntity.Parent ~= LocalPlayer.Character then
        if hitEntity.Parent.Parent ~= workspace.Alive then return end
        Match.ball.properties.cooldown = false
    end

    if Match.ball.properties.auto_spam then
        for _ = 1, Settings.MaxHits do
            Match.perform_parry()
        end
    end
end)

ReplicatedStorage.Remotes.ParrySuccess.OnClientEvent:Connect(function()
    if LocalPlayer.Character.Parent ~= workspace.Alive then return end
    if not Playuh.properties.grab_animation then return end

    Playuh.properties.grab_animation:Stop()

    if Match.ball.properties.auto_spam then
        for _ = 1, Settings.MaxHits do
            Match.perform_parry()
        end
    end
end)

task.spawn(function()
    RunService.PostSimulation:Connect(function()
        if not Settings.AutoParry then
            Match.reset()
            return
        end

        local char = LocalPlayer.Character
        if not char or char.Parent == workspace.Dead then
            Match.reset()
            return
        end

        if not Match.ball.ball_itself then return end

        local props = Match.ball.properties
        props.is_curved = Match.is_curved()

        local ping = Playuh.Entity.properties.ping
        local baseAccuracy = 0.51
        local distanceFactor = baseAccuracy * (1 / (Match.entity_properties.distance + 0.01)) * 1000
        local pingFactor = math.clamp(ping / 10, 10, 16)
        local spamAccuracy = math.min(distanceFactor + (props.speed / 8.4), 50 + distanceFactor) + pingFactor

        local parryBaseRange = (props.maximum_speed / 11.7) + pingFactor

        if Playuh.Entity.properties.is_moving then
            parryBaseRange = parryBaseRange * 0.8
        end

        if ping >= 190 then
            parryBaseRange = parryBaseRange * (1 + (ping / 1000))
        end

        props.spam_range = pingFactor + math.min(distanceFactor + (props.speed / 2.3), 50 + distanceFactor)
        props.parry_range = ((parryBaseRange * 1.16) + pingFactor + props.speed) / MinRange

        if Playuh.Entity.properties.sword == "Titan Blade" then
            props.parry_range = props.parry_range + 11
            props.spam_range = props.spam_range + 2
        end

        local lastPosDistance = LocalPlayer:DistanceFromCharacter(props.last_position)

        if props.auto_spam and Match.target.current then
            props.auto_spam = Match.is_spam({
                speed = props.speed,
                spam_accuracy = spamAccuracy,
                parries = props.parries,
                ball_speed = props.speed,
                range = props.spam_range / (3.15 - (pingFactor / 10)),
                last_hit = props.last_hit,
                ball_distance = props.distance,
                maximum_speed = props.maximum_speed,
                old_speed = props.old_speed,
                entity_distance = Match.entity_properties.distance,
                last_position_distance = lastPosDistance,
            })
        end

        if props.auto_spam then return end

        if Match.target.current and Match.target.current.Name == LocalPlayer.Name then
            props.auto_spam = Match.is_spam({
                speed = props.speed,
                spam_accuracy = spamAccuracy,
                parries = props.parries,
                ball_speed = props.speed,
                range = props.spam_range,
                last_hit = props.last_hit,
                ball_distance = props.distance,
                maximum_speed = props.maximum_speed,
                old_speed = props.old_speed,
                entity_distance = Match.entity_properties.distance,
                last_position_distance = lastPosDistance,
            })
        end

        if props.is_curved then return end

        if props.distance > props.parry_range 
            and props.distance > parryBaseRange 
            and props.distance > (props.parry_range * (1 + (ping / 1000)))
            and props.distance > (parryBaseRange * (1 + (ping / 1000))) then
            return
        end

        if Match.target.current and Match.target.current ~= LocalPlayer.Character then
            return
        end

        if Settings.ParryMode == "Legit" then
            if props.distance <= 10 and Match.entity_properties.distance <= 50 then
                if math.random(1, 2) == 1 then
                    Match.perform_parry()
                end
            end
            if props.maximum_speed >= 250 then
                parryBaseRange = parryBaseRange * 1.2
            end
        end

        props.last_sphere_location = props.position
        Match.perform_parry()

        task.spawn(function()
            repeat
                RunService.PreSimulation:Wait()
            until (tick() - props.last_hit) > (1 - (pingFactor / 100))
            props.cooldown = false
        end)
    end)
end)

task.spawn(function()
    pcall(function()
        LocalPlayer.CameraMaxZoomDistance = 1000

        local PopperClient = LocalPlayer.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper

        for _, v in getgc() do
            if type(v) == "function" and getfenv(v).script == PopperClient then
                for i, const in debug.getconstants(v) do
                    if tonumber(const) == 0.25 then
                        debug.setconstant(v, i, 0)
                    elseif tonumber(const) == 0 then
                        debug.setconstant(v, i, 0.25)
                    end
                end
            end
        end

        for _, v in LocalPlayer.Character:GetChildren() do
            if v:IsA("BasePart") or v:IsA("MeshPart") then
                v.CanCollide = false
            end
        end
    end)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or input.KeyCode ~= Enum.KeyCode.L then return end
    local createPrompt = workspace.Spawn 
        and workspace.Spawn.Crates 
        and workspace.Spawn.Crates.NormalSwordCrate
        and workspace.Spawn.Crates.NormalSwordCrate.Lock
        and workspace.Spawn.Crates.NormalSwordCrate.Lock.ProximityPrompt
    if createPrompt then
        fireproximityprompt(createPrompt)
    end
end)

