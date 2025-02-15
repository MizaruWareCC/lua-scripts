register_tool("Show site response", function()
    local site = input("Enter site: ")
    local http = HttpClient.new()
    print("Please, wait a bit...")
    local resp = http:get(site)
    if resp.status_code ~= 200 or resp.status_code ~= 204 then
        print("Failed to download! Check internet connection/url. Orresponse wasn't 200/204")
    else
        print(resp.text)
    end
end)
