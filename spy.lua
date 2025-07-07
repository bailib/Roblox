if not isfolder("HttpGetFolder") then
    makefolder("HttpGetFolder")
end

if not isfolder("WebhookFolder") then
    makefolder("WebhookFolder")
end

if not isfolder("RequestFolder") then
    makefolder("RequestFolder")
end

if not isfolder("LoadstringFolder") then
    makefolder("LoadstringFolder")
end

local httpcounter = 0
local webhookcounter = 0
local requestcounter = 0
local loadstringcounter = 0
local reques = req
local webhook
local http
local load
local bypassgroup

hookfunction(identifyexecutor, newcclosure(function()
    return "狗屎"
end))

bypassgroup = hookfunction(game:GetService("Players").LocalPlayer.IsInGroup, newcclosure(function()
    return true
end))

hookfunction(game:GetService("Players").LocalPlayer.Kick, newcclosure(function()
    return false
end))

webhook = hookfunction(reques, newcclosure(function(dat, ...)
    if dat.Url:find("discord.com/api/webhooks") then
        webhookcounter = webhookcounter + 1
        writefile(
            "WebhookFolder/WebhookLog_" .. webhookcounter .. ".txt",
            "Webhook URL: " .. dat.Url ..
            "\nWebhook Body: " .. tostring(dat.Body) ..
            "\nUse Method: " .. (dat.Method or "no method")
        )
        return {
            Success = true,
            StatusCode = 200,
            Body = '{"content": "fuck you"}'
        }
    end
    return webhook(dat, ...)
end))

http = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local Args = {...}
    httpcounter = httpcounter + 1
    
    if method == "HttpPostAsync" or method == "HttpPost" then
        writefile(
            "HttpGetFolder/HttpGetLog_" .. httpcounter .. ".txt",
            "HttpPost: " .. Args[1]
        )
    elseif method == "HttpGetAsync" or method == "HttpGet" then
        writefile(
            "HttpGetFolder/HttpGetLog_" .. httpcounter .. ".txt",
            "HttpGet: " .. Args[1]
        )
    elseif method == "GetObjects" then
        writefile(
            "HttpGetFolder/HttpGetLog_" .. httpcounter .. ".txt",
            "GetObjects: " .. Args[1]
        )
    end
    return http(self, ...)
end))

req = hookfunction(reques, newcclosure(function(dat, ...)
    requestcounter = requestcounter + 1
    writefile(
        "RequestFolder/RequestLog_" .. requestcounter .. ".txt",
        "URL: " .. dat.Url ..
        "\nBody: " .. tostring(dat.Body) ..
        "\nMethod: " .. (dat.Method or "no method")
    )
    return req(dat, ...)
end))

load = hookfunction(loadstring, newcclosure(function(...)
    local Args = {...}
    loadstringcounter = loadstringcounter + 1
    writefile("LoadstringFolder/LoadstringLog_" .. loadstringcounter .. ".lua", Args[1])
    return load(...)
end))
