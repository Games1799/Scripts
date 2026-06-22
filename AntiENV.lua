if not isfile("ANTI_ENV_LOGGER") then
   writefile("ANTI_ENV_LOGGER", "true")
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/AntiENV.lua"))()
else
   print("Hello")
end
