local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = " TSB | EXCALIBUR TEAM",
   LoadingTitle = "TSB | EXCALIBUR TEAM",
   LoadingSubtitle = "getbetterstopusingcheatstowin😂😂😂😂",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = "6",
      FileName = "6"
   },
   Discord = {
      Enabled = true,
      Invite = "Vqt5U2fSNK",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "s | excalibur team",
      Subtitle = "Key System",
      Note = "Key In Discord Server",
      FileName = "3.1",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {"EXS_fca1af98bbfc4794aceec0ec96fa933a"}
   }
})

Rayfield:Notify({
   Title = "Thank you for using my script",
   Content = "Join MY Discord https://discord.gg/NVF8ZFXgdJ",
   Duration = 6.5,
   Image = 15108758568,
   Actions = {
      Ignore = {
         Name = "Okay!",
         Callback = function()
                     setclipboard("https://discord.gg/NVF8ZFXgdJ")
toclipboard("https://discord.gg/NVF8ZFXgdJ")
         end
      }
   },
})

local MainTab1 = Window:CreateTab("YourSelf", nil)
local MainSection1 = MainTab1:CreateSection("Home page")

local Button2 = MainTab1:CreateButton({
    Name = "Create a Part",
    Callback = function()
        local part = Instance.new("Part")
        part.Size = Vector3.new(2500, 1, 2500)
        part.Position = Vector3.new(0, -300, 0)
        part.Anchored = true
        part.CanCollide = true
        part.Color = Color3.fromRGB(255, 0, 0)
        part.Parent = game.Workspace
    end,
})

local Slider = MainTab1:CreateSlider({
   Name = "Speed Power",
   Range = {16, 1000},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      if character then
         local humanoid = character:FindFirstChild("Humanoid") or character:WaitForChild("Humanoid")
         if humanoid then
            humanoid.WalkSpeed = Value
         end
      end
   end,
})

local JumpPowerSlider = MainTab1:CreateSlider({
   Name = "JumpPower Power",
   Range = {50, 1000},
   Increment = 5,
   Suffix = "JumpPower",
   CurrentValue = 50,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
      local player = game.Players.LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      if character then
         local humanoid = character:WaitForChild("Humanoid")
         humanoid.JumpPower = Value
      end
   end,
})

local Button = MainTab1:CreateButton({
    Name = "Reset Character",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0
        end
    end,
})

local Dropdown = MainTab1:CreateDropdown({
    Name = "Camera Lock",
    Options = {"Locked Camera", "Unlocked Camera"},
    CurrentOption = {"Unlocked Camera"},
    MultipleOptions = false,
    Flag = "CameraLockDropdown",
    Callback = function(Options)
        local player = game.Players.LocalPlayer
        local camera = game.Workspace.CurrentCamera
        if Options[1] == "Unlocked Camera" then
            local character = player.Character or player.CharacterAdded:Wait()
            camera.CameraSubject = character.Humanoid
            camera.CameraType = Enum.CameraType.Custom
        elseif Options[1] == "Locked Camera" then
            camera.CameraSubject = player.Character:FindFirstChild("Humanoid") or character.Humanoid
            camera.CameraType = Enum.CameraType.Scriptable
            camera.CFrame = camera.CFrame
        end
    end,
})

local Toggle = MainTab1:CreateToggle({
    Name = "Toggle No-Clip",
    CurrentValue = false,
    Flag = "ToggleNoClip",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        if Value then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        else
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end,
})
local MainPc = Window:CreateTab("Keyboard Version" , nil)

local Keybind = MainPc:CreateKeybind({
   Name = "Tp Void",
   CurrentKeybind = "E",
   HoldToInteract = false,
   Flag = "Keybind", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Keybind)

local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local previousPosition = hrp.Position
            hrp.CFrame = CFrame.new(5000, -280, 999)
            local part = Instance.new("Part")
        part.Size = Vector3.new(2500, 1, 2500)
        part.Position = Vector3.new(5000, -281, 999)
        part.Anchored = true
        part.CanCollide = true
        part.Color = Color3.fromRGB(255, 0, 0)
        part.Parent = game.Workspace
            task.wait(1.4)
            hrp.CFrame = CFrame.new(previousPosition)
        end
    end
})

local Keybind1 = MainPc:CreateKeybind({
   Name = "Tp Heaven",
   CurrentKeybind = "R",
   HoldToInteract = false,
   Flag = "Keybind1",
   Callback = function(Keybind)
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local previousPosition = hrp.Position
            hrp.CFrame = CFrame.new(hrp.Position.X, 999999989, hrp.Position.Z)
            local part = Instance.new("Part")
            part.Size = Vector3.new(2500, 1, 2500)
            part.Position = Vector3.new(hrp.Position.X, 999999988, hrp.Position.Z)
            part.Anchored = true
            part.CanCollide = true
            part.Color = Color3.fromRGB(255, 0, 0)
            part.Transparency = 0.8
            part.Parent = game.Workspace
            task.wait(1.4)
            hrp.CFrame = CFrame.new(previousPosition)
        end
    end
})
local Keybind3 = MainPc:CreateKeybind({
    Name = "Tp Void(safe mode)",
    CurrentKeybind = "C",
    HoldToInteract = false,
    Flag = "Keybind3",
    Callback = function(Keybind)
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local previousPosition = hrp.Position
            
            hrp.CFrame = CFrame.new(hrp.Position.X, -280, hrp.Position.Z)
            
            task.wait(25)
            game.StarterGui:SetCore("SendNotification", {
                Title = "Warning!",
                Text = "You will return in 5 seconds!",
                Duration = 5
            })
            
            task.wait(5)
            hrp.CFrame = CFrame.new(previousPosition)
        end
    end
})

local Keybind4 = MainPc:CreateKeybind({
   Name = "Combo Garou",
   CurrentKeybind = "X",
   HoldToInteract = false,
   Flag = "Keybind4",
   Callback = function(Keybind)
loadstring(game:HttpGet("https://pastebin.com/raw/r9B6mnR8"))()
    end
})


local MainTab2 = Window:CreateTab("Players", nil)
local MainSection2 = MainTab2:CreateSection("")

local Toggle = MainTab2:CreateButton({
   Name = "ESP players",
   Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP'))()
   end,
})

local buttonSafe = MainTab2:CreateButton({
    Name = "tp void (safe mode)",
    Callback = function()
              local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local previousPosition = hrp.Position
            
            hrp.CFrame = CFrame.new(999, -280, hrp.Position.Z)
            
            task.wait(25)
            game.StarterGui:SetCore("SendNotification", {
                Title = "Warning!",
                Text = "You will return in 5 seconds!",
                Duration = 5
            })
            
            task.wait(5)
            hrp.CFrame = CFrame.new(previousPosition)
        end
    end
})

local buttonTop = MainTab2:CreateButton({
    Name = "tp Heaven",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local previousPosition = hrp.Position
            hrp.CFrame = CFrame.new(hrp.Position.X, 99999999, hrp.Position.Z)
            task.wait(1.4)
            hrp.CFrame = CFrame.new(previousPosition)
        end
    end
})

local buttonLock = MainTab2:CreateButton({
    Name = "Teleport Frozen Lock",
    Callback = function()
        local TeleportPart = game.Workspace.Thrown:FindFirstChild("Frozen Lock").Root
        local player = game.Players.LocalPlayer
        
        if TeleportPart then
            local character = player.Character or player.CharacterAdded:Wait()
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = TeleportPart.CFrame + Vector3.new(0, 3, 0)
            end
        else
            -- Wait for the Frozen Lock to be found if it's not immediately available
            local frozenLockFound = game.Workspace.Thrown:WaitForChild("Frozen Lock", 5)
            if frozenLockFound then
                local character = player.Character or player.CharacterAdded:Wait()
                if character and character:FindFirstChild("HumanoidRootPart") then
                    character.HumanoidRootPart.CFrame = frozenLockFound.CFrame + Vector3.new(0, 3, 0)
                end
            else
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Error",
                    Text = "Frozen Lock not found or coming!",
                    Duration = 3
                })
            end
        end
    end
})
local buttonLock = MainTab2:CreateButton({
    Name = "Combo Garou",
    Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/r9B6mnR8"))()
    end
})
local Buttonvisual = MainTab2:CreateButton({
    Name = "Visuals",
    Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/RK9tPECe"))()
    end
})
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function getPlayerNames()
    local names = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(names, player.Name)
        end
    end
    return names
end

local function returnCameraToDefault(originalCFrame)
    task.wait(5)
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(Camera, tweenInfo, {CFrame = originalCFrame})
    tween:Play()
end

local Dropdown = MainTab2:CreateDropdown({
    Name = "Select Player to Focus",
    Options = getPlayerNames(),
    CurrentOption = nil,
    MultipleOptions = false,
    Flag = "PlayerDropdown",
    Callback = function(selectedOptions)
        local selectedPlayerName = selectedOptions[1]
        local selectedPlayer = Players:FindFirstChild(selectedPlayerName)
        if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetPosition = selectedPlayer.Character.HumanoidRootPart.Position
            local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local originalCFrame = Camera.CFrame
            local tween = TweenService:Create(Camera, tweenInfo, {
                CFrame = CFrame.new(targetPosition + Vector3.new(0, 5, -10), targetPosition)
            })
            tween:Play()
            returnCameraToDefault(originalCFrame)
        end
    end,
})

Players.PlayerAdded:Connect(function()
    Dropdown:SetOptions(getPlayerNames())
end)

Players.PlayerRemoving:Connect(function()
    Dropdown:SetOptions(getPlayerNames())
end)

local function getPlayerNames()
    local playerNames = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(playerNames, player.Name)
    end
    return playerNames
end

local Dropdown = MainTab2:CreateDropdown({
   Name = "Teleport to player",
   Options = getPlayerNames(),
   CurrentOption = {game.Players.LocalPlayer.Name},
   MultipleOptions = false,
   Flag = "Dropdown1",
   Callback = function(Options)
       local playerName = Options[1]
       local targetPlayer = game.Players:FindFirstChild(playerName)
       if targetPlayer then
           local character = game.Players.LocalPlayer.Character
           if character and targetPlayer.Character then
               local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
               character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
           end
       else
           warn("Player not found!")
       end
   end,
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer

local function getPlayerNames()
    local playerNames = {}
    for _, player in pairs(Players:GetPlayers()) do
        table.insert(playerNames, player.Name)
    end
    return playerNames
end

local function sendNotification(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 3
    })
end

local Dropdown = MainTab2:CreateDropdown({
    Name = "Select a Player",
    Options = getPlayerNames(),
    CurrentOption = {LocalPlayer.Name},
    MultipleOptions = false,
    Flag = "Dropdown1",
    Callback = function(Options)
        local playerName = Options[1]
        local targetPlayer = Players:FindFirstChild(playerName)
 
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local humanoidRootPart = character.HumanoidRootPart

                sendNotification("Following", "Following " .. playerName .. " for 2 seconds...", 5)

                local tool = LocalPlayer.Backpack:FindFirstChild("Flowing Water")
                if tool then
                    task.wait(0.5)
                    local liveCharacter = workspace.Live[LocalPlayer.Name]
                    if liveCharacter and liveCharacter:FindFirstChild("Communicate") then
                        liveCharacter.Communicate:FireServer({
                            ["Tool"] = tool,
                            ["Goal"] = "Console Move"
                        })
                        sendNotification("Command Sent", "Executed: Console Move with Flowing water", 3)
                    else
                        sendNotification("Erro", "Unable to execute command.", 3)
                    end
                else
                    sendNotification("Erro", "You dont have the Flowing water! Get better", 3)
                end

                local startTime = tick()
                local followConnection

                followConnection = RunService.RenderStepped:Connect(function()
                    if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
                        local offset = Vector3.new(0, 0, -2)
                        humanoidRootPart.CFrame = CFrame.new(targetPosition + offset)
                    end

                    if tick() - startTime >= 2 then
                        followConnection:Disconnect()
                        sendNotification("Unfollowed", "Unfollowed " .. playerName .. ".", 3)
                    end
                end)
                task.wait(5)
                Dropdown:SetOptions(getPlayerNames())
            end
        else
            sendNotification("Erro", "Player not found or invalid or not in game!", 3)
        end
    end,
})

Players.PlayerAdded:Connect(function()
    Dropdown:SetOptions(getPlayerNames())
end)

Players.PlayerRemoving:Connect(function()
    Dropdown:SetOptions(getPlayerNames())
end)

task.spawn(function()
    while true do
        task.wait(15)
        Dropdown:SetOptions(getPlayerNames())
    end
end)

local Config = Window:CreateTab("Config/Optimization", nil)

 local Toggle = Config:CreateToggle({
    Name = "Ant ban/kick (Rejoin every 18min)",
    CurrentValue = false,
    Flag = "ToggleLeaveGame",
    Callback = function(Value)
        if Value then
            local RunService = game:GetService("RunService")
            local TeleportService = game:GetService("TeleportService")
            local timer = 0

            RunService.Heartbeat:Connect(function()
                if Value then
                    timer = timer + game:GetService("RunService").Heartbeat:Wait()
                    if timer >= 1080 then
                        TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer)
                    end
                end
            end)
        end
    end,
})
local Toggle = Config:CreateToggle({
    Name = "Clouds",
    CurrentValue = false,
    Flag = "ToggleLeaveGame",
    Callback = function(Value)
        if Value then
            game.workspace.Terrain.Clouds.Density = 0
        else
            game.workspace.Terrain.Clouds.Density = 1
        end
    end,
})
local originalSettings = {}

local Toggle = Config:CreateToggle({
    Name = "Low gfx",
    CurrentValue = false,
    Flag = "ToggleLeaveGame",
    Callback = function(Value)
        if Value then
            -- Save original settings before changing
            for _, object in pairs(workspace:GetDescendants()) do
                if object:IsA("BasePart") then
                    originalSettings[object] = {
                        Material = object.Material,
                        CastShadow = object.CastShadow,
                        Reflectance = object.Reflectance
                    }

                    -- Apply low graphics settings
                    object.Material = Enum.Material.SmoothPlastic
                    object.CastShadow = false  -- Remove shadows
                    object.Reflectance = 0      -- Remove reflections
                end
            end

            local sky = game.Lighting:FindFirstChildOfClass("Sky")
            if sky then
                originalSettings.sky = {
                    SunTextureId = sky.SunTextureId,
                    MoonTextureId = sky.MoonTextureId
                }

                sky.SunTextureId = ""
                sky.MoonTextureId = ""
            end
        else
            -- Reset to original settings
            for object, settings in pairs(originalSettings) do
                if object:IsA("BasePart") then
                    object.Material = settings.Material
                    object.CastShadow = settings.CastShadow
                    object.Reflectance = settings.Reflectance
                end
            end

            local sky = game.Lighting:FindFirstChildOfClass("Sky")
            if sky and originalSettings.sky then
                sky.SunTextureId = originalSettings.sky.SunTextureId
                sky.MoonTextureId = originalSettings.sky.MoonTextureId
            end
        end
    end,
})

local originalVFX = {}

local Toggle = Config:CreateToggle({
    Name = "No effects (Only beams)",
    CurrentValue = false,
    Flag = "ToggleLeaveGame",
    Callback = function(Value)
        if Value then
            -- Function to delete VFX
            local function deleteVFX(obj)
                if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") or obj:IsA("Attachment") or obj:IsA("Explosion") then
                    obj:Destroy()
                end
            end

            -- Remove all VFX and store them for later restoration
            workspace.DescendantAdded:Connect(function(obj)
                if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") or obj:IsA("Attachment") or obj:IsA("Explosion") then
                    -- Store the original VFX object
                    table.insert(originalVFX, obj)
                    deleteVFX(obj)
                end
            end)

            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") or obj:IsA("Attachment") or obj:IsA("Explosion") then
                    -- Store the original VFX object
                    table.insert(originalVFX, obj)
                    deleteVFX(obj)
                end
            end
        else
            -- Restore original VFX objects
            for _, vfx in pairs(originalVFX) do
                if vfx.Parent == nil then
                    -- VFX was destroyed, need to recreate it
                    -- Example: Recreate the object (you'll need to adjust based on your setup)
                    local newVFX = vfx:Clone()  -- Clone the original VFX
                    newVFX.Parent = workspace  -- Set parent back to the correct location
                end
            end
            -- Clear the stored VFX references
            originalVFX = {}
        end
    end,
})
local Toggle = Config:CreateToggle({  
    Name = "Anti fall in void",  
    CurrentValue = false,  
    Flag = "ToggleLeaveGame",  
    Callback = function(Value)  
        if Value then  
            -- Detect when the player's Y position is below -270
            game:GetService("RunService").Heartbeat:Connect(function()
                local player = game.Players.LocalPlayer
                if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local humanoidRootPart = player.Character.HumanoidRootPart
                    if humanoidRootPart.Position.Y < -310 then
                        -- Teleport the player to Y = 0
                        humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position.X, 0, humanoidRootPart.Position.Z)
                    end
                end
            end)
        else
            -- Stop the teleportation if the toggle is off
            game:GetService("RunService").Heartbeat:Disconnect()  -- Disconnects the heartbeat event
        end  
    end,  
})
local  sjdks = Config:CreateButton({
   Name = "Re-Open",
   Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/V1cVsKz7"))()
   end,
})
