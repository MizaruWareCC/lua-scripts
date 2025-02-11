utils.reg_tool("File downloader", function()
    local site = input("Enter site: ")
    local http = HttpClient.new()
    print("Please, wait a bit...")
    local resp = http:get(site)
    if resp.status_code ~= 200 or resp.status_code ~= 204 then
        print("Failed to download! Check internet connection/url.")
    else
        local f = File.new(Directory.new(), "downloaded.txt")
        f:write(resp.text)
        print("Saved info to downloaded.txt it current directory!")
    end
end)
