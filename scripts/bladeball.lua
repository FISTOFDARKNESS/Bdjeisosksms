repeat task.wait() until game:IsLoaded()

local ZoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/FISTOFDARKNESS/Bdjeisosksms/refs/heads/main/scripts/uilib"))()
local window = ZoUI:CreateWindow({Title = "Blade Ball ᵇʸ ᵉˣᶜᵃˡⁱᵇᵘʳ ᵗᵉᵃᵐ"})

local tab1 = window:CreateTab("Home(scroll)")
local autoParryToggle
local autoSpamToggle
local modDetectionToggle
local walkToBallToggle
local maxHitsBox
local walkDistanceBox
local walkConnection

local Settings = {
    ParryMode = "Machine",
    AutoParry = false,
    AutoSpam = false,
    MaxHits = 10,
    AutoCrateSword = false,
    ModDetection = false,
    LowFpsRejoin = false,
    AutoCrateExplosion = false,
    WalkToBall = false,
    WalkDistance = 60,
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local Terrain = workspace:FindFirstChildWhichIsA("Terrain")
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
local HttpService = Services.HttpService
local CONFIG_FILE = "State.json"

local function SaveSettings()
    if not writefile then return end
    local success, err = pcall(function()
        local data = HttpService:JSONEncode(Settings)
        writefile(CONFIG_FILE, data)
    end)
    if not success then
        warn("Erro ao salvar settings:", err)
    end
end

local function LoadSettings()
    if not (readfile and isfile) then return end
    if not isfile(CONFIG_FILE) then return end
    local success, data = pcall(function()
        return readfile(CONFIG_FILE)
    end)
    if not success then return end
    local decoded = HttpService:JSONDecode(data)
    if type(decoded) ~= "table" then return end
    for k, v in pairs(decoded) do
        if Settings[k] ~= nil then
            Settings[k] = v
        end
    end
end

LoadSettings()

local ParryDuration = 0.3
local HitDelayCheck = 0.2
local MinRange = 2

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

local autoCrateLoop = nil
local autoCrateLoop1 = nil
local function toggleAutoCrate(state)
    if Settings.AutoCrateSword then
        autoCrateLoop = task.spawn(function()
            while Settings.AutoCrateSword do
                local createPrompt = workspace.Spawn 
                    and workspace.Spawn.Crates 
                    and workspace.Spawn.Crates.NormalSwordCrate
                    and workspace.Spawn.Crates.NormalSwordCrate.Lock
                    and workspace.Spawn.Crates.NormalSwordCrate.Lock.ProximityPrompt
                
                if createPrompt then
                    fireproximityprompt(createPrompt)
                end
                
                for i = 1, 70 do
                    if not Settings.AutoCrateSword then break end
                    task.wait(0.1)
                end
            end
        end)
    else
        if autoCrateLoop then
            task.cancel(autoCrateLoop)
            autoCrateLoop = nil
        end
    end
end
local lowFpsConnection = nil

local function startFpsMonitor()
    if lowFpsConnection then
        lowFpsConnection:Disconnect()
        lowFpsConnection = nil
    end
    
    local player = Players.LocalPlayer
    local placeId = game.PlaceId
    local jobId = game.JobId
    
    local FPS_LIMITE = 15
    local TEMPO_VERIFICACAO = 5
    local tempoFPSBaixo = 0
    local rejoinado = false
    
    lowFpsConnection = RunService.RenderStepped:Connect(function(dt)
        if rejoinado or not Settings.LowFpsRejoin then
            return
        end
        
        local fps = 1 / dt
        
        if fps < FPS_LIMITE then
            tempoFPSBaixo = tempoFPSBaixo + dt
       
        else
            tempoFPSBaixo = 0
        end
        
        if tempoFPSBaixo >= TEMPO_VERIFICACAO then
            rejoinado = true
         
            local success, errorMsg = pcall(function()
                TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
            end)
            
            if not success then
              
                
                pcall(function()
                    TeleportService:Teleport(placeId, player)
                end)
            end
            
            if lowFpsConnection then
                lowFpsConnection:Disconnect()
                lowFpsConnection = nil
            end
        end
    end)
end

local function stopFpsMonitor()
    if lowFpsConnection then
        lowFpsConnection:Disconnect()
        lowFpsConnection = nil
    end
end
local function toggleAutoCrate1(state)
    if Settings.AutoCrateExplosion then
        autoCrateLoop = task.spawn(function()
            while Settings.AutoCrateExplosion do
                local createPrompt = workspace.Spawn 
                    and workspace.Spawn.Crates 
                    and workspace.Spawn.Crates.NormalExplosionCrate
                    and workspace.Spawn.Crates.NormalExplosionCrate.Lock
                    and workspace.Spawn.Crates.NormalExplosionCrate.Lock.ProximityPrompt
                
                if createPrompt then
                    fireproximityprompt(createPrompt)
                end
                
                for i = 1, 70 do
                    if not Settings.AutoCrateExplosion then break end
                    task.wait(0.1)
                end
            end
        end)
    else
        if autoCrateLoop1 then
            task.cancel(autoCrateLoop1)
            autoCrateLoop1 = nil
        end
    end
end

tab1:AddAutoToggle("Auto Parry", Settings.AutoParry, function(state)
    Settings.AutoParry = state
    SaveSettings()
end)

tab1:AddAutoToggle("Auto Spam", Settings.AutoSpam, function(state)
    Settings.AutoSpam = state
    SaveSettings()
end)

tab1:AddAutoToggle("Mod Detection", Settings.ModDetection, function(state)
    Settings.ModDetection = state
    SaveSettings()
end)

tab1:AddAutoToggle("Follow Ball + Anti-AFK", Settings.WalkToBall, function(state)
    Settings.WalkToBall = state
    SaveSettings()
end)
tab1:AddAutoToggle("Auto Crate Sword", Settings.AutoCrateSword, function(state)
    Settings.AutoCrateSword = state
    SaveSettings()
    toggleAutoCrate(state)
end)
if Settings.AutoCrateSword then
    task.wait(1)
    toggleAutoCrate(true)
end
tab1:AddAutoToggle("Auto Crate  Explosion", Settings.AutoCrateExplosion, function(state)
    Settings.AutoCrateExplosion = state
    SaveSettings()
    toggleAutoCrate1(state)
end)
if Settings.AutoCrateExplosion then
    task.wait(1)
    toggleAutoCrate1(true)
end
tab1:AddAutoToggle("Less Than 15 Fps Rejoin", Settings.LowFpsRejoin, function(state)
    Settings.LowFpsRejoin = state
    SaveSettings()
    if Settings.LowFpsRejoin then
        task.wait(2)
        startFpsMonitor()
    else
        stopFpsMonitor()
    end
end)

if Settings.LowFpsRejoin then
    task.wait(3)
    startFpsMonitor()
end
tab1:AddButton("FPS Boost", function()
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
    local objects = workspace:GetDescendants()
    local index = 1
    local accumulator = 0
    local PARTS_PER_SECOND = 5
    local function processObject(o)
        if o:IsA("BasePart") then
            o.CastShadow = false
            o.Material = Enum.Material.Plastic
            o.Reflectance = 0
        elseif o:IsA("Beam") or o:IsA("Trail") or o:IsA("ParticleEmitter") or o:IsA("Fire") or o:IsA("Smoke") or o:IsA("Sparkles") or o:IsA("Decal") or o:IsA("Texture") or o:IsA("PointLight") or o:IsA("SurfaceAppearance") then
            o:Destroy()
        elseif o:IsA("MeshPart") then
            o.TextureId = ""
            o.MeshId = ""
        end
    end
    RunService.PreRender:Connect(function(deltaTime)
        accumulator = accumulator + deltaTime
        if accumulator >= 1 then
            accumulator = 0
            for i = 1, PARTS_PER_SECOND do
                local obj = objects[index]
                if not obj then break end
                processObject(obj)
                index = index + 1
            end
        end
    end)
    workspace.DescendantAdded:Connect(function(o)
        task.defer(function()
            processObject(o)
        end)
    end)
end)

tab1:AddButton("Server Hop", function()
    loadstring(game:HttpGet("https://pastefy.app/Oa8ml7J4/raw"))()
end)

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
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0.001)
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
    props.is_moving = props.speed > 25
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
if Settings.WalkToBall then
    wait(3)
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
