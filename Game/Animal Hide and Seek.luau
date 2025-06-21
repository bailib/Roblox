local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/bailib/Roblox/refs/heads/main/main/ESP.lua"))()
local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/bailib/Roblox/refs/heads/main/main/Aimbot.lua"))()
local data = loadstring(game:HttpGet("https://raw.githubusercontent.com/bailib/Roblox/refs/heads/main/main/data.lua"))()
local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win = lib:Window("Animal Hide and Seek",Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)

local Section = win:Tab("Main")

ESP.AddFolder("HiderESPFolder")

local hiders = {}
for _, v in ipairs(Players:GetPlayers()) do
    if v ~= Player and v.Team.Name == "Hider" then
        table.insert(hiders, v)
    end
end

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character
local hum = Character.HumanoidRootPart

Section:Label("By Moxiaobai | Open source")

Section:Toggle("自瞄躲藏者", data["Animal Hide and Seek"].AimHider, function(state)
    data["Animal Hide and Seek"].AimHider = state
    spawn(function()
        while data["Animal Hide and Seek"].AimHider and wait() then
            local closestPlayer = nil
            local closestDistance = math.huge
            for _, v in next, OvO:GetChildren() do
                if v ~= O_O and v.Team.Name == "Hider" and v.Character.Humanoid.Health > 0 then
                    if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (O_O.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = v.Character
                        end
                    end
                end
            end
            if closestPlayer then
                camera.CFrame = CFrame.lookAt(camera.CFrame.p, closestPlayer.HumanoidRootPart.Position)
            end
        end
    end)
end)

Section:Toggle("透视躲藏者", data["Animal Hide and Seek"].ESPHider, function(state)
    data["Animal Hide and Seek"].ESPHider = state
    if data["Animal Hide and Seek"].ESPHider then
        for _,v in pairs(Players:GetPlayer()) do
            if v ~= Player and v.Team.Name == "Hider" then
                ESP.AddESP("HiderESPFolder", "玩家" .. v.Name, v.Character, Color3.new(0,0,1))
            end
        end
    else
        ESP.Clear("HiderESPFolder")
    end
end)

Section:Toggle("自动收集金币", data["Animal Hide and Seek"].AutoCoin, function(state)
    data["Animal Hide and Seek"].AutoCoin = state
    spawn(function()
        while data["Animal Hide and Seek"].AutoCoin and wait() do
            for _,v in next,workspace.CurrentMap.SPAWNED_ANIMALS:GetChildren() do
                firetouchinterest(workspace.CurrentMap.SPAWNED_COINS.CoinModel.Hitbox, hum, 0)
                firetouchinterest(workspace.CurrentMap.SPAWNED_COINS.CoinModel.Hitbox, hum, 1)
            end
        end
    end)
end)

Section:Toggle("永远成为搜查者", data["Animal Hide and Seek"].AlwaysSeeker, function(state)
    data["Animal Hide and Seek"].AlwaysSeeker = state
    spawn(function()
        while data["Animal Hide and Seek"].AlwaysSeeker and wait() do
            if Player.PlayerGui.MainGui.GameFrame.RoleSelectionFrame.Visible == true then
                Player.PlayerGui.MainGui.GameFrame.RoleSelectionFrame.CanvasGroup.MainContainer.KillerChanceTxt = "Chance for killer: 100%"
                Player.PlayerGui.MainGui.GameFrame.RoleSelectionFrame.CanvasGroup.MainContainer.RoleTxt.Text = "killer"
            end
            if Player.Team.Name ~= "Seeker" then
                Player.Team = game:GetService("Teams").Seeker
            end
        end
    end)
end)

Section:Toggle("自动走向躲藏者", data["Animal Hide and Seek"].AutoWalk, function(state)
    data["Animal Hide and Seek"].AutoWalk = state
    spawn(function()
        while data["Animal Hide and Seek"].AutoWalk and wait() do
            local nearestPlayer, minDistance = nil, math.huge
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= Player and player.Character then
                    if player.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (targetRoot.Position - localChar.HumanoidRootPart.Position).Magnitude
                        if distance < minDistance then
                            minDistance = distance
                            nearestPlayer = player
                        end
                    end
                end
            end
            if nearestPlayer then
                hum:MoveTo(nearestPlayer.Character.HumanoidRootPart.Position)
            end
        end
    end)
end)
