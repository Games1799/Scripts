--[[
░██████╗░░█████╗░███╗░░░███╗███████╗░██████╗
██╔════╝░██╔══██╗████╗░████║██╔════╝██╔════╝
██║░░██╗░███████║██╔████╔██║█████╗░░╚█████╗░
██║░░╚██╗██╔══██║██║╚██╔╝██║██╔══╝░░░╚═══██╗
╚██████╔╝██║░░██║██║░╚═╝░██║███████╗██████╔╝
 ░╚═════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝╚═════╝░
]]--

-- Wevorn Libary V1.0
-- https://discord.gg/rncd8vMV39
--[[
   Methods:
   – Libary.Window(Name: string): table
      |
      –> Window.Notification(titletext: string, desctext: string, btntext: string): table
            |
            –> Notification.Close()
            –> Notification.SetTitle(Text: string)
            –> Notification.SetDescription(Text: string)
            –> Notification.SetButton(Text: string?)
       |
       –> Window.Server(Name: string, Image: string?): table
             |
             –> Server.Section(Name: string): table | Server.Channel(Name: string): table
                   |
                   –> Section.Select()
                   –> Section.Button(Name: string, Callback: () -> ()): table
                         |
                         –> Button.SetText(Text: string?)
                         –> Button.SetCallback(NewCallback: () -> ())
                   |
                   –> Section.Toggle(Name: string, Default: boolean, Callback: (boolean) -> ()): table
                         |
                         –> Toggle.SetText(Text: string?)
                         –> Toggle.GetValue(): boolean
                         –> Toggle.SetValue(Value: boolean)
                   |
                   –> Section.Textbox(text: string, placetext: string, disapper: boolean, callback: (string) -> ()): table
                         |
                         –> Textbox.GetText(): string
                         –> Textbox.SetText(Text: string)
                         –> Textbox.SetPlaceHolder(Text: string)
                         –> Textbox.SetCallback(NewCallback: (string) -> ())
                   |
                   –> Section.Label(text: string): table
                         |
                         –> Label.Change(NewText: string)
                         –> Label.GetText(): string
                   |
                   –> Section.Slider(text: string, min: number, max: number, start: number, callback: (number) -> ()): table
                         |
                         –> Slider.GetValue(): number
                         –> Slider.Change(Value: number)
                         –> Slider.SetCallback(NewCallback: (number) -> ())
                   |
                   –> Section.Colorpicker(text: string, preset: Color3, callback: (Color3) -> ()): table
                         |
                         –> Colorpicker.GetColor(): Color3
                         –> Colorpicker.Change(NewColor: Color3)
                         –> Colorpicker.SetCallback(NewCallback: (Color3) -> ())
                   |
                   –> Section.Dropdown(Name: string, List: table, Callback: (any) -> ()): table
                         |
                         –> Dropdown.Add(Value: string): nil
                         –> Dropdown.Close(): nil
                         –> Dropdown.Clear(): nil
                         –> Dropdown.SetCallback(NewCallback: (any) -> ())
                         –> Dropdown.GetValue(): string
                         –> Dropdown.Set(Value: string)
                   |
             |
             –> Server.Select()
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/Libary/WevornLibary.lua"))()
local Window = Library:Window("Wevorn Libary")
local Main = Window:Server("Main", "http://www.roblox.com/asset/?id=6031075938")
local Settings = Window:Server("Settings", "http://www.roblox.com/asset/?id=117395004084347")
local MainSection = Main:Section("Test")
Main:Section("Test 2")

MainSection:Button("Hi", function()
   print("Hi")
end)

MainSection:Toggle("Test", false, function(state)
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
   print(Value)
end)

MainSection:Label("Test TextLabel")

MainSection:Colorpicker("Test", Color3.fromRGB(255, 0, 0), function(Color)
   print(Color)
end)

Window:Notification("Test Notification", "Test Text", "Close")
