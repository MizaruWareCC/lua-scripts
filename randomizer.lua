register_tool("Randomizer", function() 
  local ans = input("Random number or string: ")
  if ans:startswith("n") then
      print(random.number(tonumber(input("Enter minimum value: ")), tonumber(input("Enter maximum value: "))))
  elseif ans:startswith("s") then
      print(random.string(tonumber(input("Enter length: "))))
  else
    print("Unknown option!")
  end
end)
