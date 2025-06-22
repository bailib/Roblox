local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:Notify({
    Title = "Open source",
    Content = "By Moxiaobai",
    Duration = 5,
})

local Window = WindUI:CreateWindow({
    Title = "Game Loader",
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
    Code = request({Url="https://raw.githubusercontent.com/bailib/Roblox/refs/heads/main/loader/loader.lua"}).Body,
})

local gamelist = game:HttpGet("https://raw.githubusercontent.com/bailib/Roblox/refs/heads/main/loader/list.lua")

for name, exec in pairs(gamelist) do
    Main:Button({
        Title = name,
        Desc = "click the button to open the script",
        Callback = function()
            loadstring(game:HttpGet(exec))()
        end
    })
end
