local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/bailib/Roblox/refs/heads/main/main/ESP.lua"))()

WindUI:Notify({
    Title = "Open source",
    Content = "By Moxiaobai",
    Duration = 5,
})

local Window = WindUI:CreateWindow({
    Title = "压力(Pressure)",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = "By Moxiaobai",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(300, 270),
    Transparent = true,
    Theme = "Dark",
    User = {
        Enabled = true,
        Callback = function() print("clicked") end,
        Anonymous = false
    },
    SideBarWidth = 200,
    -- HideSearchBar = true,
    ScrollBarEnabled = true,
    -- Background = "rbxassetid://13511292247", -- rbxassetid only
})
Window:EditOpenButton({
    Title = "打开UI",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    Draggable = true,
})

MainSection = Window:Section({
    Title = "主",
    Opened = true,
})

Main = MainSection:Tab({ Title = "主要功能", Icon = "Sword" })
Source = MainSection:Tab({ Title = "查看源码", Icon = "Sword" })

Source:Code({
    Code = request({Url="https://raw.githubusercontent.com/bailib/Roblox/refs/heads/main/PressureScript.lua"}).Body,
})

local Monster = {"A60","Abomination","AbstractArt","AnalogHorrorChristmasTree","Angler","AnglerVariants","Bottomfeeder","Bouncers","Candlebearers","Bouncers","DeepSeaBunnies","DefenseSystem","Eyefestation","GoodPeople","GuardianAngel","Harbinger","Hazards","HuntedPit","ImaginaryFriend","Jetsuit","JetsuitTrack","Kibo","LadyDeath","Landmine","LetVandZone","Lopee","LunarDock","MaskOfSadness","MyWife","NaviAI","Pandemonium","ParanoiasBox","Pipsqueak","Parasite","Raveyard","Rebarb","Redeemer","RepellentSystem","RottenCoral","Searchlights","ShotgunPunishment","WitchingHour","WallDwellers","Void","ValculaVoidMass","UnderwaterHazards","Tripwire","Trenchbleeder","TheSaboteur","TheRidge","ThePainter","TheMindscape","TheEducator","Template","TheDiVine","SubmarineTurret","Stan","Stairwell87","Squiddles","Skelepede","SittingItOut","ShotgunPunishment"}

local oldpos
local autoevade

ESP.AddFolder("KeyESPFolder")
ESP.AddFolder("DoorESPFolder")
ESP.AddFolder("ItemESPFolder")

local a = {
    auto = false,
    esp = false
}

Main:Toggle({
    Title = "自动捡钱",
    Default = false,
    Image = "check",
    Callback = function(state)
        a.auto = state
        spawn(function()
            while a.auto and wait() do
                for _,v in next, workspace:GetDescendants() do
                    if v.Name:find'Currency' then
                        fireproximityprompt(v.ProxyPart.ProximityPrompt)
                    end
                end
            end
        end)
    end
})

Main:Toggle({
    Title = "自动捡钥匙卡和密码纸",
    Default = false,
    Image = "check",
    Callback = function(state)
        a.auto = state
        spawn(function()
            while a.auto and wait() do
                for _,v in next, workspace:GetDescendants() do
                    if v.Name:find'KeyCard' or v.Name:find'PasswordPaper' then
                        fireproximityprompt(v.ProxyPart.ProximityPrompt)
                    end
                end
            end
        end)
    end
})

Main:Toggle({
    Title = "自动捡物品",
    Default = false,
    Image = "check",
    Callback = function(state)
        a.auto = state
        spawn(function()
            while a.auto and wait() do
                for _,v in next, workspace:GetDescendants() do
                    if v:GetAttribute("InteractionType") == "ItemBase" then
                        fireproximityprompt(v.ProxyPart.ProximityPrompt)
                    end
                end
            end
        end)
    end
})

Main:Toggle({
    Title = "防怪物柜子",
    Default = false,
    Image = "check",
    Callback = function(state)
        a.auto = state
        spawn(function()
            while a.auto and wait() do
                for _,v in next, workspace:GetDescendants() do
                    if v.Name:find'MonsterLocker' then
                        v.ProxyPart:Destroy()
                    end
                end
            end
        end)
    end
})

Main:Toggle({
    Title = "自动躲怪物",
    Default = false,
    Image = "check",
    Callback = function(state)
        a.auto = state
        if a.auto then
            autoevade = workspace.DescendantAdded:Connect(function(v)
                for _, monsterName in pairs(Monster) do
                    if v.Name == monsterName then
                        oldpos = game.Players.LocalPlayer.Character:GetPivot().Position
                        game.Players.LocalPlayer.Character:PivotTo(oldpos + Vector3.new(0, 20, 0))
                        game.Players.LocalPlayer.Character:PivotTo(CFrame.new(oldpos))
                        break
                    end
                end
            end)
        else
            if autoevade then
                autoevade:Disconnect()
                autoevade = nil
            end
        end
    end
})


Main:Toggle({
    Title = "透视钥匙卡和密码纸",
    Default = false,
    Image = "check",
    Callback = function(state)
        a.esp = state
        if a.esp then
            for _,v in next, workspace:GetDescendants() do
                if v.Name:find'KeyCard' or v.Name:find'PasswordPaper' then
                    ESP.AddESP("KeyESPFolder", "钥匙卡", v, Color3.new(0,0,1))
                end
            end
            workspace.DescendantAdded:Connect(function(v)
                if v.Name:find'KeyCard' or v.Name:find'PasswordPaper' and a.esp then
                    ESP.AddESP("KeyESPFolder", "钥匙卡", v, Color3.new(0,0,1))
                end
            end)
        else
            ESP.Clear("KeyESPFolder")
        end
    end
})

Main:Toggle({
    Title = "透视假门和真门",
    Default = false,
    Image = "check",
    Callback = function(state)
        a.esp = state
        if a.esp then
            for _,v in next, workspace:GetDescendants() do
                if v.Name == 'TricksterDoor' then
                    ESP.AddESP("DoorESPFolder", "假门", v, Color3.new(0,0,1))
                end
                if v.Name == "NormalDoor" then
                    ESP.AddESP("DoorESPFolder", "门", v, Color3.new(0,0,1))
                end
            end
            workspace.DescendantAdded:Connect(function(v)
                if v.Name == 'TricksterDoor' and a.esp then
                    ESP.AddESP("DoorESPFolder", "假门", v, Color3.new(0,0,1))
                end
                if v.Name == 'NormalDoor' and a.esp then
                    ESP.AddESP("DoorESPFolder", "门", v, Color3.new(0,0,1))
                end
            end)
        else
            ESP.Clear("DoorESPFolder")
        end
    end
})

Main:Toggle({
    Title = "透视物品",
    Default = false,
    Image = "check",
    Callback = function(state)
        a.esp = state
        if a.esp then
            for _,v in next, workspace:GetDescendants() do
                if v:GetAttribute("InteractionType") == "ItemBase" then
                    ESP.AddESP("ItemESPFolder", "物品" .. v.Name, v, Color3.new(0,0,1))
                end
            end
            workspace.DescendantAdded:Connect(function(v)
                if v:GetAttribute("InteractionType") == "ItemBase" and a.esp then
                    ESP.AddESP("ItemESPFolder", "物品" .. v.Name, v, Color3.new(0,0,1))
                end
            end)
        else
            ESP.Clear("ItemESPFolder")
        end
    end
})
