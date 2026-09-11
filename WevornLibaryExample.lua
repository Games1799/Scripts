local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/Libary/WevornLibary.lua"))()
local Window = Library:Window("Wevorn Libary")
local Main = Window:Server("Main", "http://www.roblox.com/asset/?id=6031075938")
local Settings = Window:Server("Settings", "http://www.roblox.com/asset/?id=117395004084347")
local MainSection = Main:Section("Test")
Main:Section("Test 2")

MainSection:Button("Hi", function()
   print("Hi")
end)

MainSection:Toggle("Test", function(state)
   print(state)
end)

MainSection:Textbox("Test Text #1", "Enter Text...", true, function(Text)
   print(Text)
end)

MainSection:Textbox("Test Text #2", "Enter Text...", false, function(Text)
   print(Text)
end)

MainSection:Slider("Test Slider", 0, 100, 50, function(Value)
   print(Value)
end)
MainSection:Slider("Test Slider 2", 0, 100, 50, function(Value)
   print(Value)
end)

MainSection:Dropdown("Test Dropdown 1", {"Test 1", "Test 2", "Test 3", "Test 4", "Test 5"}, function(Value)
   print(Value)
end)

MainSection:Dropdown("Test Dropdown 2", {"Test 1", "Test 2"}, function(Value)
   print(Value)
end)

MainSection:Dropdown("Test Dropdown 3", {"Test 1"}, function(Value)
   print("Выбрано:", Value)
end)

MainSection:Label("Test TextLabel")

MainSection:Colorpicker("Test", Color3.fromRGB(255, 0, 0), function(Color)
   print(Color)
end)

Window:Notification("Test Notification", "Test Text", "Close")
