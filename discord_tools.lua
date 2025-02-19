local http = HttpClient.new()

local cfg = File.new("cfg.bin")

cfg:create()

local rcfg = cfg:read()

if rcfg == "" then cfg:write(json.stringify({token = nil})) else token = json.parse(rcfg).token end

local API = {
    friends = "https://discord.com/api/v9/users/@me/relationships",
    dms = "https://discord.com/api/v9/users/@me/channels",
}



function ask_token()
    local token = input("Enter your token: ")
    local resp = http:get(API.friends, token)
    if resp.status_code ~= 200 then print("Invalid token") return false end
    cfg:write(json.stringify({token = token}))
    return token
end

register_tool("Discord tools", function()
    tools = {
        "Mass flood to people"
    }

    local callbacks = {
        function(token)
            local message = input("Message to spam: ")
            local resp = http:get(API.dms, token)
            local channels = json.parse(resp.text)
            print("Processing...")
            for i, channel in pairs(channels) do
                http:post("https://discord.com/api/v9/channels/"..tostring(channel["id"]).."/messages", json.stringify({content = message}), token)
            end
            print("Sent all messages!")
        end,
    }
    for i, v in ipairs(tools) do
        print(tostring(i)..": "..v)
    end
    local choice = tonumber(input("Enter your choice: "))
    local tool = callbacks[choice]
    if not tool then print("Invalid tool!") return end
    
    if token then print("Loaded token from cfg.bin, if you wish to change, delete cfg.bin file and restart program!") else token = ask_token() end
    
    if token == false then return end
    
    tool(token)
end)
