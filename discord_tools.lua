local http = HttpClient.new()

local API = {
    friends = "https://discord.com/api/v9/users/@me/relationships",
    dms = "https://discord.com/api/v9/users/@me/channels",
}

function ask_token()
    local token = input("Enter your token: ")
    local resp = http:get(API.friends, token)
    if resp.status_code ~= 200 then print("Invalid token") return false end
    return token
end

register_tool("Discord tools", function()
    local tools = {
        "Mass flood to people",
    }
    for i, v in pairs(tools) do
        print(tostring(i)..": "..v)
    end
    local choice = tonumber(input("Enter your choice: "))
    local tool = tools[choice]
    if not tool then print("Invalid tool!") return end
    
    local token = ask_token()
    
    if token == false then return end
    

    if tool == tools[1] then
        local message = input("Message to spam: ")
        local resp = http:get(API.dms, token)
        local channels = json.parse(resp.text)
        for i, channel in pairs(channels) do
            http:post("https://discord.com/api/v9/channels/"..tostring(channel["id"]).."/messages", json.stringify({content = message}), token)
        end
        print("Flooded!")
    end
end)
