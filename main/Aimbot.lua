local Aimbot = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

function Aimbot.Aim(
    target: Player | Model,
    aimmethod: string,
    method: string,
    aimpart: string,
    teamcheck: boolean,
    wallcheck: boolean
)
    local camera = workspace.CurrentCamera
    local localChar = localPlayer.Character
    if not localChar then return end

    local targetChar = if typeof(target) == "Instance" and target:IsA("Player") then target.Character else target
    local targetPart = targetChar and targetChar:FindFirstChild(aimpart)
    if not targetPart then return end

    if teamcheck then
        local localTeam = localPlayer.Team
        if target:IsA("Player") and target.Team == localTeam then
            return
        end
    end

    if wallcheck then
        local origin = camera.CFrame.Position
        local direction = (targetPart.Position - origin).Unit * 1000
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.FilterDescendantsInstances = {localChar, targetChar}
        
        local rayResult
        if method == "Raycast" then
            rayResult = workspace:Raycast(origin, direction, raycastParams)
        elseif method == "FindPartOnRayWithIgnoreList" then
            rayResult = workspace:FindPartOnRay(Ray.new(origin, direction), raycastParams.FilterDescendantsInstances)
        end
        
        if rayResult and rayResult.Instance then
            return
        end
    end

    if aimmethod == "lock" then
        camera.CFrame = CFrame.lookAt(camera.CFrame.Position, targetPart.Position)
    elseif aimmethod == "silent" then
        return targetPart.Position
    end
end

function Aimbot.AutoAimLoop(
    aimmethod: string,
    method: string,
    aimpart: string,
    teamcheck: boolean,
    wallcheck: boolean,
    sensitivity: number
)
    local connection
    connection = RunService.Heartbeat:Connect(function()
        local nearestPlayer, minDist = nil, math.huge
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                local char = player.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if root then
                    local dist = (root.Position - localPlayer:DistanceFromCharacter(root.Position))
                    if dist < minDist then
                        minDist = dist
                        nearestPlayer = player
                    end
                end
            end
        end

        if nearestPlayer then
            Aimbot.Aim(nearestPlayer, aimmethod, method, aimpart, teamcheck, wallcheck)
        end
    end)
    
    return connection
end

return Aimbot
