-- preparing
function getnames()
    for i, v in pairs(game:GetChildren()) do
        if v.ClassName == "Players" then
            return v.Name
        end
    end
end
local players = getnames()
local LP = game:GetService("Players").LocalPlayer
-- esp options
function GetPlayer(String)
   local Found = {}
   if String == "all" then
        for i,v in pairs(game.Players:GetPlayers()) do
            table.insert(Found,v.Name)
        end
   elseif String == "others" then
        for i,v in pairs(game.Players:GetPlayers()) do
            if v.Name ~= game.Players.LocalPlayer.Name then
                table.insert(Found,v.Name)
            end
        end   
    elseif String == "me" then
        for i,v in pairs(game.Players:GetPlayers()) do
            if v.Name == game.Players.LocalPlayer.Name then
                table.insert(Found,v.Name)
            end
        end  
    else
        for i,v in pairs(game.Players:GetPlayers()) do
            if v.Name == String then
                table.insert(Found,v.Name)
            end
        end    
    end
    return Found    
end

local aimfov = 360
PLAYER  = game.Players.LocalPlayer
MOUSE   = PLAYER:GetMouse()
CC      = game.Workspace.CurrentCamera
 
ENABLED      = false
 
_G.FREE_FOR_ALL = false
 
_G.BIND        = 50
_G.CHANGE_AIM  = 'gfdkdfvdgfdgccv'
 
_G.AIM_AT = 'Head'
 
function kill(a)
    local A_1 =
    {
        [1] = {
            ["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-391.152252, 8.65560055, -83.2166901)),
            ["Distance"] = 3.2524313926697,
            ["Cframe"] = CFrame.new(840.310791, 101.334137, 2267.87988, 0.0636406094, 0.151434347, -0.986416459, 0, 0.988420188, 0.151741937, 0.997972965, -0.00965694897, 0.0629036576),
            ["Hit"] = a.Character.Head
        },
        [2] = {
            ["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-392.481476, -8.44939327, -76.7261353)),
            ["Distance"] = 3.2699294090271,
            ["Cframe"] = CFrame.new(840.290466, 101.184189, 2267.93506, 0.0964837447, 0.0589403138, -0.993587971, 4.65661287e-10, 0.998245299, 0.0592165813, 0.995334625, -0.00571343815, 0.0963144377),
            ["Hit"] = a.Character.Head
        },
        [3] = {
            ["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-389.21701, -2.50536323, -92.2163162)),
            ["Distance"] = 3.1665518283844,
            ["Cframe"] = CFrame.new(840.338867, 101.236496, 2267.80371, 0.0166504811, 0.0941716284, -0.995416701, 1.16415322e-10, 0.995554805, 0.0941846818, 0.999861419, -0.00156822044, 0.0165764652),
            ["Hit"] = a.Character.Head
        },
        [4] = {
            ["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-393.353973, 3.13988972, -72.5452042)),
            ["Distance"] = 3.3218522071838,
            ["Cframe"] = CFrame.new(840.277222, 101.285957, 2267.9707, 0.117109694, 0.118740402, -0.985994935, -1.86264515e-09, 0.992826641, 0.119563118, 0.993119001, -0.0140019981, 0.116269611),
            ["Hit"] = a.Character.Head
        },
        [5] = {
            ["RayObject"] = Ray.new(Vector3.new(845.555908, 101.429337, 2269.43945), Vector3.new(-390.73172, 3.2097764, -85.5477524)),
            ["Distance"] = 3.222757101059,
            ["Cframe"] = CFrame.new(840.317993, 101.286423, 2267.86035, 0.0517584644, 0.123365127, -0.991010666, 0, 0.992340803, 0.123530701, 0.99865967, -0.00639375951, 0.0513620302),
            ["Hit"] = a.Character.Head
       }
    }
    local A_2 = game.Players.LocalPlayer.Backpack["Remington 870"]
    local Event = game:GetService("ReplicatedStorage").ShootEvent
    Event:FireServer(A_1, A_2)
    Event:FireServer(A_1, A_2)
end
 
game:GetService('RunService').RenderStepped:connect(function()
    if ENABLED then
        local TARGET = GetNearestPlayerToMouse()
        if (TARGET ~= false) then
            local AIM = TARGET.Character:FindFirstChild(_G.AIM_AT)
            if AIM then
                CC.CoordinateFrame = CFrame.new(CC.CoordinateFrame.p, AIM.CFrame.p)
            end
        end
    end
end)

function GetNearestPlayerToMouse()
    local PLAYERS      = {}
    local PLAYER_HOLD  = {}
    local DISTANCES    = {}
    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= PLAYER then
            table.insert(PLAYERS, v)
        end
    end
    for i, v in pairs(PLAYERS) do
        if _G.FREE_FOR_ALL == false then
            if v and (v.Character) ~= nil and v.TeamColor ~= PLAYER.TeamColor and v.Character.Humanoid.Health > 0 then
                local AIM = v.Character:FindFirstChild(_G.AIM_AT)
                if AIM ~= nil then
                    local DISTANCE                 = (AIM.Position - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude
                    local RAY                      = Ray.new(game.Workspace.CurrentCamera.CoordinateFrame.p, (MOUSE.Hit.p - CC.CoordinateFrame.p).unit * DISTANCE)
                    local HIT,POS                  = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                    local DIFF                     = math.floor((POS - AIM.Position).magnitude)
                    PLAYER_HOLD[v.Name .. i]       = {}
                    PLAYER_HOLD[v.Name .. i].dist  = DISTANCE
                    PLAYER_HOLD[v.Name .. i].plr   = v
                    PLAYER_HOLD[v.Name .. i].diff  = DIFF
                    table.insert(DISTANCES, DIFF)
                end
            end
        elseif _G.FREE_FOR_ALL == true then
            local AIM = v.Character:FindFirstChild(_G.AIM_AT)
            if AIM ~= nil then
                local DISTANCE                 = (AIM.Position - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude
                local RAY                      = Ray.new(game.Workspace.CurrentCamera.CoordinateFrame.p, (MOUSE.Hit.p - CC.CoordinateFrame.p).unit * DISTANCE)
                local HIT,POS                  = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                local DIFF                     = math.floor((POS - AIM.Position).magnitude)
                PLAYER_HOLD[v.Name .. i]       = {}
                PLAYER_HOLD[v.Name .. i].dist  = DISTANCE
                PLAYER_HOLD[v.Name .. i].plr   = v
                PLAYER_HOLD[v.Name .. i].diff  = DIFF
                table.insert(DISTANCES, DIFF)
            end
        end
    end
    
    if unpack(DISTANCES) == nil then
        return false
    end
    
    local L_DISTANCE = math.floor(math.min(unpack(DISTANCES)))
    if L_DISTANCE > aimfov then
        return false
    end
    
    for i, v in pairs(PLAYER_HOLD) do
        if v.diff == L_DISTANCE then
            return v.plr
        end
    end
    return false
end
 
function FIND()
    CLEAR()
    TRACK = true
    spawn(function()
        while wait() do
            if TRACK then
                CLEAR()
                for i,v in pairs(game.Players:GetChildren()) do
                    if v.Character and v.Character:FindFirstChild('Head') then
                        if _G.FREE_FOR_ALL == false then
                            if v.TeamColor ~= PLAYER.TeamColor and v.Character.Humanoid.Health > 0 then
                                if v.Character:FindFirstChild('Head') then
                                    CREATE(v.Character.Head, true)
                                end
                            end
                        else
                            if v.Character:FindFirstChild('Head') then
                                CREATE(v.Character.Head, true)
                            end
                        end
                    end
                end
            end
        end
        wait(1)
    end)
end
-- color
local colors = {
    SchemeColor = Color3.fromRGB(140,0,255),
    Background = Color3.fromRGB(100, 100, 100),
    Header = Color3.fromRGB(0, 0, 0),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(20, 20, 20)
}

-- loading libraries
local ESP = loadstring(game:HttpGet("https://kiriot22.com/releases/ESP.lua"))()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("ScaledHub", colors)

-- tabs
local global = Window:NewTab("Main")
local plife = Window:NewTab("Prison Life")
local mwt = Window:NewTab("MWT")
local arsenal = Window:NewTab("Arsenal")
local aimvisual = Window:NewTab("Aim & Visuals")
local config = Window:NewTab("Config")

-- sections
local main = global:NewSection("Localplayer")
local gunsettings = plife:NewSection("Gun options")
local misc = plife:NewSection("Misc")
local mwt_cfg = mwt:NewSection("Config")
local arsenal_client = arsenal:NewSection("Client")
local arsenal_misc = arsenal:NewSection("Misc")
local mwt_actions = mwt:NewSection("Actions")
local aimssec = aimvisual:NewSection("Aim")
local visualssec = aimvisual:NewSection("Visuals")
local keybinds = config:NewSection("Keybinds")

-- arsenal client
rgbspeed = .0001
arsenal_client:NewToggle("RGB Gun", "rainbow gun", function(state)
    if state then
        local c = 1
        local function zigzag(X)
            return math.acos(math.cos(X * math.pi)) / math.pi
        end
        game:GetService("RunService").RenderStepped:Connect(function()
            if game.Workspace.Camera:FindFirstChild('Arms') then
                for i,v in pairs(game.Workspace.Camera.Arms:GetDescendants()) do
                    if v.ClassName == 'MeshPart' then
                        v.Color = Color3.fromHSV(zigzag(c),1,1)
                        c = c + rgbspeed
                    end
                end
            end
        end)
    else
        local c = 1
        local function zigzag(X)
            return math.acos(math.cos(X * math.pi)) / math.pi
        end
        game:GetService("RunService").RenderStepped:Connect(function()
            if game.Workspace.Camera:FindFirstChild('Arms') then
                for i,v in pairs(game.Workspace.Camera.Arms:GetDescendants()) do
                    if v.ClassName == 'MeshPart' then
                        v.Color = nil
                    end
                end
            end
        end)
    end
end)
arsenal_client:NewDropdown("RGB Speed", "speed of rgb gun", {"Fastest", "Fast", "Normal", "Slow", "Slowest"}, function(currentOption)
    if currentOption == "Fastest" then
        rgbspeed = .1
    elseif currentOption == "Fast" then
        rgbspeed = .05
    elseif currentOption == "Normal" then
        rgbspeed = .002
    elseif currentOption == "Slow" then
        rgbspeed = .0008
    elseif currentOption == "Slowest" then
        rgbspeed = .00005
    end
end)
local hitboxsize = 15
arsenal_misc:NewSlider("Hitbox size", "size", 100, 1, function(s)
    hitboxsize = tonumber(s)
    coroutine.resume(
        coroutine.create(
            function()
                while wait(1) do
                    coroutine.resume(
                        coroutine.create(
                            function()
                                for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                                    if v.Name ~= LP.Name and v.Character.UpperTorso.Color ~= LP.Character.UpperTorso.Color then
                                        v.Character.LowerTorso.CanCollide = false
                                        v.Character.LowerTorso.Material = "Neon"
                                        v.Character.LowerTorso.Transparency = 1
                                        v.Character.LowerTorso.Size = Vector3.new(hitboxsize, hitboxsize, hitboxsize)
                                        v.Character.HumanoidRootPart.Size = Vector3.new(hitboxsize, hitboxsize, hitboxsize)
                                    end
                                end
                            end
                        )
                    )
                end
            end
        )
    )
end)
-- mwt
mwt_cfg:NewTextBox("Nickname", "name 4 actions", function(txt)
    playerforactions = txt
end)
mwt_actions:NewButton("Kill", "kill player", function()
    local script = Instance.new('LocalScript')
    script.Parent = killbtn
    if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then 
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Parent = game.Players.LocalPlayer.Backpack
    end
    
    wait()
    
    local target = GetPlayer(playerforactions)
    
    for i,v in pairs(target) do
        spawn(function()
            local tbl_main = 
            {
                game.Players[v].Character.Humanoid, 
                game.Players[v].Character.HumanoidRootPart, 
                1000, 
                 Vector3.new(0,0,0), 
                0, 
                0, 
                false
            }
            game:GetService("Players").LocalPlayer.Backpack.Handgun["GunScript_Server"].InflictTarget:FireServer(unpack(tbl_main))
        end)
    end
end)
-- aimvisuals
aimssec:NewToggle("Aimbot enabled", "Aims at enemyes automatically.", function(state)
    if state then
        ENABLED = true
    else
        ENABLED = false
    end
end)
aimssec:NewToggle("Aim on key", "Aims when key pressed.", function(state)
    if state then
        aimonkey = true
    else
        aimonkey = false
    end
end)
aimssec:NewToggle("Team check", "FFA Mode.", function(state)
    if state then
        FREE_FOR_ALL = true
    else
        FREE_FOR_ALL = false
    end
end)
aimssec:NewDropdown("Aim at", "Aim spot.", {"Head", "Torso"}, function(currentOption)
    if currentOption == "Head" then
        AIM_AT = "Head"
    else
        AIM_AT = "Torso"
    end
end)
aimssec:NewSlider("Aim FOV", "FOV.", 360, 1, function(s)
    aimfov = s
end)
local mouse = game.Players.LocalPlayer:GetMouse()
local fovcirclerad = 35

local FOVCircle = Drawing.new("Circle")
FOVCircle.Radius = tonumber(fovcirclerad)
FOVCircle.Color = Color3.fromRGB(255, 170, 0)
FOVCircle.Thickness = 3
FOVCircle.Filled = false
FOVCircle.Visible = false

local CircleTbl = {
    Update = function()
        FOVCircle.Position = Vector2.new(mouse.X, mouse.Y+36)
    end
}
table.insert(ESP.Objects, CircleTbl)
-- visualssec
visualssec:NewToggle("ESP", "Wallhack.", function(state)
    if state then
        ESP:Toggle(true)
        espenabled = true
    else
        ESP:Toggle(false)
        espenabled = false
    end
end)
visualssec:NewToggle("Chams", "chams", function(state)
    if state then
        for _,Part in next,Char:children() do
            if Part:IsA('BasePart') and Part.Name~='HumanoidRootPart' then
                local Adornment = Folder:FindFirstChild(Part.Name..'_Cham') or Instance.new('BoxHandleAdornment',Folder)
                if not Folder:FindFirstChild(Part.Name..'_Cham') then
                Adornment.Name = Part.Name..'_Cham'
                Adornment.Adornee = Part
                Adornment.AlwaysOnTop = true
                Adornment.Size = Part.Name=='Head' and Vector3.new(1,1,1) or Part.Size
                Adornment.ZIndex = 1
                end
                Adornment.Color3 = Head.BackgroundColor3
            end
        end
    else
        for _,v in next,Folder:GetDescendants() do
            if v.Name:match('Cham') then
                v:Destroy()
            end
        end
    end
end)
visualssec:NewSlider("Thickness", "thickness", 25, 1, function(s)
    ESP.Thickness = s
end)
visualssec:NewToggle("FaceCamera", "facecam", function(state)
    if state then
        ESP.FaceCamera = true
    else
        ESP.FaceCamera = false
    end
end)
visualssec:NewToggle("Team Color", "team color", function(state)
    if state then
        ESP.TeamColor = true
    else
        ESP.TeamColor = false
    end
end)
visualssec:NewToggle("Box", "boxes", function(state)
    if state then
        ESP.Boxes = true
    else
        ESP.Boxes = false
    end
end)
visualssec:NewToggle("Names", "names", function(state)
    if state then
        ESP.Names = true
    else
        ESP.Names = false
    end
end)
visualssec:NewToggle("Distance", "distance", function(state)
    if state then
        ESP.Distances = true
    else
        ESP.Distances = false
    end
end)
visualssec:NewToggle("Tracers", "tracers", function(state)
    if state then
        ESP.Tracers = true
    else
        ESP.Tracers = false
    end
end)
visualssec:NewToggle("FOV Circle", "FOV", function(state)
    if state then
        FOVCircle.Visible = true
    else
        FOVCircle.Visible = false
    end
end)
visualssec:NewSlider("FOV Circle Radius", "fov circle radius", 180, 1, function(s)
    fovcirclerad = s
end)
-- global
main:NewSlider("WalkSpeed", "Changes localplayer`s walkspeed.", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)
main:NewSlider("JumpPower", "Changes localplayer`s jumppower.", 500, 50, function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)
local teleporterplayer = "target"
local players = game:GetService("Players")
local targetPlayer = players:FindFirstChild(teleporterplayer)
main:NewButton("Teleport", "teleport to player.", function()
    players.LocalPlayer.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position)
end)
main:NewTextBox("Teleport to:", "nickname player to teleport", function(txt)
    teleporterplayer = txt
end)
-- prison life
gunsettings:NewDropdown("Give gun", "Gives the localplayer a gun.", {"M9", "Remington 870", "AK-47", "Handcuffs"}, function(currentOption)
    Workspace.Remote.ItemHandler:InvokeServer(Workspace.Prison_ITEMS.giver[currentOption].ITEMPICKUP)
end)
gunsettings:NewDropdown("Gun modify", "Changes the gun states to max.", {"M9", "Remington 870", "AK-47"}, function(currentOption)
    local player = game:GetService("Players").LocalPlayer
    local gun = player.Backpack:FindFirstChild(currentOption)
    local sM = require(gun:FindFirstChild("GunStates"))
    sM["Damage"] = 13371337
    sM["MaxAmmo"] = 13371337
    sM["StoredAmmo"] = 13371337
    sM["FireRate"] = 0.000001
    sM["AmmoPerClip"] = 15
    sM["Range"] = 5000
    sM["ReloadTime"] = 0.000001
    sM["Bullets"] = 15
    sM["AutoFire"] = true
    sM["Spread"] = 0
end)
gunsettings:NewDropdown("Gun Server Lagger", "Server lags when you shoot.", {"M9", "Remington 870", "AK-47"}, function(currentOption)
    local player = game:GetService("Players").LocalPlayer
    local gun = player.Backpack:FindFirstChild(currentOption)
    local sM = require(gun:FindFirstChild("GunStates"))
    sM["Damage"] = 999999999
    sM["MaxAmmo"] = 999999999
    sM["StoredAmmo"] = 999999999
    sM["FireRate"] = 0.0000001
    sM["AmmoPerClip"] = 999999999
    sM["Range"] = 999999999
    sM["ReloadTime"] = 0.00000001
    sM["Bullets"] = 999999999
    sM["AutoFire"] = true
    sM["Spread"] = 0
end)
misc:NewToggle("Taser bypass", "bypassing taser", function(state)
    if state then
        game:GetService("Players").LocalPlayer.Character.ClientInputHandler.Disabled = true
    else
        game:GetService("Players").LocalPlayer.Character.ClientInputHandler.Disabled = false
    end
end)
misc:NewButton("Arrest all", "arrest all", function()
    local Player = game.Players.LocalPlayer
    local cpos = Player.Character.HumanoidRootPart.CFrame
    for i,v in pairs(game.Teams.Criminals:GetPlayers()) do
        if v.Name ~= Player.Name then
        local i = 10
            repeat
            wait()
            i = i-1
            game.Workspace.Remote.arrest:InvokeServer(v.Character.HumanoidRootPart)
            Player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
            until i == 0
        end
    end
    Player.Character.HumanoidRootPart.CFrame = cpos
end)
misc:NewDropdown("Teleports", "Teleport positions.", {"Out prison"}, function(currentOption)
    if currentOption == "Out prison" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(283, 72, 2213)
    end
end)
misc:NewDropdown("Item giver", "Teleports items to you.", {"Tools", "Guns"}, function(currentOption)
    if currentOption == "Tools" then
        for i, v in pairs(game.Workspace["Prison_ITEMS"].single:GetChildren()) do
            v:MoveTo(game.Players.LocalPlayer.Character.Torso.Position)
        end
    else
        local weapons = {"Remington 870", "M9", "AK-47", "M4A1", "Riot Shield"}
        for i, v in pairs(game.Workspace["Prison_ITEMS"].giver:GetChildren()) do
            for j, k in pairs(weapons) do
                if v.Name == k then
                    v:MoveTo(game.Players.LocalPlayer.Character.Torso.Position)
                end
            end
        end
    end
end)
local power = 1
local carpower = 1
spinbotenabled = false
main:NewToggle("No Collision", "no collision", function(state)
    if state then
        game:GetService('RunService').Stepped:connect(function()
            game.Players.LocalPlayer.Character.Head.CanCollide = false
            game.Players.LocalPlayer.Character.Torso.CanCollide = false
            game.Players.LocalPlayer.Character["Left Leg"].CanCollide = false
            game.Players.LocalPlayer.Character["Right Leg"].CanCollide = false
        end)
    else
        game:GetService('RunService').Stepped:connect(function()
            game.Players.LocalPlayer.Character.Head.CanCollide = true
            game.Players.LocalPlayer.Character.Torso.CanCollide = true
            game.Players.LocalPlayer.Character["Left Leg"].CanCollide = true
            game.Players.LocalPlayer.Character["Right Leg"].CanCollide = true
        end)
    end
end)
local antiaim = false
local aa = "slowspinbot"
main:NewToggle("AntiAim", "AntiAim.", function(state)
    if state then
        antiaim = true
        if aa == "slowspinbot" then
            print("")
        else if aa == "fastspinbot" then
            print("")
        else if aa == "cycle" then
            print("")
        end
        end
        end
    else
        antiaim = false
        game:GetService('RunService').Stepped:connect(function()
            game.Players.LocalPlayer.Character.Head.CanCollide = true
            game.Players.LocalPlayer.Character.Torso.CanCollide = true
            game.Players.LocalPlayer.Character["Left Leg"].CanCollide = true
            game.Players.LocalPlayer.Character["Right Leg"].CanCollide = true
        end)
        game.Players.LocalPlayer.Character.HumanoidRootPart.BodyThrust:Remove()
    end
end)
main:NewDropdown("AntiAim", "Makes localplayer antiaimable.", {"Slow spinbot", "Fast spinbot", "Cycle"}, function(v)
    if v == "Slow spinbot" then
        aa = "slowspinbot"
    else if v == "Fast spinbot" then
        aa = "fastspinbot"
    else if v == "Cycle" then
        aa = "cycle"
    end
    end
    end
end)
main:NewToggle("Spinbot", "makes localplayer spin so fast", function(state)
    if state then
        spinbotenabled = true
        game:GetService('RunService').Stepped:connect(function()
            game.Players.LocalPlayer.Character.Head.CanCollide = false
            game.Players.LocalPlayer.Character.Torso.CanCollide = false
            game.Players.LocalPlayer.Character["Left Leg"].CanCollide = false
            game.Players.LocalPlayer.Character["Right Leg"].CanCollide = false
        end)

        wait(.1)
        local bt = Instance.new("BodyThrust")
        bt.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
        bt.Force = Vector3.new(power,0,power)
        bt.Location = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    else
        game:GetService('RunService').Stepped:connect(function()
            game.Players.LocalPlayer.Character.Head.CanCollide = true
            game.Players.LocalPlayer.Character.Torso.CanCollide = true
            game.Players.LocalPlayer.Character["Left Leg"].CanCollide = true
            game.Players.LocalPlayer.Character["Right Leg"].CanCollide = true
        end)
        spinbotenabled = false
        game.Players.LocalPlayer.Character.HumanoidRootPart.BodyThrust:Remove()
    end
end)
main:NewSlider("Spinbot speed", "Speed.", 256, 1, function(s)
    power = s
end)
main:NewToggle("Car Spinbot", "makes car spin so fast", function(state)
    if state then
        spinbotenabled = true
        game:GetService('RunService').Stepped:connect(function()
            game.Players.LocalPlayer.Character.Head.CanCollide = false
            game.Players.LocalPlayer.Character.Torso.CanCollide = false
            game.Players.LocalPlayer.Character["Left Leg"].CanCollide = false
            game.Players.LocalPlayer.Character["Right Leg"].CanCollide = false
        end)

        wait(.1)
        local bt = Instance.new("BodyThrust")
        bt.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
        bt.Force = Vector3.new(carpower,ypower,carpower)
        bt.Location = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    else
        game:GetService('RunService').Stepped:connect(function()
            game.Players.LocalPlayer.Character.Head.CanCollide = true
            game.Players.LocalPlayer.Character.Torso.CanCollide = true
            game.Players.LocalPlayer.Character["Left Leg"].CanCollide = true
            game.Players.LocalPlayer.Character["Right Leg"].CanCollide = true
        end)
        spinbotenabled = false
        game.Players.LocalPlayer.Character.HumanoidRootPart.BodyThrust:Remove()
    end
end)
main:NewSlider("Car Spinbot speed", "Speed.", 256, 1, function(s)
    carpower = s
end)
local ypower = 1
main:NewSlider("Car Spinbot Y", "Y Speed.", 100, 1, function(s)
    ypower = s
end)
-- misc
misc:NewToggle("Garage", "You can open and close the garage.", function(state)
    if state then
        workspace.Remote.ItemHandler:InvokeServer(unpack({
            [1] = workspace["Prison_ITEMS"].buttons["Garage Buttons"].open,
        }))
    else
        workspace.Remote.ItemHandler:InvokeServer(unpack({
            [1] = workspace["Prison_ITEMS"].buttons["Garage Buttons"].close,
        }))
    end
end)
misc:NewButton("No doors", "Removes doors.", function()
    game.Workspace.Doors:Destroy()
end)
misc:NewButton("No walls", "Removes walls", function()
    game.Workspace.Prison_Guard_Outpost:Remove()
    game.Workspace.Prison_Cafeteria.building:Remove()
    game.Workspace.Prison_Cafeteria.glass:Remove()
    game.Workspace.Prison_Cafeteria.oven:Remove()
    game.Workspace.Prison_Cafeteria.shelves:Remove()
    game.Workspace.Prison_Cafeteria.vents:Remove()
    game.Workspace.Prison_Cafeteria.accents:Remove()
    game.Workspace.Prison_Cafeteria.vendingmachine:Remove()
    game.Workspace.Prison_Cafeteria.Prison_table1:Remove()
    game.Workspace.Prison_Cafeteria.counter:Remove()
    game.Workspace.Prison_Cafeteria.boxes:Remove()
end)
misc:NewDropdown("Team Changer", "Switch your team.", {"Police", "Prisoner"}, function(currentOption)
    if currentOption == "Police" then
        Workspace.Remote.TeamEvent:FireServer("Bright orange")
    elseif currentOption == "Prisoner" then
        Workspace.Remote.TeamEvent:FireServer("Bright blue")
    end
end)
-- config
keybinds:NewKeybind("Menu", "Toggles UI.", Enum.KeyCode.Z, function()
    Library:ToggleUI()
end)
keybinds:NewKeybind("Aimbot", "Aims at enemyes.", Enum.KeyCode.F, function()
    if aimonkey == true then
        ENABLED = true
    else
        ENABLED = false
    end
end)
keybinds:NewKeybind("ESP", "Wallhack keybind.", Enum.KeyCode.V, function()
    if espenabled == true then
        ESP:Toggle(true)
        espenabled = true
    else
        ESP:Toggle(false)
        espenabled = false
    end
end)
