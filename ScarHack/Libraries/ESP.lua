--Drawing
if Drawing == nil then
    Drawing = {}
    
    local game = game
    local GetService, FindFirstChild = game.GetService, game.FindFirstChild
    local IsA = game.IsA
    local Vector2new, Instancenew, UDim2new = Vector2.new, Instance.new, UDim2.new
    
    local Workspace = GetService(game, "Workspace");
    local Camera = FindFirstChild(Workspace, "Camera");
    local CoreGui = GetService(game, "CoreGui");
    
    local BaseDrawingProperties = setmetatable({
        Visible = false,
        Color = Color3.new(),
        Transparency = 0,
        Remove = function()
        end
    }, {
        __add = function(tbl1, tbl2)
            local new = {}
            for i, v in next, tbl1 do
                new[i] = v
            end
            for i, v in next, tbl2 do
                new[i] = v
            end
            return new
        end
    })
    
    Drawing.new = function(Type, UI)
        UI = UI and IsA(UI, "ScreenGui") and UI or Instancenew("ScreenGui", CoreGui) or Instancenew("ScreenGui", CoreGui);
    
        if (Type == "Line") then
            local LineProperties = ({
                To = Vector2new(),
                From = Vector2new(),
                Thickness = 1,
            } + BaseDrawingProperties)
    
            local LineFrame = Instancenew("Frame");
            LineFrame.AnchorPoint = Vector2new(0.5, 0.5);
            LineFrame.BorderSizePixel = 0
    
            LineFrame.BackgroundColor3 = LineProperties.Color
            LineFrame.Visible = LineProperties.Visible
            LineFrame.BackgroundTransparency = LineProperties.Transparency
    
    
            LineFrame.Parent = UI
    
            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "To") then
                        local To = Value
                        local Direction = (To - LineProperties.From);
                        local Center = (To + LineProperties.From) / 2
                        local Distance = Direction.Magnitude
                        local Theta = math.atan2(Direction.Y, Direction.X);
    
                        LineFrame.Position = UDim2.fromOffset(Center.X, Center.Y);
                        LineFrame.Rotation = math.deg(Theta);
                        LineFrame.Size = UDim2.fromOffset(Distance, LineProperties.Thickness);
    
                        LineProperties.To = To
                    end
                    if (Property == "From") then
                        local From = Value
                        local Direction = (LineProperties.To - From);
                        local Center = (LineProperties.To + From) / 2
                        local Distance = Direction.Magnitude
                        local Theta = math.atan2(Direction.Y, Direction.X);
    
                        LineFrame.Position = UDim2.fromOffset(Center.X, Center.Y);
                        LineFrame.Rotation = math.deg(Theta);
                        LineFrame.Size = UDim2.fromOffset(Distance, LineProperties.Thickness);
    
    
                        LineProperties.From = From
                    end
                    if (Property == "Visible") then
                        LineFrame.Visible = Value
                        LineProperties.Visible = Value
                    end
                    if (Property == "Thickness") then
                        Value = Value < 1 and 1 or Value
    
                        local Direction = (LineProperties.To - LineProperties.From);
                        local Distance = Direction.Magnitude
    
                        LineFrame.Size = UDim2.fromOffset(Distance, Value);
    
                        LineProperties.Thickness = Value
                    end
                    if (Property == "Transparency") then
                        LineFrame.BackgroundTransparency = 1 - Value
                        LineProperties.Transparency = Value
                    end
                    if (Property == "Color") then
                        LineFrame.BackgroundColor3 = Value
                        LineProperties.Color = Value 
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            LineFrame:Destroy();
                        end)
                    end
                    return LineProperties[Property]
                end)
            })
        end
    
        if (Type == "Circle") then
            local CircleProperties = ({
                Radius = 150,
                Filled = false,
                Position = Vector2new()
            } + BaseDrawingProperties)
    
            local CircleFrame = Instancenew("Frame");
    
            CircleFrame.AnchorPoint = Vector2new(0.5, 0.5);
            CircleFrame.BorderSizePixel = 0
    
            CircleFrame.BackgroundColor3 = CircleProperties.Color
            CircleFrame.Visible = CircleProperties.Visible
            CircleFrame.BackgroundTransparency = CircleProperties.Transparency
    
            local Corner = Instancenew("UICorner", CircleFrame);
            Corner.CornerRadius = UDim.new(1, 0);
            CircleFrame.Size = UDim2new(0, CircleProperties.Radius, 0, CircleProperties.Radius);
    
            CircleFrame.Parent = UI
    
            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Radius") then
                        CircleFrame.Size = UDim2new(0, Value, 0, Value);
                        CircleProperties.Radius = Value
                    end
                    if (Property == "Position") then
                        CircleFrame.Position = UDim2new(0, Value.X, 0, Value.Y);
                        CircleProperties.Position = Value
                    end
                    if (Property == "Filled") then
                        CircleFrame.BackgroundTransparency = Value == true and 0 or 0.8
                        CircleProperties.Filled = Value
                    end
                    if (Property == "Color") then
                        CircleFrame.BackgroundColor3 = Value
                        CircleProperties.Color = Value
                    end
                    if (Property == "Visible") then
                        CircleFrame.Visible = Value
                        CircleProperties.Visible = Value
                    end
                    if (Property == "Transparency") then
    
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            CircleFrame:Destroy();
                        end)
                    end
                    
                    return CircleProperties[Property]
                end)
            })
        end
    
        if (Type == "Text") then
            local TextProperties = ({
                Text = "",
                Size = 0,
                Center = false,
                Outline = false,
                OutlineColor = Color3.new(),
                Position = Vector2new(),
            } + BaseDrawingProperties)
    
            local TextLabel = Instancenew("TextLabel");
    
            TextLabel.AnchorPoint = Vector2new(0.5, 0.5);
            TextLabel.BorderSizePixel = 0
            TextLabel.Size = UDim2new(0, 200, 0, 50);
            TextLabel.Font = Enum.Font.SourceSans
            TextLabel.TextSize = 14
    
            TextLabel.TextColor3 = TextProperties.Color
            TextLabel.Visible = TextProperties.Visible
            TextLabel.BackgroundTransparency = 1
            TextLabel.TextTransparency = 1 - TextProperties.Transparency
            
            TextLabel.Parent = UI
    
            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Text") then
                        TextLabel.Text = Value
                        TextProperties.Text = Value
                    end
                    if (Property == "Position") then
                        TextLabel.Position = UDim2new(0, Value.X, 0, Value.Y);
                        TextProperties.Position = Value
                    end
                    if (Property == "Size") then
                        TextLabel.TextSize = Value
                        TextProperties.Size = Value
                    end
                    if (Property == "Color") then
                        TextLabel.TextColor3 = Value
                        TextProperties.Color = Value
                    end
                    if (Property == "Transparency") then
                        TextLabel.TextTransparency = 1 - Value
                        TextProperties.Transparency = Value
                    end
                    if (Property == "Visible") then
                        TextLabel.Visible = Value
                        TextProperties.Visible = Value
                    end
                    if (Property == "Center") then
                        TextLabel.Position = Value == true and UDim2new(0, Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2, 0)
                        TextProperties.Center = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            TextLabel:Destroy();
                        end)
                    end
                    
                    return TextProperties[Property]
                end)
            })
        end
    
        if (Type == "Square") then
            local SquareProperties = ({
                Thickness = 1,
                Size = Vector2new(),
                Position = Vector2new(),
                Filled = false,
            } + BaseDrawingProperties);
    
            local SquareFrame = Instancenew("Frame");
            
            SquareFrame.AnchorPoint = Vector2new(0.5, 0.5);
            SquareFrame.BorderSizePixel = 0
    
            SquareFrame.Visible = false
            SquareFrame.Parent = UI
    
            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Size") then
                        SquareFrame.Size = UDim2new(0, Value.X, 0, Value.Y);
                        SquareProperties.Text = Value
                    end
                    if (Property == "Position") then
                        SquareFrame.Position = UDim2new(0, Value.X, 0, Value.Y);
                        SquareProperties.Position = Value
                    end
                    if (Property == "Size") then
                        SquareFrame.Size = UDim2new(0, Value.X, 0, Value.Y);
                        SquareProperties.Size = Value
                    end
                    if (Property == "Color") then
                        SquareFrame.BackgroundColor3 = Value
                        SquareProperties.Color = Value
                    end
                    if (Property == "Transparency") then
                        SquareFrame.BackgroundTransparency = 1 - Value
                        SquareProperties.Transparency = Value
                    end
                    if (Property == "Visible") then
                        SquareFrame.Visible = Value
                        SquareProperties.Visible = Value
                    end
                    if (Property == "Filed") then -- requires beta
    
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            SquareFrame:Destroy();
                        end)
                    end
                    
                    return SquareProperties[Property]
                end)
            })
        end
    
        if (Type == "Image") then
            local ImageProperties = ({
                Data = "rbxassetid://848623155", -- roblox assets only rn
                Size = Vector2new(),
                Position = Vector2new(),
                Rounding = 0,
            });
    
            local ImageLabel = Instancenew("ImageLabel");
    
            ImageLabel.AnchorPoint = Vector2new(0.5, 0.5);
            ImageLabel.BorderSizePixel = 0
            ImageLabel.ScaleType = Enum.ScaleType.Stretch
            ImageLabel.Transparency = 1
            
            ImageLabel.Visible = false
            ImageLabel.Parent = UI
    
            return setmetatable({}, {
                __newindex = (function(self, Property, Value)
                    if (Property == "Size") then
                        ImageLabel.Size = UDim2new(0, Value.X, 0, Value.Y);
                        ImageProperties.Text = Value
                    end
                    if (Property == "Position") then
                        ImageLabel.Position = UDim2new(0, Value.X, 0, Value.Y);
                        ImageProperties.Position = Value
                    end
                    if (Property == "Size") then
                        ImageLabel.Size = UDim2new(0, Value.X, 0, Value.Y);
                        ImageProperties.Size = Value
                    end
                    if (Property == "Transparency") then
                        ImageLabel.ImageTransparency = 1 - Value
                        ImageProperties.Transparency = Value
                    end
                    if (Property == "Visible") then
                        ImageLabel.Visible = Value
                        ImageProperties.Visible = Value
                    end
                    if (Property == "Color") then
                        ImageLabel.ImageColor3 = Value
                        ImageLabel.Color = Value
                    end
                    if (Property == "Data") then
                        ImageLabel.Image = Value
                        ImageProperties.Data = Value
                    end
                end),
                __index = (function(self, Property)
                    if (Property == "Remove") then
                        return (function()
                            ImageLabel:Destroy();
                        end)
                    end
                    
                    return ImageLabel[Property]
                end)
            })
        end
    
    
        if (Type == "Quad") then -- will add later
            return setmetatable({}, {
                
            });
        end
    end
end

--Settings--
local ESP = {
    Enabled = false,
    Boxes = false,
    BoxShift = CFrame.new(0,-1.5,0),
    BoxSize = Vector3.new(4,6,0),
    Color = Color3.fromRGB(255, 170, 0),
    FaceCamera = false,
    Names = false,
    TeamColor = false,
    Thickness = 1,
    AttachShift = 1,
    TeamMates = false,
    Players = false,
    Distances = false,
    Objects = setmetatable({}, {__mode="kv"}),
    Overrides = {},
    Health = false
}

--Declarations--
local cam = workspace.CurrentCamera
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()

local V3new = Vector3.new
local WorldToViewportPoint = cam.WorldToViewportPoint

--Functions--
local function Draw(obj, props)
    local new = Drawing.new(obj)
    
    props = props or {}
    for i,v in pairs(props) do
        new[i] = v
    end
    return new
end

function ESP:GetTeam(p)
    local ov = self.Overrides.GetTeam
    if ov then
        return ov(p)
    end
    
    return p and p.Team
end

function ESP:IsTeamMate(p)
    local ov = self.Overrides.IsTeamMate
    if ov then
        return ov(p)
    end
    
    return self:GetTeam(p) == self:GetTeam(plr)
end

function ESP:GetColor(obj)
    local ov = self.Overrides.GetColor
    if ov then
        return ov(obj)
    end
    local p = self:GetPlrFromChar(obj)
    return p and self.TeamColor and p.Team and p.Team.TeamColor.Color or self.Color
end

function ESP:GetPlrFromChar(char)
    local ov = self.Overrides.GetPlrFromChar
    if ov then
        return ov(char)
    end
    
    return plrs:GetPlayerFromCharacter(char)
end

function ESP:Toggle(bool)
    self.Enabled = bool
    if not bool then
        for i,v in pairs(self.Objects) do
            if v.Type == "Box" then --fov circle etc
                if v.Temporary then
                    v:Remove()
                else
                    for i,v in pairs(v.Components) do
                        v.Visible = false
                    end
                end
            end
        end
    end
end

function ESP:GetBox(obj)
    return self.Objects[obj]
end

function ESP:AddObjectListener(parent, options)
    local function NewListener(c)
        if type(options.Type) == "string" and c:IsA(options.Type) or options.Type == nil then
            if type(options.Name) == "string" and c.Name == options.Name or options.Name == nil then
                if not options.Validator or options.Validator(c) then
                    local box = ESP:Add(c, {
                        PrimaryPart = type(options.PrimaryPart) == "string" and c:WaitForChild(options.PrimaryPart) or type(options.PrimaryPart) == "function" and options.PrimaryPart(c),
                        Color = type(options.Color) == "function" and options.Color(c) or options.Color,
                        ColorDynamic = options.ColorDynamic,
                        Name = type(options.CustomName) == "function" and options.CustomName(c) or options.CustomName,
                        IsEnabled = options.IsEnabled,
                        RenderInNil = options.RenderInNil
                    })
                    --TODO: add a better way of passing options
                    if options.OnAdded then
                        coroutine.wrap(options.OnAdded)(box)
                    end
                end
            end
        end
    end

    if options.Recursive then
        parent.DescendantAdded:Connect(NewListener)
        for i,v in pairs(parent:GetDescendants()) do
            coroutine.wrap(NewListener)(v)
        end
    else
        parent.ChildAdded:Connect(NewListener)
        for i,v in pairs(parent:GetChildren()) do
            coroutine.wrap(NewListener)(v)
        end
    end
end

local boxBase = {}
boxBase.__index = boxBase

function boxBase:Remove()
    ESP.Objects[self.Object] = nil
    for i,v in pairs(self.Components) do
        v.Visible = false
        v:Remove()
        self.Components[i] = nil
    end
end

function boxBase:Update()
    if not self.PrimaryPart then
        --warn("not supposed to print", self.Object)
        return self:Remove()
    end

    local color
    if ESP.Highlighted == self.Object then
       color = ESP.HighlightColor
    else
        color = self.Color or self.ColorDynamic and self:ColorDynamic() or ESP:GetColor(self.Object) or ESP.Color
    end

    local allow = true
    if ESP.Overrides.UpdateAllow and not ESP.Overrides.UpdateAllow(self) then
        allow = false
    end
    if self.Player and not ESP.TeamMates and ESP:IsTeamMate(self.Player) then
        allow = false
    end
    if self.Player and not ESP.Players then
        allow = false
    end
    if self.IsEnabled and (type(self.IsEnabled) == "string" and not ESP[self.IsEnabled] or type(self.IsEnabled) == "function" and not self:IsEnabled()) then
        allow = false
    end
    if not workspace:IsAncestorOf(self.PrimaryPart) and not self.RenderInNil then
        allow = false
    end

    if not allow then
        for i,v in pairs(self.Components) do
            v.Visible = false
        end
        return
    end

    if ESP.Highlighted == self.Object then
        color = ESP.HighlightColor
    end

    --calculations--
    local cf = self.PrimaryPart.CFrame
    if ESP.FaceCamera then
        cf = CFrame.new(cf.p, cam.CFrame.p)
    end
    local size = self.Size
    local locs = {
        TopLeft = cf * ESP.BoxShift * CFrame.new(size.X/2,size.Y/2,0),
        TopRight = cf * ESP.BoxShift * CFrame.new(-size.X/2,size.Y/2,0),
        BottomLeft = cf * ESP.BoxShift * CFrame.new(size.X/2,-size.Y/2,0),
        BottomRight = cf * ESP.BoxShift * CFrame.new(-size.X/2,-size.Y/2,0),
        TagPos = cf * ESP.BoxShift * CFrame.new(0,size.Y/2,0),
        Torso = cf * ESP.BoxShift
    }

    if ESP.Boxes then
        local TopLeft, Vis1 = WorldToViewportPoint(cam, locs.TopLeft.p)
        local TopRight, Vis2 = WorldToViewportPoint(cam, locs.TopRight.p)
        local BottomLeft, Vis3 = WorldToViewportPoint(cam, locs.BottomLeft.p)
        local BottomRight, Vis4 = WorldToViewportPoint(cam, locs.BottomRight.p)

        if self.Components.Quad then
            if Vis1 or Vis2 or Vis3 or Vis4 then
                self.Components.Quad.Visible = true
                self.Components.Quad.PointA = Vector2.new(TopRight.X, TopRight.Y)
                self.Components.Quad.PointB = Vector2.new(TopLeft.X, TopLeft.Y)
                self.Components.Quad.PointC = Vector2.new(BottomLeft.X, BottomLeft.Y)
                self.Components.Quad.PointD = Vector2.new(BottomRight.X, BottomRight.Y)
                self.Components.Quad.Color = color
            else
                self.Components.Quad.Visible = false
            end
        end
    else
        self.Components.Quad.Visible = false
    end

    if ESP.Names then
        local TagPos, Vis5 = WorldToViewportPoint(cam, locs.TagPos.p)
        
        if Vis5 then
            self.Components.Name.Visible = true
            self.Components.Name.Position = Vector2.new(TagPos.X, TagPos.Y)
            self.Components.Name.Text = self.Name
            self.Components.Name.Color = color
        else
            self.Components.Name.Visible = false
        end
    end

    if ESP.Distances then
        local TagPos, Vis5 = WorldToViewportPoint(cam, locs.TagPos.p)
        
        if Vis5 then
            self.Components.Distance.Visible = true
            self.Components.Distance.Position = Vector2.new(TagPos.X, TagPos.Y + 14)
            self.Components.Distance.Text = math.floor((cam.CFrame.p - cf.p).magnitude) .."m away"
            self.Components.Distance.Color = color
        else
            self.Components.Distance.Visible = false
        end
    else
        self.Components.Name.Visible = false
        self.Components.Distance.Visible = false
    end
    
    if ESP.Tracers then
        local TorsoPos, Vis6 = WorldToViewportPoint(cam, locs.Torso.p)

        if Vis6 then
            self.Components.Tracer.Visible = true
            self.Components.Tracer.From = Vector2.new(TorsoPos.X, TorsoPos.Y)
            self.Components.Tracer.To = Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/ESP.AttachShift)
            self.Components.Tracer.Color = color
        else
            self.Components.Tracer.Visible = false
        end
    else
        self.Components.Tracer.Visible = false
    end

    if ESP.Health then
        local TagPos, Vis5 = WorldToViewportPoint(cam, locs.TagPos.p)
        
        if Vis5 then
            self.Components.Health.Visible = true
            self.Components.Health.Position = Vector2.new(TagPos.X, TagPos.Y)
            self.Components.Health.Text = "Health: "..tostring(self.Health)
            self.Components.Health.Color = color
        else
            self.Components.Health.Visible = false
        end
    else
        self.Components.Health.Visible = false
    end
end

function ESP:Add(obj, options)
    if not obj.Parent and not options.RenderInNil then
        return warn(obj, "has no parent")
    end

    local box = setmetatable({
        Name = options.Name or obj.Name,
        Type = "Box",
        Color = options.Color --[[or self:GetColor(obj)]],
        Size = options.Size or self.BoxSize,
        Object = obj,
        Player = options.Player or plrs:GetPlayerFromCharacter(obj),
        PrimaryPart = options.PrimaryPart or obj.ClassName == "Model" and (obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")) or obj:IsA("BasePart") and obj,
        Components = {},
        IsEnabled = options.IsEnabled,
        Temporary = options.Temporary,
        ColorDynamic = options.ColorDynamic,
        RenderInNil = options.RenderInNil
    }, boxBase)

    if self:GetBox(obj) then
        self:GetBox(obj):Remove()
    end

    box.Components["Quad"] = Draw("Quad", {
        Thickness = self.Thickness,
        Color = color,
        Transparency = 1,
        Filled = false,
        Visible = self.Enabled and self.Boxes
    })
    box.Components["Name"] = Draw("Text", {
        Text = box.Name,
        Color = box.Color,
        Center = true,
        Outline = true,
        Size = 19,
        Visible = self.Enabled and self.Names
    })
    box.Components["Distance"] = Draw("Text", {
        Color = box.Color,
        Center = true,
        Outline = true,
        Size = 19,
        Visible = self.Enabled and self.Names
    })
    
    box.Components["Tracer"] = Draw("Line", {
        Thickness = ESP.Thickness,
        Color = box.Color,
        Transparency = 1,
        Visible = self.Enabled and self.Tracers
    })

    box.Components["Health"] = Draw("Text", {
        Color = box.Color,
        Center = true,
        Outline = true,
        Size = 19,
        Visible = self.Enabled and self.Names
    })
    self.Objects[obj] = box
    
    obj.AncestryChanged:Connect(function(_, parent)
        if parent == nil and ESP.AutoRemove ~= false then
            box:Remove()
        end
    end)
    obj:GetPropertyChangedSignal("Parent"):Connect(function()
        if obj.Parent == nil and ESP.AutoRemove ~= false then
            box:Remove()
        end
    end)

    local hum = obj:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.Died:Connect(function()
            if ESP.AutoRemove ~= false then
                box:Remove()
            end
        end)
    end

    return box
end

local function CharAdded(char)
    local p = plrs:GetPlayerFromCharacter(char)
    if not char:FindFirstChild("HumanoidRootPart") then
        local ev
        ev = char.ChildAdded:Connect(function(c)
            if c.Name == "HumanoidRootPart" then
                ev:Disconnect()
                ESP:Add(char, {
                    Name = p.Name,
                    Player = p,
                    PrimaryPart = c
                })
            end
        end)
    else
        ESP:Add(char, {
            Name = p.Name,
            Player = p,
            PrimaryPart = char.HumanoidRootPart
        })
    end
end
local function PlayerAdded(p)
    p.CharacterAdded:Connect(CharAdded)
    if p.Character then
        coroutine.wrap(CharAdded)(p.Character)
    end
end
plrs.PlayerAdded:Connect(PlayerAdded)
for i,v in pairs(plrs:GetPlayers()) do
    if v ~= plr then
        PlayerAdded(v)
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    cam = workspace.CurrentCamera
    for i,v in (ESP.Enabled and pairs or ipairs)(ESP.Objects) do
        if v.Update then
            local s,e = pcall(v.Update, v)
            if not s then warn("[EU]", e, v.Object:GetFullName()) end
        end
    end
end)

return ESP
