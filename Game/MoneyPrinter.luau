local Http = game:GetService("HttpService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Api = "https://games.roblox.com/v1/games/"
local _place = game.PlaceId
local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
function ListServers(cursor)
    local Raw = game:HttpGet(_servers.. ((cursor and "&cursor="..cursor) or ""))
    return Http:JSONDecode(Raw)
end
local Server, Next; repeat
    local Servers = ListServers(Next)
    local numServers = #Servers.data
    if numServers > 0 then
        local randomIndex = math.random(1, numServers)
        Server = Servers.data[randomIndex] 
    end
    Next = Servers.nextPageCursor
until Server
local MainScript = [[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/bailib/Roblox/refs/heads/main/Game/MoneyPrinter.luau"))()
]]

repeat task.wait()
    LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character:GetPivot().Position + Vector3.new(1, 0, 0))
until not LocalPlayer.Character:FindFirstChild("ForceField")

for i, v in pairs(workspace.Game.Entities.ItemPickup:GetChildren()) do
    Prompt = v.PrimaryPart:FindFirstChildOfClass("ProximityPrompt")
    if Prompt.ObjectText == "Money Printer" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame
        wait()
        fireproximityprompt(Prompt)
    else
        queue_on_teleport(MainScript)
        wait()
        game:GetService("TeleportService"):TeleportToPlaceInstance(_place,Server.id,LocalPlayer)
    end
end
