local data = loadstring(game:HttpGet("https://raw.githubusercontent.com/bailib/Roblox/refs/heads/main/main/data.lua"))()
local language = loadstring(game:HttpGet("https://raw.githubusercontent.com/bailib/Roblox/refs/heads/main/main/language.lua"))()
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:Notify({
    Title = language[game.Players.LocalPlayer.LocaleId].NotificationText,
    Content = language[game.Players.LocalPlayer.LocaleId].NotificationContent,
    Duration = 5,
})

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character
local hum = Character.HumanoidRootPart

local Window = WindUI:CreateWindow({
    Title = language[game.Players.LocalPlayer.LocaleId]["Brainrot Evolution"].Title,
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Author = language[game.Players.LocalPlayer.LocaleId].Author,
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
    Title = language[game.Players.LocalPlayer.LocaleId].OpenText,
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
Source = MainSection:Tab({ Title = "Source", Icon = "Sword" })

Source:Code({
    Code = request({Url="https://raw.githubusercontent.com/bailib/Roblox/refs/heads/main/Game/Brainrot%20Evolution"}).Body,
})

Main:Toggle({
    Title = language[game.Players.LocalPlayer.LocaleId]["Brainrot Evolution"].AttackAll,
    Image = "bird",
    Value = data["Brainrot Evolution"].AttackAll,
    Callback = function(state)
        data["Brainrot Evolution"].AttackAll = state
        spawn(function()
            while data["Brainrot Evolution"].AttackAll and wait() do
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Model") then
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("HumanoidRootPart"):FindFirstChild("MonsterHUD") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                            game:GetService("ReplicatedStorage").Packages.Knit.Services.MonsterService.RF.RequestAttack:InvokeServer(CFrame.new(v:GetPivot().Position))
                        end
                    end
                end
            end
        end)
    end
})

Main:Toggle({
    Title = language[game.Players.LocalPlayer.LocaleId]["Brainrot Evolution"].KillAura,
    Image = "bird",
    Value = data["Brainrot Evolution"].KillAura,
    Callback = function(state)
        data["Brainrot Evolution"].KillAura = state
        spawn(function()
            while data["Brainrot Evolution"].KillAura and wait() do
                local closestitem = nil
                local closestDistance = math.huge
                for _, v in next, workspace:GetChildren() do
                    if v:IsA("Model") then
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("HumanoidRootPart"):FindFirstChild("MonsterHUD") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                            local distance = (hum.Position - v.HumanoidRootPart.Position).magnitude
                            if distance < closestDistance then
                                closestDistance = distance
                                closestitem = v
                            end
                        end
                    end
                end
                if closestitem then
                    game:GetService("ReplicatedStorage").Packages.Knit.Services.MonsterService.RF.RequestAttack:InvokeServer(CFrame.new(closestitem:GetPivot().Position))
                end
            end
        end)
    end
})

Main:Toggle({
    Title = language[game.Players.LocalPlayer.LocaleId]["Brainrot Evolution"].TpAttack,
    Image = "bird",
    Value = data["Brainrot Evolution"].TpAttack,
    Callback = function(state)
        data["Brainrot Evolution"].TpAttack = state
        spawn(function()
            while data["Brainrot Evolution"].TpAttack and wait() do
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Model") then
                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("HumanoidRootPart"):FindFirstChild("MonsterHUD") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                            repeat
                                hum.CFrame = v.HumanoidRootPart.CFrame
                                game:GetService("ReplicatedStorage").Packages.Knit.Services.MonsterService.RF.RequestAttack:InvokeServer(CFrame.new(v:GetPivot().Position))
                            until v.Humanoid.Health <= 0
                        end
                    end
                end
            end
        end)
    end
})
