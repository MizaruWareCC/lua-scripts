utils.reg_tool("Randomizer", function() 
  local ans = input("Random number or string: ")
  if ans:startswith("n") then print(random.number()) elseif ans:startswith("s") then print(random.string())) else print("Unknown option!") end
end)
