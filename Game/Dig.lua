local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:Notify({
    Title = "open source",
    Content = "by 月星",
    Duration = 5,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local hum = Character.HumanoidRootPart
local PlayerGui = LocalPlayer.PlayerGui

local Window = WindUI:CreateWindow({
    Title = "Dig [idk days]",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = "月星",
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
    Title = "main",
    Opened = true,
})

Main = MainSection:Tab({ Title = "Main", Icon = "Sword" })

local main = {
    InstantDig = false,
    AutoPile = false,
    AutoDig = false,
    AutoSell = false,
    AutoHit = false,
    Select = "Normal",
    nocd = false,
}

local Teleport = {
    ["Fox Town"] = Vector3.new(2057.60, 111.52, -349.58),
    ["Fernhill Forest"] = Vector3.new(1751.17, 82.13, 64.73),
    ["The Ocean"] = Vector3.new(1297.90, 77.40, 493.41),
    ["Verdant Vale"] = Vector3.new(3497.55, 82.05, 1509.53),
    ["Rooftop Woodlands"] = Vector3.new(3910.74, 225.72, -383.09),
    ["The Copper Mesa"] = Vector3.new(-6588.38, 247.09, -2417.21),
    ["Phoenix Tribe"] = Vector3.new(-8004.51, 342.09, -1848.01),
    ["Alona Jungles"] = Vector3.new(-7831.70, 342.09, -2314.44),
    ["火山"] = Vector3.new(-8194.76, 342.09, -1990.73),
    ["监狱"] = Vector3.new(-431.23, -281.54, -1447.26),
    ["蓝色草坪"] = Vector3.new(3424.43, -717.86, 2341.75),
    ["水晶蘑菇洞"] = Vector3.new(4057.11, -667.86, 2468.59),
    ["大草坪"] = Vector3.new(4274.68, 81.95, 171.16),
    ["海底沙滩"] = Vector3.new(6277.88, -107.69, -725.93),
    ["Mount Cinder"] = Vector3.new(4555.56, 1101.71, -1714.06),
    ["Glacial Hollow"] = Vector3.new(5115.66, 1118.91, -2542.95),
    ["飞机出事点"] = Vector3.new(5752.44,1141.93, -3760.88),
    ["Tom's Bakery"] = Vector3.new(5580.88, 249.98, -89.01),
    ["Cinder Peak"] = Vector3.new(4846.74, -1244.63, -4610.70),
    ["蜘蛛洞"] = Vector3.new(3918.42, -360.02, -2727.59),
    ["地洞商店"] = Vector3.new(4546.61, -360.01, -1624.68),
    ["熔岩坑"] = Vector3.new(5509.48, -408.55, -1997.21),
    ["矿坑"] = Vector3.new(2961.07, 21.32, -903.66),
    ["矿坑-1层"] = Vector3.new(2936.01, -359.93, -904.18)
}

local finishargs = {0, {
    {Position=Vector3.new(2096.329,108.525,-383.752), Orientation=Vector3.new(0,0,0), Size=Vector3.new(0.1,0.1,0.1), Name="PositionPart", Transparency=1, Material=Enum.Material.Plastic, Shape=Enum.PartType.Block},
    {Position=Vector3.new(2096.329,108.475,-383.752), Orientation=Vector3.new(0,90,90), Size=Vector3.new(0.2,5.908,6.186), Name="CenterCylinder", Transparency=0, Material=Enum.Material.Pebble, Shape=Enum.PartType.Cylinder},
    {Position=Vector3.new(2098.504,108.486,-381.576), Orientation=Vector3.new(-33,45.004,0), Size=Vector3.new(3.727,2.592,2.724), Name="Rock/1", Transparency=0, Material=Enum.Material.Pebble, Shape=Enum.PartType.Block},
    {Position=Vector3.new(2099.316,108.214,-383.102), Orientation=Vector3.new(-26,77.727,0), Size=Vector3.new(2.506,2.592,2.388), Name="Rock/2", Transparency=0, Material=Enum.Material.Pebble, Shape=Enum.PartType.Block},
    {Position=Vector3.new(2099.123,107.873,-384.793), Orientation=Vector3.new(-17,110.458,0), Size=Vector3.new(2.446,2.592,2.155), Name="Rock/3", Transparency=0, Material=Enum.Material.Pebble, Shape=Enum.PartType.Block},
    {Position=Vector3.new(2098.167,108.291,-386.206), Orientation=Vector3.new(-28,143.18,0), Size=Vector3.new(4.359,2.592,2.671), Name="Rock/4", Transparency=0, Material=Enum.Material.Pebble, Shape=Enum.PartType.Block},
    {Position=Vector3.new(2096.54,107.873,-386.725), Orientation=Vector3.new(-17,175.908,0), Size=Vector3.new(2.492,2.592,2.358), Name="Rock/5", Transparency=0, Material=Enum.Material.Pebble, Shape=Enum.PartType.Block},
    {Position=Vector3.new(2094.854,108.525,-386.453), Orientation=Vector3.new(-34,-151.358,0), Size=Vector3.new(4.504,2.592,2.66), Name="Rock/6", Transparency=0, Material=Enum.Material.Pebble, Shape=Enum.PartType.Block},
    {Position=Vector3.new(2093.665,108.099,-385.207), Orientation=Vector3.new(-23,-118.639,0), Size=Vector3.new(2.472,2.592,2.243), Name="Rock/7", Transparency=0, Material=Enum.Material.Pebble, Shape=Enum.PartType.Block},
    {Position=Vector3.new(2093.368,107.836,-383.54), Orientation=Vector3.new(-16,-85.909,0), Size=Vector3.new(2.372,2.592,2.741), Name="Rock/8", Transparency=0, Material=Enum.Material.Pebble, Shape=Enum.PartType.Block},
    {Position=Vector3.new(2093.871,108.33,-381.912), Orientation=Vector3.new(-29,-53.178,0), Size=Vector3.new(2.663,2.592,2.894), Name="Rock/9", Transparency=0, Material=Enum.Material.Pebble, Shape=Enum.PartType.Block},
    {Position=Vector3.new(2095.253,108.408,-380.871), Orientation=Vector3.new(-31,-20.461,0), Size=Vector3.new(2.77,2.592,2.703), Name="Rock/10", Transparency=0, Material=Enum.Material.Pebble, Shape=Enum.PartType.Block},
    {Position=Vector3.new(2096.976,108.099,-380.784), Orientation=Vector3.new(-23,12.276,0), Size=Vector3.new(2.666,2.592,2.484), Name="Rock/11", Transparency=0, Material=Enum.Material.Pebble, Shape=Enum.PartType.Block}
}}

Main:Toggle({
    Title = "快速完成挖掘",
    Image = "bird",
    Value = main.InstantDig,
    Callback = function(state)
        main.InstantDig = state
        if main.InstantDig then
            if PlayerGui:FindFirstChild("Dig") then
                game:GetService("ReplicatedStorage").Remotes.Dig_Finished:FireServer(unpack(finishargs))
            end
            instantDigConnection = PlayerGui.ChildAdded:Connect(function(child)
                if child.Name == "Dig" and PlayerGui:FindFirstChild("Dig") and main.InstantDig then
                    game:GetService("ReplicatedStorage").Remotes.Dig_Finished:FireServer(unpack(finishargs))
                end
            end)
        end
    end
})

Main:Toggle({
    Title = "自动挖掘",
    Image = "bird",
    Value = main.AutoDig,
    Callback = function(state)
        main.AutoDig = state
        spawn(function()
            while main.AutoDig and task.wait() do
                if Character then
                    local tool = Character:FindFirstChildWhichIsA("Tool")
                    if tool and tool:GetAttribute("IsDigging") == false then
                        tool:Activate()
                    end
                end
            end
        end)
    end
})

Main:Dropdown({
    Title = "选择方式",
    Values = {"完美", "普通", "随机"},
    Value = "完美",
    Callback = function(option)
        main.Select = option
    end
})

Main:Toggle({
    Title = "自动完成挖掘",
    Image = "bird",
    Value = main.AutoHit,
    Callback = function(state)
        main.AutoHit = state
        LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
            if child.Name == "Safezone" and main.AutoHit then
                local holder = child:FindFirstChild("Holder")
                if holder thenva
                    local playerBar = holder:FindFirstChild("PlayerBar")
                    if playerBar then
                        local shade = playerBar:FindFirstChild("Shade")
                        if shade then
                            shade.RenderStepped:Connect(function()
                                if not main.Select then return end
                                
                                local hitAreaObj
                                if main.Select == "Strong" then
                                    hitAreaObj = shade:FindFirstChild("Area_Strong")
                                elseif main.Select == "Normal" then
                                    hitAreaObj = shade:FindFirstChild("Area_Hit")
                                elseif main.Select == "Both" then
                                    hitAreaObj = shade:FindFirstChild("Area_Strong") or shade:FindFirstChild("Area_Hit")
                                end
                                
                                if not hitAreaObj then return end
                                
                                local pos = hitAreaObj.AbsolutePosition
                                local size = hitAreaObj.AbsoluteSize
                                
                                if LocalPlayer.Character then
                                    local tool = LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
                                    if tool then
                                        tool:Activate()
                                    end
                                end
                            end)
                        end
                    end
                end
            end
        end)
    end
})

Main:Toggle({
    Title = "自动售卖",
    Image = "bird",
    Value = main.AutoSell,
    Callback = function(state)
        main.AutoSell = state
        spawn(function()
            while main.AutoSell and task.wait() do
                game:GetService("ReplicatedStorage").DialogueRemotes.SellAllItems:FireServer(workspace.World.NPCs.Rocky)
            end
        end)
    end
})

Main:Toggle({
    Title = "无冷却",
    Image = "bird",
    Value = main.nocd,
    Callback = function(state)
        main.nocd = state
        local originalWait = task.wait
        task.wait = function(...)
            if main.nocd then
                return
            end
            return originalWait(...)
        end
    end
})

Main:Dropdown({
    Title = "选择传送地点 (位置由c20提供)",
    Values = {"Fox Town", "Fernhill Forest", "The Ocean", "Verdant Vale", "Rooftop Woodlands", "The Copper Mesa", "Phoenix Tribe", "Alona Jungles", "火山", "监狱", "蓝色草坪", "水晶蘑菇洞", "大草坪", "海底沙滩", "Mount Cinder", "Glacial Hollow", "飞机出事点", "Tom's Bakery", "Cinder Peak", "蜘蛛洞", "地洞商店", "熔岩坑", "矿坑", "矿坑-1层"},
    Value = "默认选择",
    Callback = function(option)
        if Teleport[option] then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Teleport[option])
        end
    end
})
