local library = loadstring(game:HttpGet("http://localhost:3000/library"))()
local listing = loadstring(game:HttpGet("http://localhost:3000/listing"))()

print(library)

-- Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService       = game:GetService("HttpService")
local Players           = game:GetService("Players")

local BuildingParts = ReplicatedStorage.BuildingParts

local Teams = {
    ["blue"]    = workspace["Really blueZone"],
    ["yellow"]  = workspace["New YellerZone"],
    ["red"]     = workspace["Really redZone"],
    ["magenta"] = workspace["MagentaZone"],
    ["black"]   = workspace["BlackZone"],
    ["white"]   = workspace["WhiteZone"],
    ["green"]   = workspace["CamoZone"],
}

local AutoBuildPreview; do
    if (workspace:FindFirstChild("BuildPreview")) then
        AutoBuildPreview = workspace.BuildPreview
    else
        AutoBuildPreview = Instance.new("Model") 
        AutoBuildPreview.Name = "BuildPreview"
        AutoBuildPreview.Parent = workspace
    end
end

local LocalPlayer = Players.LocalPlayer

local Data = LocalPlayer.Data

-- Constants
local RADIANS_TO_DEGREES = 57.29577951308232
local BLOCK_MAGNITUDE    = 0.01
local DEFAULT_BLOCK_SIZE = Vector3.new(2, 2, 2)

-- Localization
local Color3new  = Color3.new
local Color3rgb  = Color3.fromRGB
local Vector3new = Vector3.new
local CFramenew  = CFrame.new
local CFrameAng  = CFrame.Angles

local floor = math.floor
local ceil  = math.ceil 
local rad   = math.rad
local pow   = math.pow
local abs   = math.abs

local split = string.split
local gsub  = string.gsub
local find  = string.find

local insert = table.insert
local remove = table.remove

local loadstring = loadstring
local unpack     = unpack

local taskSpawn = task.spawn

local InvokeServer = Instance.new("RemoteFunction").InvokeServer
local FireServer   = Instance.new("RemoteEvent").FireServer

local SetPrimaryPartCFrame = Instance.new("Model").SetPrimaryPartCFrame

local FindFirstChild = workspace.FindFirstChild
local GetDescendants = workspace.GetDescendants
local GetChildren    = workspace.GetChildren
local Destroy        = workspace.Destroy
local Clone          = workspace.Clone

local ToEulerAnglesXYZ = CFrame.new().ToEulerAnglesXYZ
local ToObjectSpace    = CFrame.new().ToObjectSpace

local stages = workspace:WaitForChild("BoatStages"):WaitForChild("NormalStages")
local gold   = workspace:WaitForChild("ClaimRiverResultsGold")

local request = (syn and syn.request) or request or http_request

-- String Compression
--local lualzw = loadstring(game:HttpGet("https://raw.githubusercontent.com/Rochet2/lualzw/master/lualzw.lua"))()

-- Custom Variables
local BuildSpeed = 1
local SafeMode = false

-- Build Speed Options :
-- 0 dangerous
-- 1 fast
-- 2 slow
-- 3 safe

local function SpeedFunct(i)
    if (BuildSpeed == 3) then wait()
        return false
    elseif (BuildSpeed == 2) then wait()
        return true
    elseif (BuildSpeed == 1) then
        if (i % 2 == 0) then task.wait() end
        return true
    else
        return true
    end
end

-- Functions
local function memoize(funct)
    local cached = setmetatable({}, {__mode = "v"})
    
    return function(a)
        local b = cached[a] or funct(a)
        cached[a] = b
        return b
    end
end

function ListBuilds()
    local files, builds = listfiles(""), {}
    
    for i, v in next, files do
        if (string.sub(v, #v - 5, #v) == ".Build") then
            insert(builds, string.sub(v, 0, #v - 6)) 
        end
    end
    
    return builds
end

local intToRGBA; do
    local A, B, C = 16777216, 65536, 256
    
    intToRGBA = function(i)
        local r = floor(i / A);
        local g = floor((i - (r * A)) / B);
        local b = floor((i - (r * A) - (g * B)) / C)
    
        return {
            Color = Color3rgb(r, g, b), -- Rgb
            Alpha = floor((i - (r * A) - (g * B) - (b * C)) / 1); -- Alpha
        };
    end 
end

intToRGBA = memoize(intToRGBA)

local function Create(class, props)
    local Object = Instance.new(class)
    
    for i, v in next, props do
        Object[i] = v 
    end
    
    return Object
end

function AnglesString(string)
    local r = split(string, ",")
    return CFrameAng(rad(r[1]), rad(r[2]), rad(r[3]))
end

--AnglesString = memoize(AnglesString)

function String(x)
    return gsub(tostring(x), " ", "")
end

--String = memoize(String)

function Raw(x)
    return unpack(split(x, ","))
end

--Raw = memoize(Raw)

function Floor(x, y)
    return floor((x * (10 ^ y)) + 0.5) / (10 ^ y) 
end

function GetStringAngles(cframe)
    local X, Y, Z = ToEulerAnglesXYZ(cframe)
    
    X = X * RADIANS_TO_DEGREES
    Y = Y * RADIANS_TO_DEGREES
    Z = Z * RADIANS_TO_DEGREES
    
    return Floor(X, 5) .. "," .. Floor(Y, 5) .. "," .. Floor(Z, 5)
end

--GetStringAngles = memoize(GetStringAngles)

function GetAngles(cframe)
    local X, Y, Z = ToEulerAnglesXYZ(cframe)
    return CFrameAng(X, Y, Z)
end

--GetAngles = memoize(GetAngles)

function GetTeam()
    return tostring(LocalPlayer.Team)
end

function GetPlot()
    return Teams[tostring(LocalPlayer.Team)]
end

function GetBlocks()
    local blocks, validBlocks = GetChildren(workspace), {}

    for i, v in next, blocks do
        if (FindFirstChild(v, "Tag")) then
            insert(validBlocks, v)
        end
    end

    return validBlocks
end

function GetTeamPlayers(team)
    local players = {}
    
    for _, player in next, Players:GetPlayers() do
        if (tostring(player.Team) == team) then
            insert(players, player.Name) 
        end
    end
    
    return players
end

function GetTeamBlocks(team)
    local TeamPlayers = GetTeamPlayers(team)
    local Blocks = {}

    for _, block in next, GetBlocks() do
        if (table.find(TeamPlayers, block.Tag.Value)) then
            insert(Blocks, block)
        end
    end

    return Blocks
end

function GetPreviewBlocks()
    local Blocks = {}

    for _, block in next, GetChildren(AutoBuildPreview) do
        insert(Blocks, block)
    end

    return Blocks
end

function GetTool(name)
    return (FindFirstChild(LocalPlayer.Backpack,  name) and LocalPlayer.Backpack [name].RF) 
        or (FindFirstChild(LocalPlayer.Character, name) and LocalPlayer.Character[name].RF)
end

local Progress; do
    local ScreenGui = Create("ScreenGui", { Parent = game:GetService("CoreGui") }) do
        local Window = Create("ImageLabel", {
            Parent = ScreenGui,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 1, -20),
            Size = UDim2.new(0, 140, 0, 20),
            Image = "rbxassetid://2851926732",
            ImageColor3 = Color3.fromRGB(20, 21, 23),
            SliceCenter = Rect.new(12, 12, 12, 12),
        }) do
            Create("ImageLabel", {
                Parent = Window,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 1, -20),
                Size = UDim2.new(0, 140, 0, 40),
                Image = "rbxassetid://2851926732",
                ImageColor3 = Color3.fromRGB(20, 21, 23),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(12, 12, 12, 12),
            })
            local Top = Create("ImageLabel", {
                Parent = Window,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, -10, 0, 0),
                Size = UDim2.new(0, 90, 0, 20),
                Image = "rbxassetid://2851926732",
                ImageColor3 = Color3.fromRGB(41, 74, 122),
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(12, 12, 12, 12),
            }) do
                local Top_2 = Create("ImageLabel", {
                    Parent = Top,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, 0),
                    Size = UDim2.new(0, 90, 0, 20),
                    Image = "rbxassetid://2851926732",
                    ImageColor3 = Color3.fromRGB(41, 74, 122),
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(12, 12, 12, 12),
                }) do
                    Create("TextLabel", {
                        Parent = Top_2,
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 5, 0, 0),
                        Size = UDim2.new(1, 0, 0, 20),
                        ZIndex = 11,
                        Font = Enum.Font.GothamBold,
                        Text = "Progression",
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14.000,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })
                end
            end
            Progress = Create("TextLabel", {
                Parent = Window,
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 95, 0, 0),
                Size = UDim2.new(1, -95, 1, 0),
                Font = Enum.Font.GothamBold,
                Text = " NaN",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 14.000,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
        end
    end
end

local ProgressAmount = 0
local ProgressUsed   = 0

function UpdateProgression(int)
    Progress.Text = (typeof(int) == "number" and ceil(int) .. "%" or int)
end

-- Encoding / Decoding / Converting
function Encode(blocks, team)
    local jsonTable = {}

    teamPlate = team and Teams[team] or GetPlot()

    for _, v in next, blocks do
        local blockName = v.Name
        local PPart     = v.PPart

        if not (jsonTable[blockName]) then jsonTable[blockName] = {} end

        local spacePosition = ToObjectSpace(teamPlate.CFrame, PPart.CFrame)

        insert(jsonTable[blockName], {
            Rotation = GetStringAngles(spacePosition),
            Position = String(spacePosition.p),
            
            ShowShadow = PPart.CastShadow == true and nil,
            CanCollide = PPart.CanCollide == true and nil,
            Anchored   = PPart.Anchored   == true and nil,
            
            Transparency = PPart.Transparency > 0 and PPart.Transparency or nil,
            Size = find(blockName, "Block") and PPart.Size ~= Vector3new(2, 2, 2) and String(PPart.Size) or nil,
            Color = PPart.Color ~= BuildingParts[blockName].PPart.Color and String(PPart.Color) or nil,
        })
    end

    return HttpService:JSONEncode(jsonTable)
end

function Decode(json, size)
    local normalTable = {}; size = size or 1
    
    local validJSON = xpcall(function()
        normalTable = HttpService:JSONDecode(json)
    end, function()
        warn("Invalid JSON")
    end)
    
    if (not validJSON) then return {} end

    for block, table in next, normalTable do
        if (FindFirstChild(BuildingParts, block)) then
            for i, v in next, table do
                local cloneTable = normalTable[block][i]
                
                cloneTable.Position = CFramenew(Vector3new(Raw(v.Position)) * size)
                cloneTable.Rotation = AnglesString(v.Rotation)
                cloneTable.Color    = v.Color and Color3new(Raw(v.Color)) or nil
                cloneTable.Size     = v.Size and v.Size ~= "2,2,2" and Vector3new(Raw(v.Size)) * size or nil
                
                normalTable[block][i] = cloneTable
            end
        else
            normalTable[block] = nil
        end
    end

    return normalTable
end

function Convert(file)
    local string, jsonTable = readfile(file), {}
    
    if (not find(string, "/")) then
        return nil
    end
    
    local myPlot = GetPlot()

    for _, v in next, split(string, "/") do
        local info = split(v, ":")

        if (#info == 5 and FindFirstChild(BuildingParts, info[5])) then            
            if (not jsonTable[info[5]]) then jsonTable[info[5]] = {} end
            
            local position = CFramenew(Raw(info[1])) * AnglesString(info[2])
                position = ToObjectSpace(CFramenew(0, -17.9999924, 0), position)

            insert(jsonTable[info[5]], {
                Color    = info[3] ~= "-" and info[3] or nil,
                Size     = info[4] ~= "-" and info[4] or nil,
                Position = String(position.p),
                Rotation = GetStringAngles(position),
            })
        end
    end

    jsonTable = HttpService:JSONEncode(jsonTable)

    -- Uncomment this later (Preventing from having to Convert every time)
    --writefile(file, jsonTable)

    return jsonTable
end

-- Init
function SavePlot(file, team)
    if (not file or not team) then
        return
    end

    local Blocks = GetTeamBlocks(team)
    local jsonTable = Encode(Blocks, team)
    
    writefile(file, jsonTable)
end

function LoadBlocks(blockInfo, team)
    local plot = team and Teams[team] or GetPlot()

    local build = GetTool("BuildingTool")
    local scale = GetTool("ScalingTool")
    local paint = GetTool("PaintingTool")
    
    local isInZone = getsenv(build.Parent.LocalScript).isPartInZone

    ProgressAmount = 0;
    ProgressUsed = 0;

    for _, table in next, blockInfo do
        ProgressAmount = ProgressAmount + #table
    end

    -- Building Part
    local SearchBlocks, FoundBlocks, SearchConnection = {}, {}, nil do
        local BlockAdded = function(part) part:WaitForChild("PPart", 1)
            if (not FindFirstChild(part, "PPart")) then return end

            for i, block in next, SearchBlocks do
                if ((part.PPart.Position - block.Position).Magnitude < BLOCK_MAGNITUDE) then
                    insert(FoundBlocks, {Block = part, Data = block.Data})
                    remove(SearchBlocks, i)

                    ProgressUsed = ProgressUsed + 1
                    UpdateProgression(50 - (ProgressAmount - ProgressUsed) / ProgressAmount * 50)
                    break;
                end
            end
        end

        SearchConnection = workspace.ChildAdded:Connect(BlockAdded)        
    end

    for blockType, table in next, blockInfo do
        local ownedAmount = Data[blockType].Value
        local usedAmount = Data[blockType].Used.Value

        for i, block in next, table do
            if (i > (ownedAmount - usedAmount)) then warn("Not Enough Blocks For " .. blockType) break end

            local Position = (plot.CFrame * (block.Position * block.Rotation))

            if (isInZone(Position, plot)) then
                if (block.Size or block.Color or block.Transparency or block.Anchored or block.CanCollide or block.ShowShadow) then
                    insert(SearchBlocks, {Position = Position.p, Data = block})
                end

                if (SafeMode and #SearchBlocks <= 5) then
                    repeat wait() until #SearchBlocks <= 5
                end

                if (SpeedFunct(i)) then
                    taskSpawn(InvokeServer, build, blockType, ownedAmount, nil, nil, block.Anchored == nil and true, 1, Position)
                end
            else
                ProgressAmount = ProgressAmount - 1;
            end
        end
    end

    repeat wait() until #SearchBlocks == 0
    
    SearchConnection:Disconnect() wait(1)

    ProgressUsed = 0;
    
    for i, block in next, FoundBlocks do
        if (block.Data.Size) then
            if (SpeedFunct(i) and not SafeMode) then
                taskSpawn(InvokeServer, scale, block.Block, block.Data.Size, block.Block.PPart.CFrame)
            else
                InvokeServer(scale, block.Block, block.Data.Size, block.Block.PPart.CFrame)
            end

            ProgressUsed = ProgressUsed + 1
            UpdateProgression(50 + 49 - (ProgressAmount - ProgressUsed) / ProgressAmount * 49)
        end
    end

    do -- Paint Shit
        local PaintData = {}
        
        for i, block in next, FoundBlocks do
            if (block.Data.Color) then
                insert(PaintData, {block.Block, block.Data.Color})
            end
        end
        
        InvokeServer(paint, PaintData)
        UpdateProgression(100)
    end

    wait(1.5)

    UpdateProgression("Done!")
end

function LoadFile(file, size, team)
    local blockInfo = nil
    
    if (#GetChildren(AutoBuildPreview) > 0) then
        local Blocks = GetPreviewBlocks()
        local jsonTable = Encode(Blocks, GetTeam())
              blockInfo = Decode(jsonTable, size)
    else
        local jsonTable = Convert(file) or readfile(file)
              blockInfo = Decode(jsonTable, size)
    end

    LoadBlocks(blockInfo, team)
end

function PreviewFile(file, size, team)
    local jsonTable = Convert(file) or readfile(file)
    local blockInfo = Decode(jsonTable, size)
    
    local myPlot = team and Teams[team] or GetPlot()

    for blockType, table in next, blockInfo do
        for _, block in next, table do
            local clonedBlock = Clone(BuildingParts[blockType]) do
                local newPosition = myPlot.CFrame * (block.Position * block.Rotation)
                    
                SetPrimaryPartCFrame(clonedBlock, newPosition)

                clonedBlock.Tag.Value = ""
                clonedBlock.Parent = AutoBuildPreview
                clonedBlock.PPart.Size = block.Size or clonedBlock.PPart.Size
                clonedBlock.PPart.Anchored = block.Anchored or true

                if (block.Color) then
                    for _, v in next, GetDescendants(clonedBlock) do
                        if (v:IsA("BasePart")) then
                            v.Color = block.Color
                        end
                    end
                end
            end
        end
    end
end

local RotationX, RotationY, RotationZ = 0, 0, 0

local Primary = Instance.new("Part", AutoBuildPreview) do
    Primary.Transparency = 1
    Primary.Anchored = true
    Primary.CanCollide = false
end

function reflectVec(v, axis)
	return v - 2*(axis*v:Dot(axis))
end

function ReflectCFrame(cf, overCFrame, attachment)
	local mirrorPoint = overCFrame.Position
	local mirrorAxis = overCFrame.LookVector

	local position = cf.Position
	local x, y, z = position.X, position.Y, position.Z

	local newPos = mirrorPoint + reflectVec(Vector3new(x, y, z) - mirrorPoint, mirrorAxis)

	local xAxis = cf.XVector
	local yAxis = cf.YVector
	local zAxis = cf.ZVector

	xAxis = -reflectVec(xAxis, mirrorAxis)
	yAxis =  reflectVec(yAxis, mirrorAxis)
	zAxis =  reflectVec(zAxis, mirrorAxis)

	return CFramenew(newPos.X, newPos.Y, newPos.Z,
		xAxis.X,  yAxis.X,  zAxis.X,
		xAxis.Y,  yAxis.Y,  zAxis.Y,
		xAxis.Z,  yAxis.Z,  zAxis.Z)
end

function MirrorBuild()
    local cframe = AutoBuildPreview:GetBoundingBox()

    for _, block in next, GetChildren(AutoBuildPreview) do
        if (FindFirstChild(block, "PPart")) then
            SetPrimaryPartCFrame(block, ReflectCFrame(block.PPart.CFrame, cframe))
        end
    end
end

function UpdatePreview(position)
    local cframe, size = AutoBuildPreview:GetBoundingBox()
    
    position = position or Vector3new()
    
    local NewCFrame = (position and CFramenew(cframe.Position) or cframe) * CFrameAng(rad(RotationX), rad(RotationY), rad(RotationZ)) + position

    Primary.CFrame = cframe
    Primary.Parent = AutoBuildPreview
    
    AutoBuildPreview.PrimaryPart = Primary

    SetPrimaryPartCFrame(AutoBuildPreview, NewCFrame)
    
    Primary.Parent = workspace
end

function ClearPreview()
    for i, v in next, GetChildren(AutoBuildPreview) do
        Destroy(v)
    end
end

function ListBuild(file, size)
    local jsonTable = Convert(file) or readfile(file)
    local blockInfo = Decode(jsonTable, size or 1)

    local blocksNeeded = {}
    local blocksMissing = {}

    for blockType, table in next, blockInfo do
        local NeededAmount = 0
        local MissingAmount = 0
        
        for _, block in next, table do
            if (not block.Size or block.Size == DEFAULT_BLOCK_SIZE) then
                NeededAmount = NeededAmount + 1
            else
                NeededAmount = NeededAmount + ceil(block.Size.X * block.Size.Y * block.Size.Z / 8 + .5)
            end
        end

        MissingAmount = NeededAmount - Data[blockType].Value

        blocksNeeded[blockType] = NeededAmount
        blocksMissing[blockType] = MissingAmount > 0 and MissingAmount or nil
    end

    listing:Clear()
    
    for i, v in next, blocksNeeded do
        listing:Add(i, v, blocksMissing[i])
    end
end

local function GetImageBlockInfo(blockType, Position, Size, rgba)
    return {
        Name = blockType,
        PPart = {
            CFrame = Position,
            CastShadow = false,
            CanCollide = true,
            Anchored   = true,
            Transparency = 0, --1 - rgba.Alpha,
            Color = rgba.Color,
            Size = Size
        }
    }
end

local SavedBody = nil
local SavedUrl  = nil

local function GetUrlBody(Url)
    local Body = nil
    
    if (SavedUrl ~= Url) then
        print("New Request > " .. Url)
        Body = request({
            Url = "http://localhost:3000/image", 
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({url = Url})
        })["Body"]
        print("Got Body")
    else
        Body = SavedBody
    end
    
    SavedBody, SavedUrl = Body, Url

    return Body
end

local function BuildImage(url, blockType, bSize, iSize, isPreview)
    local Body = GetUrlBody(url)

    iSize = iSize ~= 0 and ceil(abs(iSize)) or 1

    if (Body == "invalid") then return print("Invalid") end

    local Body = HttpService:JSONDecode(Body)

    local width, height = Body.dimensions[1], Body.dimensions[2]
    local center = GetPlot().CFrame

    local topHeight, topLenght = (5.1 + (height / iSize) * bSize), ((width / iSize) * bSize / 2)

    local Blocks = {}

    for y = 0, (height / iSize) - 1 do
        for x = 0, (width / iSize) - 1 do
            local rgba = intToRGBA(Body.pixels[((y * width) + x + 1) * iSize])

            local Position = center + Vector3new(-x * bSize + topLenght, -y * bSize + topHeight)
            local Size     =          Vector3new(bSize, bSize, bSize)

            local Transparency = 1 - rgba.Alpha
            local Color        =     rgba.Color

            if (isPreview) then
                local clonedBlock = Clone(BuildingParts[blockType]) do
                    clonedBlock.Parent              = AutoBuildPreview
                    clonedBlock.PPart.Size          = Size
                    clonedBlock.PPart.Color         = Color
                    clonedBlock.PPart.CFrame        = Position
                    clonedBlock.PPart.Anchored      = true
                    clonedBlock.PPart.CanCollide    = false
                    clonedBlock.PPart.Transparency  = Transparency
                end
            else
                insert(Blocks, GetImageBlockInfo(blockType, Position, Size, rgba))
            end
        end
    end

    if (not isPreview) then
        if (#GetChildren(AutoBuildPreview) > 0) then
            Blocks = GetPreviewBlocks()
        end

        LoadBlocks(Decode(Encode(Blocks), 1))
    end
end

local function ListImage(url, blockType)
    local Body = HttpService:JSONDecode(GetUrlBody(url))

    local Needed, Missing = #Body.pixels, #Body.pixels - Data[blockType].Value

    listing:Clear()
    listing:Add(blockType, Needed, Missing > 0 and Missing or nil)
end

--// Other Stuff
-- Autofarm
local AutofarmEnabled = false

function AutoFarm(boolean)
    AutofarmEnabled = boolean

    while AutofarmEnabled do
        Create("BodyVelocity", { Velocity = Vector3.new(0, 0, 0), Parent = LocalPlayer.Character.HumanoidRootPart })

        for i = 1, 10 do
            if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Humanoid") then
                repeat wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            end
     
            LocalPlayer.Character.HumanoidRootPart.CFrame = stages["CaveStage" .. i].DarknessPart.CFrame wait((i == 1 and 4 or 2) + 0.1)
            
            gold:FireServer()
        end

        LocalPlayer.Character:Remove()
 
        repeat wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    end
end

do
	local Window = library:AddWindow("Auto Builder", {
		main_color = Color3rgb(41, 74, 122),
		min_size = Vector2.new(254, 450),
		toggle_key = Enum.KeyCode.RightControl,
		can_resize = false,
	})
	
	local Main = Window:AddTab("Main")
    
    local SelectFile = nil

	do -- Elements
        local BuildSize = 1

		local Files = Main:AddDropdown("Files", function(file) SelectFile = file .. ".Build" end)

        local function UpdateList()
            Files:Clear()

            for _, v in next, ListBuilds() do
                Files:Add(v)
            end
        end

        UpdateList()

        Main:AddButton("Refresh Files", UpdateList)

        local FileName, SelectedTeam = nil, nil

		local Saving = Main:AddFolder("Saving") do
		    Saving:AddTextBox("File Name",   function(name) FileName = name .. ".Build" end, { ["clear"] = false })
		    Saving:AddDropdown("Team",       function(team) if (team == "My Team") then team = LocalPlayer.Team end SelectedTeam = team end):Add("My Team"):Add("white"):Add("blue"):Add("green"):Add("red"):Add("black"):Add("yellow"):Add("magenta")
		    Saving:AddButton("Save To File", function() SavePlot(FileName, SelectedTeam) UpdateList() end)
		    
		    Saving:Fold(true)
        end

        local BuildSettings = Main:AddFolder("Build Settings") do
            BuildSettings:AddSwitch("Safe Mode", function(boolean) SafeMode = boolean end)
		    BuildSettings:AddDropdown("Speed",   function(boolean) BuildSpeed = ("Dangerous" and 0) or ("Fast" and 1) or ("Slow" and 2) or ("Safe" and 3) end):Add("Dangerous"):Add("Fast"):Add("Slow"):Add("Safe")
		    BuildSettings:AddTextBox("Size %",   function(int) BuildSize = int / 100 end, { ["clear"] = false })
		    
		    BuildSettings:Fold(true)
        end
        
		local Folder = Main:AddFolder("Builder") do
    		Folder:AddButton("List Blocks", function() ListBuild(SelectFile, BuildSize) end)
    		Folder:AddButton("Preview",     function() if (#GetChildren(AutoBuildPreview) > 0) then ClearPreview() else PreviewFile(SelectFile, BuildSize) end end)
    		Folder:AddButton("Load File",   function() LoadFile(SelectFile, #GetChildren(AutoBuildPreview) > 1 and 1 or BuildSize) end)
    		
    		Folder:Fold(true)
		end
		
	end

    local Images = Window:AddTab("Images")
    
    do
        local ImageUrl  = nil
        local BlockType = nil
        local bSize, iSize = 1, 1

        Images:AddTextBox("URL", function(url) ImageUrl = url end, { ["clear"] = false })
        
        local BuildSettings = Images:AddFolder("Build Settings") do
            BuildSettings:AddTextBox("Block Size (Studs)",  function(size) bSize = tonumber(size) end, { ["clear"] = false })
            BuildSettings:AddTextBox("Image Size (Number)", function(size) iSize = tonumber(size) end, { ["clear"] = false })
            
            local blocksDrop = BuildSettings:AddDropdown("Block Type", function(blockType) BlockType = blockType end) do
                for _, block in next, GetChildren(ReplicatedStorage.BuildingParts) do
                    local name = block.Name
                    
                    if (string.sub(name, #name - 4, #name) == "Block") then
                        blocksDrop:Add(name)
                    end
                end
            end
            
            BuildSettings:Fold(true)
        end
        
        local Builder = Images:AddFolder("Builder") do
            Builder:AddButton("List Blocks", function() ListImage(ImageUrl, BlockType) end)
    		Builder:AddButton("Preview",     function() if (#GetChildren(AutoBuildPreview) > 0) then ClearPreview() else BuildImage(ImageUrl, BlockType, bSize, iSize, true) end end)
    		Builder:AddButton("Load Image",   function() BuildImage(ImageUrl, BlockType, bSize, iSize, false) end)
    		
    		Builder:Fold(true)
        end
    end

    local Adjustments = Window:AddTab("Adjusters")
	
	do
        local Mult = 1;

        local PositionOff = Adjustments:AddFolder("Position Offset") do
    	    PositionOff:AddTextBox("Move Multiplier", function(float) Mult = float end, { ["clear"] = false })
    	    PositionOff:AddButton("Move Up",          function() UpdatePreview(Vector3new(0,Mult,0) ) end)
    	    PositionOff:AddButton("Move Down",        function() UpdatePreview(Vector3new(0,-Mult,0)) end)
    	    PositionOff:AddButton("Move Left",        function() UpdatePreview(Vector3new(Mult,0,0) ) end)
    	    PositionOff:AddButton("Move Right",       function() UpdatePreview(Vector3new(-Mult,0,0)) end)
    	    PositionOff:AddButton("Move Forwards",    function() UpdatePreview(Vector3new(0,0,Mult) ) end)
    	    PositionOff:AddButton("Move Backwards",   function() UpdatePreview(Vector3new(0,0,-Mult)) end)
    	    
    	    PositionOff:Fold(true)
	    end
    
        local RotationOff = Adjustments:AddFolder("Rotation Offset") do
            RotationOff:AddSlider("X", function(X) RotationX = X UpdatePreview() end, {min = 0, max = 360})
            RotationOff:AddSlider("Y", function(Y) RotationY = Y UpdatePreview() end, {min = 0, max = 360})
            RotationOff:AddSlider("Z", function(Z) RotationZ = Z UpdatePreview() end, {min = 0, max = 360})
            
            RotationOff:Fold(true)
        end

        local OtherOff = Adjustments:AddFolder("Other") do
            OtherOff:AddTextBox("Size %", function(int) 
                ClearPreview()
                PreviewFile(SelectFile, tonumber(int) / 100)
            end, { ["clear"] = false })

            OtherOff:AddButton("Mirror Build", MirrorBuild)

            OtherOff:Fold(true)
        end
	end

    local Other = Window:AddTab("Other")

    do
        local Autofarm = Other:AddFolder("Auto Farm") do
            Autofarm:AddSwitch("Enabled", AutoFarm)

            Autofarm:Fold(true)
        end
    end

	Main:Show()
	library:FormatWindows()
end
