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

local cloneref = cloneref or clonereference or (cache and cache.cloneref) or function(...: Instance): Instance
   return (...)
end
const function RandomName(): string 
  local String = ""
  for _ = 4, math.random(5, 8) do
     String = String .. string.char(math.random(1, 255))
  end
  return String
end

local UserInputService = cloneref(game:GetService("UserInputService"))
local TweenService = cloneref(game:GetService("TweenService"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local Players = cloneref(game:GetService("Players"))
local Player = Players.LocalPlayer
local PlayerGui = Player:FindFirstChildOfClass("PlayerGui")
local GetHUI = gethui or gethiddenui or get_hidden_ui 
local ProtectGui = protectgui or protect_gui or (syn and syn.protect_gui)

local Libary = {}
Libary.Window = function(Name: string): table
   local WindowAPI = {}
   local WindowName = type(Name) == "string" and Name or "Window"
   local ScreenGui = Instance.new("ScreenGui")
   if type(GetHUI) == "function" then
      ScreenGui.Parent = GetHUI()
   elseif type(ProtectGui) == "function" then
      ProtectGui(ScreenGui)
   elseif type(CoreGui) == "Instance" and CoreGui:FindFirstChild("RobloxGui") then
      ScreenGui.Parent = CoreGui
   else
      ScreenGui.Parent = PlayerGui 
   end
   local Window = Instance.new("Frame", ScreenGui)
   local UICorner = Instance.new("UICorner", Window)
   local UIStroke = Instance.new("UIStroke", Window)
   local UIGradient = Instance.new("UIGradient", Window)
   local Title = Instance.new("Frame", Window)
   local TitleText = Instance.new("TextLabel", Title)
   local Line = Instance.new("Frame", Window)
   local Sections = Instance.new("ScrollingFrame", Window)
   local SectionsLayout = Instance.new("UIListLayout", Sections)
   local SectionsLine = Instance.new("Frame", Window)
   local SectionsPadding = Instance.new("UIPadding", Sections)
   local CloseButton = Instance.new("TextButton", Window)
   local MinimizeButton = Instance.new("TextButton", Window)
   
   local ServersPanel = Instance.new("ScrollingFrame", Window)
   local ServersCorner = Instance.new("UICorner", ServersPanel)
   local ServersStroke = Instance.new("UIStroke", ServersPanel)
   local ServersButton = Instance.new("TextButton", Window)
   local ServersButtonCorner = Instance.new("UICorner", ServersButton)
   local ServersLayout = Instance.new("UIListLayout", ServersPanel)
   local ServersPadding = Instance.new("UIPadding", ServersPanel)
   
   ScreenGui.Name = RandomName() or "WevornLibary"
   Window.Name = RandomName() or "WevornWindow"
   Window.Size = UDim2.fromOffset(500, 350)
   Window.Position = UDim2.fromScale(0.5, 0.5)
   Window.AnchorPoint = Vector2.new(0.5, 0.5)
   Window.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
   Window.BackgroundTransparency = 0.15
   Window.BorderSizePixel = 0
   Window.ClipsDescendants = false
   ScreenGui.DisplayOrder = 2147483647
   UICorner.CornerRadius = UDim.new(0, 16)
   UIStroke.Color = Color3.fromRGB(255, 255, 255)
   UIStroke.Transparency = 0.85
   UIStroke.Thickness = 1
   UIGradient.Rotation = 135
   UIGradient.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 35)),
      ColorSequenceKeypoint.new(0.5, Color3.fromRGB(5, 5, 5)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20)),
    })
   UIGradient.Transparency = NumberSequence.new({
      NumberSequenceKeypoint.new(0, 0.15),
      NumberSequenceKeypoint.new(0.5, 0),
      NumberSequenceKeypoint.new(1, 0.2)
    })
   Title.Size = UDim2.new(1, 0, 0, 55)
   Title.Position = UDim2.fromOffset(0, 0)
   Title.BackgroundTransparency = 1
   Title.BorderSizePixel = 0
   Title.Active = true
   Title.ClipsDescendants = false
   TitleText.BackgroundTransparency = 1
   TitleText.Position = UDim2.fromOffset(20, 12)
   TitleText.Size = UDim2.new(1, -40, 0, 35)
   TitleText.Text = WindowName
   TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
   TitleText.TextSize = 20
   TitleText.Font = Enum.Font.GothamSemibold
   TitleText.TextXAlignment = Enum.TextXAlignment.Left
   TitleText.Active = false
   Line.Parent = Window
   Line.Size = UDim2.new(1, 0, 0, 1)
   Line.Position = UDim2.fromOffset(0, 55)
   Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   Line.BackgroundTransparency = 0.8
   Line.BorderSizePixel = 0

   Sections.Size = UDim2.new(0, 150, 1, -56)
   Sections.Position = UDim2.fromOffset(0, 56)
   Sections.BackgroundTransparency = 1
   Sections.BorderSizePixel = 0
   Sections.ScrollBarThickness = 0
   Sections.AutomaticCanvasSize = Enum.AutomaticSize.None
   Sections.ScrollingDirection = Enum.ScrollingDirection.Y
   SectionsLayout.Padding = UDim.new(0, 6)
   SectionsLayout.SortOrder = Enum.SortOrder.LayoutOrder 
   SectionsLine.Size = UDim2.new(0, 1, 1, -56)
   SectionsLine.Position = UDim2.fromOffset(150, 56)
   SectionsLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   SectionsLine.BackgroundTransparency = 0.8
   SectionsLine.BorderSizePixel = 0
   SectionsPadding.PaddingTop = UDim.new(0, 10)
   SectionsPadding.PaddingBottom = UDim.new(0, 10)
   SectionsPadding.PaddingLeft = UDim.new(0, 10)
   SectionsPadding.PaddingRight = UDim.new(0, 10)
   
   SectionsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
      Sections.CanvasSize = UDim2.fromOffset(0, SectionsLayout.AbsoluteContentSize.Y + SectionsPadding.PaddingTop.Offset + SectionsPadding.PaddingBottom.Offset)
  end)
   
   CloseButton.Size = UDim2.fromOffset(35, 35)
   CloseButton.Position = UDim2.new(1, -45, 0, 10)
   CloseButton.BackgroundTransparency = 1
   CloseButton.BorderSizePixel = 0
   CloseButton.Text = "×"
   CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
   CloseButton.TextSize = 40
   CloseButton.Font = Enum.Font.Gotham
   CloseButton.AutoButtonColor = false
   
   MinimizeButton.Size = UDim2.fromOffset(35, 35)
   MinimizeButton.Position = UDim2.new(1, -85, 0, 10)
   MinimizeButton.BackgroundTransparency = 1
   MinimizeButton.BorderSizePixel = 0
   MinimizeButton.Text = "−"
   MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
   MinimizeButton.TextSize = 35
   MinimizeButton.Font = Enum.Font.GothamMedium
   MinimizeButton.AutoButtonColor = false
   
   ServersButton.Size = UDim2.fromOffset(24, 42)
   ServersButton.Position = UDim2.new(0, -25, 0.5, -21)
   ServersButton.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
   ServersButton.BackgroundTransparency = 0.15
   ServersButton.BorderSizePixel = 0
   ServersButton.Text = "←"
   ServersButton.TextColor3 = Color3.fromRGB(255, 255, 255)
   ServersButton.TextSize = 16
   ServersButton.Font = Enum.Font.GothamMedium
   ServersButton.AutoButtonColor = false
   ServersButton.ZIndex = 20
   ServersButtonCorner.CornerRadius = UDim.new(0, 7)
   ServersPanel.Size = UDim2.new(0, 85, 1, 0)
   ServersPanel.Position = UDim2.new(0, 0, 0, 0)
   ServersPanel.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
   ServersPanel.BackgroundTransparency = 1
   ServersPanel.BorderSizePixel = 0
   ServersPanel.ZIndex = 0
   ServersPanel.AutomaticCanvasSize = Enum.AutomaticSize.None
   ServersPanel.ScrollBarThickness = 0
   ServersPanel.ScrollingDirection = Enum.ScrollingDirection.Y
   ServersPanel.CanvasSize = UDim2.fromOffset(0, 0)

   ServersLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
      ServersPanel.CanvasSize = UDim2.fromOffset(0, ServersLayout.AbsoluteContentSize.Y + ServersPadding.PaddingTop.Offset + ServersPadding.PaddingBottom.Offset)
   end)
   
   ServersCorner.CornerRadius = UDim.new(0, 16)
   ServersStroke.Color = Color3.fromRGB(255, 255, 255)
   ServersStroke.Transparency = 1
   ServersStroke.Thickness = 1
   ServersLayout.Padding = UDim.new(0, 8)
   ServersLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
   ServersLayout.SortOrder = Enum.SortOrder.LayoutOrder
   ServersPadding.PaddingTop = UDim.new(0, 8)
   
   local ServersOpen = false
   local Servers = {}
   local CurrentServer = nil
   ServersButton.Activated:Connect(function()
      ServersOpen = not ServersOpen
      if ServersOpen then
         ServersButton.Text = "→"
         for _, v in ipairs(Servers) do
            v.Button.Visible = true
         end
         local Tween1 = TweenService:Create(ServersPanel, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0, -111, 0, 0)})
         local Tween2 = TweenService:Create(ServersPanel, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15})
         local Tween3 =TweenService:Create(ServersStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.85})
         Tween1:Play()
         Tween2:Play()
         Tween3:Play()
         Tween1.Completed:Once(function()
            Tween1:Destroy()
         end)
         Tween2.Completed:Once(function()
            Tween2:Destroy()
         end)
         Tween3.Completed:Once(function()
            Tween3:Destroy()
         end)
      else
         ServersButton.Text = "←"
         for _, v in ipairs(Servers) do
            v.Button.Visible = false
         end
         local Tween1 = TweenService:Create(ServersPanel, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)})
         local Tween2 = TweenService:Create(ServersPanel, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
         local Tween3 = TweenService:Create(ServersStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 1})
         Tween1:Play()
         Tween2:Play()
         Tween3:Play()
         Tween1.Completed:Once(function()
            Tween1:Destroy()
         end)
         Tween2.Completed:Once(function()
            Tween2:Destroy()
         end)
         Tween3.Completed:Once(function()
            Tween3:Destroy()
         end)
      end
   end)

   local Minimized, WindowSize = false, Window.Size
   local Notifications = {}
   MinimizeButton.Activated:Connect(function()
      Minimized = not Minimized
      if Minimized then    
         for _, v in ipairs(Notifications) do
            if v.Parent then
               local Tween = TweenService:Create(v, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
               Tween:Play()
               Tween.Completed:Once(function()
                  Tween:Destroy()
               end)
               local Notification = v:FindFirstChildWhichIsA("Frame")
               if Notification then
                  local Tween2 = TweenService:Create(Notification, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, 10)})
                  Tween2:Play()
                  Tween2.Completed:Once(function()
                     Tween2:Destroy()
                  end)
                  for _, k in ipairs(Notification:GetDescendants()) do
                     if k:IsA("TextLabel") then
                        local Tween3 = TweenService:Create(k, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 1})
                        Tween3:Play()
                        Tween3.Completed:Once(function()
                           Tween3:Destroy()
                        end)
                     elseif k:IsA("TextButton") then
                        local Tween4 = TweenService:Create(k, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 1, BackgroundTransparency = 1})
                        Tween4:Play()
                        Tween4.Completed:Once(function()
                           Tween4:Destroy()
                        end)
                     elseif k:IsA("UIStroke") then
                        local Tween5 = TweenService:Create(k, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 1})
                        Tween5:Play()
                        Tween5.Completed:Once(function()
                           Tween5:Destroy()
                        end)
                     end
                  end
               end
               task.delay(0.25, function()
                  if v.Parent and Minimized then
                     v.Visible = false
                  end
              end)
           end
         end     
         if ServersOpen then
            ServersOpen = false
            ServersButton.Text = "←"
            local Tween1 = TweenService:Create(ServersPanel, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1})
            local Tween2 =TweenService:Create(ServersStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 1})
            Tween1:Play()
            Tween2:Play()
            Tween1.Completed:Once(function()
               Tween1:Destroy()
            end)
            Tween2.Completed:Once(function()
               Tween2:Destroy()
            end)
         end
         ServersButton.Active = false
         ServersButton.Interactable = false
         local Tween2 = TweenService:Create(ServersButton, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0.5, -21), BackgroundTransparency = 1, TextTransparency = 1})
         Tween2:Play()
         Tween2.Completed:Once(function()
            Tween2:Destroy()
         end)
         Sections.Visible = false
         SectionsLine.Visible = false
         Line.Visible = false
         for _, v in ipairs(Servers) do
            for _, k in ipairs(v.Sections) do
               k.Content.Visible = false
            end
         end
         local Tween1 = TweenService:Create(Window, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(WindowSize.X.Offset, 55)})
         Tween1:Play()
         Tween1.Completed:Once(function()
            Tween1:Destroy()
         end)
         for _, v in ipairs(Servers) do
            v.Button.BackgroundTransparency = 1
            v.Button.Active = false
            v.Button.Interactable = false
            for _, k in ipairs(v.Button:GetChildren()) do
               if k:IsA("ImageLabel") then
                  k.ImageTransparency = 1
               elseif k:IsA("TextLabel") then
                  k.TextTransparency = 1
               end
            end
         end
      else
         MinimizeButton.Text = "−"   
         for _, v in ipairs(Notifications) do
            if v.Parent then
               v.Visible = true
               local Tween = TweenService:Create(v, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.35})
               Tween:Play()
               Tween.Completed:Once(function()
                  Tween:Destroy()
               end)
               local Notification = v:FindFirstChildWhichIsA("Frame")
               if Notification then
                  local Tween1 = TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.5, 0.5), BackgroundTransparency = 0.05})
                  local Tween2 = TweenService:Create(Notification:FindFirstChildOfClass("UIStroke"), TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.85})
                  Tween1:Play()
                  Tween2:Play()
                  Tween1.Completed:Once(function()
                     Tween1:Destroy()
                  end)
                  Tween2.Completed:Once(function()
                     Tween2:Destroy()
                  end)
                  for _, k in ipairs(Notification:GetDescendants()) do
                     if k:IsA("TextLabel") then
                        local Tween3 = TweenService:Create(k, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0})
                        Tween3:Play()
                        Tween3.Completed:Once(function()
                           Tween3:Destroy()
                        end)
                     elseif k:IsA("TextButton") then
                        local Tween4 = TweenService:Create(k, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15, TextTransparency = 0})
                        Tween4:Play()
                        Tween4.Completed:Once(function()
                           Tween4:Destroy()
                        end)
                        local Stroke = k:FindFirstChildOfClass("UIStroke")
                        if Stroke then
                           local Tween5 = TweenService:Create(Stroke, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.92})
                           Tween5:Play()
                           Tween5.Completed:Once(function()
                              Tween5:Destroy()
                           end)
                        end
                     end
                  end
               end
            end
         end   
         ServersButton.Active = true
         ServersButton.Interactable = true
         for _, v in ipairs(Notifications) do
         if v.Parent then
            local Tween = TweenService:Create(v, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.35})
            Tween:Play()
            Tween.Completed:Once(function()
               Tween:Destroy()
            end)
            local Notification = v:FindFirstChildWhichIsA("Frame")
               if Notification then
                  local Tween1 = TweenService:Create(Notification, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15, Position = UDim2.new(0.5, 0, 0.5, 18)})
                  Tween1:Play()
                  Tween1.Completed:Once(function()
                     Tween1:Destroy()
                  end)
               end
            end
         end
         local Tween1 = TweenService:Create(Window, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = WindowSize})
         local Tween2 = TweenService:Create(ServersButton, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0, -25, 0.5, -21), BackgroundTransparency = 0.15, TextTransparency = 0})
         Tween1:Play()
         Tween2:Play()
         Tween1.Completed:Once(function()
            Tween1:Destroy()
         end)
         Tween2.Completed:Once(function()
            Tween2:Destroy()
         end)
         Sections.Visible = true
         SectionsLine.Visible = true
         Line.Visible = true
         if CurrentServer then
            for _, v in ipairs(CurrentServer.Sections) do
               v.Content.Visible = v.Selected
            end
         end
         for _, v in ipairs(Servers) do
            v.Button.Visible = ServersOpen
            v.Button.BackgroundTransparency = 0.15
            v.Button.Active = true
            v.Button.Interactable = true
            for _, k in ipairs(v.Button:GetChildren()) do
               if k:IsA("ImageLabel") then
                  k.ImageTransparency = 0
              elseif k:IsA("TextLabel") then
                  k.TextTransparency = 0
               end
            end
         end
      end
   end)
   
   CloseButton.Activated:Connect(function()
      ScreenGui:Destroy()
   end)
   
   local Dragging, DragStart, StartPosition, DragInput = false
   Title.InputBegan:Connect(function(Input)
      if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
         Dragging = true
         DragInput = Input
         DragStart = Input.Position
         StartPosition = Window.Position
      end
   end)

   UserInputService.InputChanged:Connect(function(Input)
      if Dragging and Input == DragInput then
         local Delta = Input.Position - DragStart
         Window.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
      end
   end)

  UserInputService.InputEnded:Connect(function(Input)
      if Input == DragInput then
         Dragging = false
         DragInput = nil
      end
   end)
   
   function WindowAPI:Notification(titletext: string, desctext: string, btntext: string): table
      local NotificationHolder = Instance.new("TextButton", Window)
      local Notification = Instance.new("Frame", NotificationHolder)
      local NotificationCorner = Instance.new("UICorner", Notification)
      local NotificationHolderCorner = Instance.new("UICorner", NotificationHolder)
      local NotificationStroke = Instance.new("UIStroke", Notification)
      local NotificationTitle = Instance.new("TextLabel", Notification)
      local NotificationDescription = Instance.new("TextLabel", Notification)
      local NotificationButton = Instance.new("TextButton", Notification)
      local NotificationButtonCorner = Instance.new("UICorner", NotificationButton)
      local NotificationButtonStroke = Instance.new("UIStroke", NotificationButton)
      local NotificationAPI = {}
      local Closed = false
      
      table.insert(Notifications, NotificationHolder)
      NotificationHolder.Name = RandomName()
      NotificationHolder.Size = UDim2.fromScale(1, 1)
      NotificationHolder.Position = UDim2.fromOffset(0, 0)
      NotificationHolder.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
      NotificationHolder.BackgroundTransparency = 1
      NotificationHolder.BorderSizePixel = 0
      NotificationHolder.Text = ""
      NotificationHolder.AutoButtonColor = false
      NotificationHolder.Active = false
      NotificationHolder.Selectable = false
      NotificationHolder.ZIndex = 50
      NotificationHolder.ClipsDescendants = true
      NotificationHolder.Visible = not Minimized
      NotificationHolderCorner.CornerRadius = UDim.new(0, 16)
      Notification.Size = UDim2.fromOffset(340, 180)
      Notification.Position = UDim2.new(0.5, 0, 0.5, 18)
      Notification.AnchorPoint = Vector2.new(0.5, 0.5)
      Notification.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
      Notification.BackgroundTransparency = 1
      Notification.BorderSizePixel = 0
      Notification.ZIndex = 51
      NotificationCorner.CornerRadius = UDim.new(0, 16)
      NotificationStroke.Color = Color3.fromRGB(255, 255, 255)
      NotificationStroke.Transparency = 1
      NotificationStroke.Thickness = 1
      NotificationTitle.BackgroundTransparency = 1
      NotificationTitle.Position = UDim2.fromOffset(18, 14)
      NotificationTitle.Size = UDim2.new(1, -36, 0, 27)
      NotificationTitle.BorderSizePixel = 0
      NotificationTitle.Font = Enum.Font.GothamSemibold
      NotificationTitle.Text = type(titletext) == "string" and titletext or "Notification"
      NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
      NotificationTitle.TextTransparency = 1
      NotificationTitle.TextSize = 18
      NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
      NotificationTitle.TextYAlignment = Enum.TextYAlignment.Center
      NotificationTitle.ZIndex = 52
      NotificationDescription.BackgroundTransparency = 1
      NotificationDescription.Position = UDim2.fromOffset(18, 47)
      NotificationDescription.Size = UDim2.new(1, -36, 0, 55)
      NotificationDescription.BorderSizePixel = 0
      NotificationDescription.Font = Enum.Font.Gotham
      NotificationDescription.Text = type(desctext) == "string" and desctext or ""
      NotificationDescription.TextColor3 = Color3.fromRGB(165, 167, 171)
      NotificationDescription.TextTransparency = 1
      NotificationDescription.TextSize = 13
      NotificationDescription.TextWrapped = true
      NotificationDescription.TextXAlignment = Enum.TextXAlignment.Left
      NotificationDescription.TextYAlignment = Enum.TextYAlignment.Top
      NotificationDescription.ZIndex = 52
      NotificationButton.Position = UDim2.new(0, 18, 1, -48)
      NotificationButton.Size = UDim2.new(1, -36, 0, 30)
      NotificationButton.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
      NotificationButton.BackgroundTransparency = 1
      NotificationButton.BorderSizePixel = 0
      NotificationButton.AutoButtonColor = false
      NotificationButton.Font = Enum.Font.GothamMedium
      NotificationButton.Text = type(btntext) == "string" and btntext or "Okay"
      NotificationButton.TextColor3 = Color3.fromRGB(255, 255, 255)
      NotificationButton.TextTransparency = 1
      NotificationButton.TextSize = 13
      NotificationButton.ZIndex = 53
      NotificationButtonCorner.CornerRadius = UDim.new(0, 7)
      NotificationButtonStroke.Color = Color3.fromRGB(255, 255, 255)
      NotificationButtonStroke.Transparency = 1
      NotificationButtonStroke.Thickness = 1
      
      local Tween = TweenService:Create(NotificationHolder, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.35})
      local Tween1 = TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.5, 0.5), BackgroundTransparency = 0.05})
      local Tween2 = TweenService:Create(NotificationStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.85})
      local Tween3 = TweenService:Create(NotificationTitle, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0})
      local Tween4 = TweenService:Create(NotificationDescription, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0})
      local Tween5 = TweenService:Create(NotificationButton, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15, TextTransparency = 0})
      local Tween6 = TweenService:Create(NotificationButtonStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.92})
      Tween:Play()
      Tween1:Play()
      Tween2:Play()
      Tween3:Play()
      Tween4:Play()
      Tween5:Play()
      Tween6:Play()
      Tween.Completed:Once(function()
         Tween:Destroy() 
      end)
      Tween1.Completed:Once(function()
         Tween1:Destroy()
      end)
      Tween2.Completed:Once(function()
         Tween2:Destroy()
      end)
      Tween3.Completed:Once(function()
         Tween3:Destroy()
      end)
      Tween4.Completed:Once(function()
         Tween4:Destroy()
      end)
      Tween5.Completed:Once(function()
         Tween5:Destroy()
      end)
      Tween6.Completed:Once(function()
         Tween6:Destroy()
      end)

      NotificationButton.MouseEnter:Connect(function()
         local Tween = TweenService:Create(NotificationButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(30, 33, 40)})
         local Tween1 = TweenService:Create(NotificationButtonStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.78})
         Tween:Play()
         Tween1:Play()
         Tween.Completed:Once(function()
            Tween:Destroy()
         end)
         Tween1.Completed:Once(function()
            Tween1:Destroy()
         end)
      end)

      NotificationButton.MouseLeave:Connect(function()
         local Tween = TweenService:Create(NotificationButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(20, 22, 27)})
         local Tween1 = TweenService:Create(NotificationButtonStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.92})
         Tween:Play()
         Tween1:Play()
         Tween.Completed:Once(function()
            Tween:Destroy()
         end)
         Tween1.Completed:Once(function()
            Tween1:Destroy()
         end)
      end)

      local function Close()
         if Closed then
            return
         end
         Closed = true
         local Tween = TweenService:Create(NotificationHolder, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {BackgroundTransparency = 1})
         local Tween1 = TweenService:Create(Notification, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 0.5, 18), BackgroundTransparency = 1})
         local Tween2 = TweenService:Create(NotificationStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Transparency = 1})
         local Tween3 = TweenService:Create(NotificationTitle, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {TextTransparency = 1})
         local Tween4 = TweenService:Create(NotificationDescription, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {TextTransparency = 1})
         local Tween5 = TweenService:Create(NotificationButton, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {BackgroundTransparency = 1, TextTransparency = 1})
         local Tween6 = TweenService:Create(NotificationButtonStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Transparency = 1})
         Tween:Play()
         Tween1:Play()
         Tween2:Play()
         Tween3:Play()
         Tween4:Play()
         Tween5:Play()
         Tween6:Play()
         Tween.Completed:Once(function()
            Tween:Destroy() 
         end)
         Tween1.Completed:Once(function()
            Tween1:Destroy()
         end)
         Tween2.Completed:Once(function()
            Tween2:Destroy()
         end)
         Tween3.Completed:Once(function()
            Tween3:Destroy()
         end)
         Tween4.Completed:Once(function()
            Tween4:Destroy()
         end)
         Tween5.Completed:Once(function()
            Tween5:Destroy()
         end)
         Tween6.Completed:Once(function()
            Tween5:Destroy()
         end)
         task.delay(0.25, function()
            NotificationHolder:Destroy()
         end)
      end
      NotificationButton.Activated:Connect(function()
         Close()
      end)
      function NotificationAPI:Close()
         Close()
      end
      function NotificationAPI:SetTitle(Text: string)
         NotificationTitle.Text = type(Text) == "string" and Text or "Notification"
      end
      function NotificationAPI:SetDescription(Text: string)
         NotificationDescription.Text = type(Text) == "string" and Text or ""
      end
      function NotificationAPI:SetButton(Text: string)
         NotificationButton.Text = type(Text) == "string" and Text or "Okay"
      end
      NotificationAPI.Notification = Notification
      NotificationAPI.Button = NotificationButton
      return NotificationAPI
   end

   function WindowAPI:Server(Name: string, Image: string): table
      local ServerButton = Instance.new("TextButton", ServersPanel)
      local ServerImage = Instance.new("ImageLabel", ServerButton)
      local ServerLetter = Instance.new("TextLabel", ServerButton)
      local ServerCorner = Instance.new("UICorner", ServerButton)
      local ServerStroke = Instance.new("UIStroke", ServerButton)
      local ServerName = type(Name) == "string" and Name or "Server"
      local ServerImageId = type(Image) == "string" and Image or ""
      local ServerAPI = {}
      ServerAPI.Sections = {}
      ServerButton.ZIndex = 2
      ServerAPI.Button = ServerButton
      ServerAPI.Selected = false
      ServerAPI.Name = ServerName
      ServerAPI.Image = ServerImageId
      ServerAPI.CurrentSection = nil
      ServerButton.MouseEnter:Connect(function()
         local Tween1 = TweenService:Create(ServerButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = ServerAPI.Selected and Color3.fromRGB(35, 37, 44) or Color3.fromRGB(22, 24, 29)})
         local Tween2 = TweenService:Create(ServerStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = ServerAPI.Selected and 0.72 or 0.78})
         Tween1:Play()
         Tween2:Play()
         Tween1.Completed:Once(function()
            Tween1:Destroy()
         end)
         Tween2.Completed:Once(function()
            Tween2:Destroy()
          end)
       end)

      ServerButton.MouseLeave:Connect(function()
         local Tween1 = TweenService:Create(ServerButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = ServerAPI.Selected and Color3.fromRGB(28, 30, 36) or Color3.fromRGB(5, 5, 5)})
         local Tween2 = TweenService:Create(ServerStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = ServerAPI.Selected and 0.85 or 0.93})
         Tween1:Play()
         Tween2:Play()
         Tween1.Completed:Once(function()
            Tween1:Destroy()
         end)
         Tween2.Completed:Once(function()
            Tween2:Destroy()
         end)
      end)

      function ServerAPI:Section(Name: string): table
         local SectionButton = Instance.new("TextButton", Sections)
         local SectionCorner = Instance.new("UICorner", SectionButton)
         local SectionStroke = Instance.new("UIStroke", SectionButton)
         local SectionAPI = {}
         table.insert(ServerAPI.Sections, SectionAPI)
         

         SectionAPI.Selected = false
         SectionAPI.ButtonObject = SectionButton
         SectionAPI.Content = Instance.new("ScrollingFrame", Window)
         SectionAPI.ElementPadding = 0
         SectionAPI.ElementPositions = {}
         local OpenDropdownClose = nil
         
         SectionButton.Size = UDim2.new(1, 0, 0, 35)
         SectionButton.BackgroundColor3 = Color3.fromRGB(14, 15, 18)
         SectionButton.BackgroundTransparency = 0.35
         SectionButton.BorderSizePixel = 0
         SectionButton.Text = type(Name) == "string" and Name or "Section"
         SectionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
         SectionButton.TextSize = 14
         SectionButton.Font = Enum.Font.GothamMedium
         SectionButton.AutoButtonColor = false
         SectionButton.LayoutOrder = #self.Sections + 1
         SectionStroke.Transparency = 0.93
         
         SectionButton.MouseEnter:Connect(function()
            local Tween1 = TweenService:Create(SectionButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = SectionAPI.Selected and Color3.fromRGB(35, 37, 44) or Color3.fromRGB(22, 24, 29)})
            local Tween2 = TweenService:Create(SectionStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = SectionAPI.Selected and 0.72 or 0.78})
            Tween1:Play()
            Tween2:Play()
            Tween1.Completed:Once(function()
               Tween1:Destroy()
            end)
            Tween2.Completed:Once(function()
               Tween2:Destroy()
            end)
         end)

        SectionButton.MouseLeave:Connect(function()
           local Tween1 = TweenService:Create(SectionButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = SectionAPI.Selected and Color3.fromRGB(28, 30, 36) or Color3.fromRGB(14, 15, 18)})
           local Tween2 = TweenService:Create(SectionStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = SectionAPI.Selected and 0.85 or 0.93})
           Tween1:Play()
           Tween2:Play()
           Tween1.Completed:Once(function()
              Tween1:Destroy()
           end)
           Tween2.Completed:Once(function()
              Tween2:Destroy()
           end)
        end)
        
        function SectionAPI:Select()
           if ServerAPI.CurrentSection == SectionAPI then
              SectionAPI.Selected = true
              SectionAPI.Content.Visible = CurrentServer == ServerAPI and not Minimized
              return
           end
           ServerAPI.CurrentSection = SectionAPI
           for _, v in ipairs(ServerAPI.Sections) do
              v.Content.Visible = false
              v.Selected = false
              local Tween1 = TweenService:Create(v.ButtonObject, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(14, 15, 18)})
              local Tween2 = TweenService:Create(v.ButtonObject:FindFirstChildOfClass("UIStroke"), TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.93})
              Tween1:Play()
              Tween2:Play()
              Tween1.Completed:Once(function()
                 Tween1:Destroy()
              end)
              Tween2.Completed:Once(function()
                 Tween2:Destroy()
              end)
           end
           SectionAPI.Selected = true
           SectionAPI.Content.Visible = true
           local Tween1 = TweenService:Create(SectionButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(35, 37, 44)})
           local Tween2 = TweenService:Create(SectionStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.85})
           Tween1:Play()
           Tween2:Play()
           Tween1.Completed:Once(function()
              Tween1:Destroy()
           end)
           Tween2.Completed:Once(function()
              Tween2:Destroy()
           end)
        end
        SectionButton.Activated:Connect(function()
           SectionAPI:Select()
        end)
         
         SectionCorner.CornerRadius = UDim.new(0, 8)
         SectionAPI.Content.Size = UDim2.new(1, -170, 1, -70)
         SectionAPI.Content.Position = UDim2.fromOffset(165, 66)
         SectionAPI.Content.BackgroundTransparency = 1
         SectionAPI.Content.BorderSizePixel = 0
         SectionAPI.Content.Visible = false
         SectionAPI.Content.CanvasSize = UDim2.fromOffset(0, 0)
         SectionAPI.Content.AutomaticCanvasSize = Enum.AutomaticSize.None
         SectionAPI.Content.ScrollBarThickness = 0
         SectionAPI.Content.ScrollingDirection = Enum.ScrollingDirection.Y
         
         SectionAPI.Content:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            SectionAPI.Content.CanvasSize = UDim2.fromOffset(0, SectionAPI.ElementPadding + 10)
         end)
         
         function SectionAPI:Button(Name: string, Callback: () -> ()): table
            local Button = Instance.new("TextButton", SectionAPI.Content)
            local ButtonCorner = Instance.new("UICorner", Button)
            local ButtonStroke = Instance.new("UIStroke", Button)
            local ButtonAPI = {}
            local ButtonPadding = Instance.new("UIPadding", Button)
            local ButtonIcon = Instance.new("ImageLabel", Button)
            Button.Size = UDim2.new(1, -10, 0, 35)
            Button.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
            Button.BackgroundTransparency = 0.35
            Button.BorderSizePixel = 0
            Button.Text = type(Name) == "string" and Name or "Button"
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 14
            Button.Font = Enum.Font.GothamMedium
            ButtonPadding.PaddingLeft = UDim.new(0, 10)
            Button.AutoButtonColor = false
            Button.Visible = true
            Button.ZIndex = 5
            Button.AnchorPoint = Vector2.new(0.5, 0)
            Button.Position = UDim2.new(0.5, -5, 0, SectionAPI.ElementPadding)
            SectionAPI.ElementPositions[Button] = Button.Position
            Button.TextXAlignment = Enum.TextXAlignment.Left
            Button.TextYAlignment = Enum.TextYAlignment.Center
            ButtonIcon.Size = UDim2.fromOffset(25, 25)
            ButtonIcon.Position = UDim2.new(1, -42, 0.5, -12)
            ButtonIcon.BackgroundTransparency = 1
            ButtonIcon.Image = "rbxthumb://type=Asset&w=420&h=420&id=9468220174"
            ButtonIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            ButtonIcon.ImageTransparency = 0
            ButtonIcon.ZIndex = 6
            SectionAPI.ElementPadding += 41
            ButtonCorner.CornerRadius = UDim.new(0, 8)
            ButtonStroke.Transparency = 0.93
            ButtonAPI.Button = Button
            
            Button.MouseEnter:Connect(function()
               local Tween1 = TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(30, 33, 40)})
               local Tween2 = TweenService:Create(ButtonStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.78})
               Tween1:Play()
               Tween2:Play()
               Tween1.Completed:Once(function()
                  Tween1:Destroy()
               end)
               Tween2.Completed:Once(function()
                  Tween2:Destroy()
               end)
            end)

           Button.MouseLeave:Connect(function()
              local Tween1 = TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(20, 22, 27)})
              local Tween2 = TweenService:Create(ButtonStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.93})
              Tween1:Play()
              Tween2:Play()
              Tween1.Completed:Once(function()
                 Tween1:Destroy()
               end)
               Tween2.Completed:Once(function()
                  Tween2:Destroy()
               end)
            end)
            
            Button.Activated:Connect(function()
               if type(Callback) == "function" then
                  Callback()
               else
                  error("Wevorn Library Error: Argument #2 In Method Section:Button Must Be A Function, Current Arguments Section:Button(Button Name: string, Callback: function)")
               end
            end)
            function ButtonAPI:SetText(Text: string)
               Button.Text = type(Text) == "string" and Text or "Button"
            end
            function ButtonAPI:SetCallback(NewCallback: () -> ())
               if type(NewCallback) == "function" then
                  Callback = NewCallback
               else
                  error("Wevorn Library Error: Argument #1 In Method Button:SetCallback Must Be A Function, Current Arguments Button:SetCallback(Callback: function)")
               end
            end
            return ButtonAPI
         end
         
         function SectionAPI:Toggle(Name: string, Default: boolean, Callback: (boolean) -> ()): table
            local Toggle = Instance.new("TextButton", SectionAPI.Content)
            local ToggleCorner = Instance.new("UICorner", Toggle)
            local ToggleStroke = Instance.new("UIStroke", Toggle)
            local ToggleTitle = Instance.new("TextLabel", Toggle)
            local ToggleFrame = Instance.new("Frame", Toggle)
            local ToggleFrameCorner = Instance.new("UICorner", ToggleFrame)
            local ToggleCircle = Instance.new("Frame", ToggleFrame)
            local ToggleCircleCorner = Instance.new("UICorner", ToggleCircle)
            local ToggleIcon = Instance.new("ImageLabel", ToggleCircle)
            local ToggleAPI = {}
            local Toggled = type(Default) == "boolean" and Default or false

            Toggle.Size = UDim2.new(1, -10, 0, 35)
            Toggle.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
            Toggle.BackgroundTransparency = 0.35
            Toggle.BorderSizePixel = 0
            Toggle.Text = ""
            Toggle.AutoButtonColor = false
            Toggle.Visible = true
            Toggle.ZIndex = 5
            Toggle.AnchorPoint = Vector2.new(0.5, 0)
            Toggle.Position = UDim2.new(0.5, -5, 0, SectionAPI.ElementPadding)
            SectionAPI.ElementPositions[Toggle] = Toggle.Position
            SectionAPI.ElementPadding += 41
            ToggleCorner.CornerRadius = UDim.new(0, 8)
            ToggleStroke.Transparency = 0.93
            ToggleTitle.BackgroundTransparency = 1
            ToggleTitle.Position = UDim2.fromOffset(10, 0)
            ToggleTitle.Size = UDim2.new(1, -70, 1, 0)
            ToggleTitle.Text = type(Name) == "string" and Name or "Toggle"
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 14
            ToggleTitle.Font = Enum.Font.GothamMedium
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
            ToggleTitle.ZIndex = 6
            ToggleFrame.Size = UDim2.fromOffset(40, 21)
            ToggleFrame.Position = UDim2.new(1, -50, 0.5, -10)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(70, 73, 80)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.ZIndex = 6
            ToggleFrameCorner.CornerRadius = UDim.new(1, 0)
            ToggleCircle.Size = UDim2.fromOffset(15, 15)
            ToggleCircle.Position = UDim2.fromOffset(3, 3)
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleCircle.BorderSizePixel = 0
            ToggleCircle.ZIndex = 7
            ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
            ToggleIcon.Size = UDim2.fromOffset(13, 13)
            ToggleIcon.Position = UDim2.fromOffset(1, 1)
            ToggleIcon.BackgroundTransparency = 1
            ToggleIcon.Image = "rbxassetid://6035047409"
            ToggleIcon.ImageColor3 = Color3.fromRGB(70, 73, 80)
            ToggleIcon.ZIndex = 8

            local function UpdateToggle(Instant: boolean)
               local FrameColor = Toggled and Color3.fromRGB(67, 181, 129) or Color3.fromRGB(70, 73, 80)
               local CirclePosition = Toggled and UDim2.new(1, -18, 0, 3) or UDim2.fromOffset(3, 3)
               if Instant then
                  ToggleFrame.BackgroundColor3 = FrameColor
                  ToggleCircle.Position = CirclePosition
                  ToggleIcon.ImageColor3 = FrameColor
               else
                  local Tween1 = TweenService:Create(ToggleFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = FrameColor})
                  local Tween2 = TweenService:Create(ToggleCircle, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = CirclePosition})
                  local Tween3 = TweenService:Create(ToggleIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageColor3 = FrameColor})
                  Tween1:Play()
                  Tween2:Play()
                  Tween3:Play()
                  Tween1.Completed:Once(function()
                     Tween1:Destroy()
                  end)
                  Tween2.Completed:Once(function()
                     Tween2:Destroy()
                  end)
                  Tween3.Completed:Once(function()
                     Tween3:Destroy()
                  end)
               end
            end
            Toggle.MouseEnter:Connect(function()
               local Tween1 = TweenService:Create(Toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(30, 33, 40)})
               local Tween2 = TweenService:Create(ToggleStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.78})
               Tween1:Play()
               Tween2:Play()
               Tween1.Completed:Once(function()
                  Tween1:Destroy()
               end)
               Tween2.Completed:Once(function()
                  Tween2:Destroy()
               end)
            end)
            Toggle.MouseLeave:Connect(function()
               local Tween1 = TweenService:Create(Toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(20, 22, 27)})
               local Tween2 = TweenService:Create(ToggleStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.93})
               Tween1:Play()
               Tween2:Play()
               Tween1.Completed:Once(function()
                  Tween1:Destroy()
               end)
               Tween2.Completed:Once(function()
                  Tween2:Destroy()
               end)
            end)
            Toggle.Activated:Connect(function()
               Toggled = not Toggled
               UpdateToggle(false)
               if type(Callback) == "function" then
                  Callback(Toggled)
               else
                  error("Wevorn Library Error: Argument #3 In Method Section:Toggle Must Be A Function, Current Arguments Section:Toggle(Name: string, Default Value: Boolean, Callback: function)")
               end
            end)
            function ToggleAPI:SetValue(Value: boolean)
               if type(Value) ~= "boolean" then
                  return
               end
               Toggled = Value
               UpdateToggle(false)
               if type(Callback) == "function" then
                  Callback(Toggled)
               else
                  error("Wevorn Library Error: Argument #1 In Method Toggle:SetValue Must Be A Boolean, Current Arguments Toggle:SetValue(NewValue: Boolean)")
               end
            end
            function ToggleAPI:GetValue(): boolean
               return Toggled
            end
            function ToggleAPI:SetText(Text: string)
               ToggleTitle.Text = type(Text) == "string" and Text or "Toggle"
            end
            ToggleAPI.Toggle = Toggle
            UpdateToggle(true)
            return ToggleAPI
         end
         function SectionAPI:Textbox(text: string, placetext: string, disapper: boolean, callback: (string) -> ()): table
            local Textbox = Instance.new("Frame", SectionAPI.Content)
            local TextboxTitle = Instance.new("TextLabel", Textbox)
            local TextboxFrameOutline = Instance.new("Frame", Textbox)
            local TextboxFrameOutlineCorner = Instance.new("UICorner", TextboxFrameOutline)
            local TextboxFrame = Instance.new("Frame", TextboxFrameOutline)
            local TextboxFrameCorner = Instance.new("UICorner", TextboxFrame)
            local TextBox = Instance.new("TextBox", TextboxFrame)
            local TextboxAPI = {}
            
            Textbox.Name = RandomName()
            Textbox.Size = UDim2.new(1, -10, 0, 66)
            Textbox.BackgroundTransparency = 1
            Textbox.BorderSizePixel = 0
            Textbox.Visible = true
            Textbox.ZIndex = 5
            Textbox.AnchorPoint = Vector2.new(0.5, 0)
            Textbox.Position = UDim2.new(0.5, -5, 0, SectionAPI.ElementPadding)
            SectionAPI.ElementPositions[Textbox] = Textbox.Position
            
            TextboxTitle.Size = UDim2.new(1, 0, 0, 20)
            TextboxTitle.Position = UDim2.fromOffset(0, 0)
            TextboxTitle.BackgroundTransparency = 1
            TextboxTitle.BorderSizePixel = 0
            TextboxTitle.Font = Enum.Font.GothamMedium
            TextboxTitle.Text = type(text) == "string" and text or "Textbox"
            TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.TextSize = 14
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left
            TextboxTitle.TextYAlignment = Enum.TextYAlignment.Center
            TextboxTitle.ZIndex = 6

            TextboxFrameOutline.Size = UDim2.new(1, 0, 0, 35)
            TextboxFrameOutline.Position = UDim2.fromOffset(0, 25)
            TextboxFrameOutline.BackgroundColor3 = Color3.fromRGB(37, 40, 43)
            TextboxFrameOutline.BorderSizePixel = 0
            TextboxFrameOutline.ZIndex = 5
            TextboxFrameOutlineCorner.CornerRadius = UDim.new(0, 8)

            TextboxFrame.Size = UDim2.new(1, -2, 1, -2)
            TextboxFrame.Position = UDim2.fromOffset(1, 1)
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
            TextboxFrame.BackgroundTransparency = 0.35
            TextboxFrame.BorderSizePixel = 0
            TextboxFrame.ClipsDescendants = true
            TextboxFrame.ZIndex = 6
            TextboxFrameCorner.CornerRadius = UDim.new(0, 7)

            TextBox.Size = UDim2.new(1, -20, 1, 0)
            TextBox.Position = UDim2.fromOffset(10, 0)
            TextBox.BackgroundTransparency = 1
            TextBox.BorderSizePixel = 0
            TextBox.ClearTextOnFocus = false
            TextBox.Text = ""
            TextBox.PlaceholderColor3 = Color3.fromRGB(91, 95, 101)
            TextBox.PlaceholderText = type(placetext) == "string" and placetext or "Enter text..."
            TextBox.TextColor3 = Color3.fromRGB(193, 195, 197)
            TextBox.TextSize = 14
            TextBox.Font = Enum.Font.Gotham
            TextBox.TextXAlignment = Enum.TextXAlignment.Left
            TextBox.TextYAlignment = Enum.TextYAlignment.Center
            TextBox.ZIndex = 7
            SectionAPI.ElementPadding += 72

            TextBox.Focused:Connect(function()
                local Tween1 = TweenService:Create(TextboxFrameOutline, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(114, 137, 228)})
                local Tween2 = TweenService:Create(TextboxFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(25, 28, 34)})
                Tween1:Play()
                Tween2:Play()
                Tween1.Completed:Once(function()
                   Tween1:Destroy()
                end)
               Tween2.Completed:Once(function()
                  Tween2:Destroy()
               end)
            end)
           
            TextBox.FocusLost:Connect(function(ep)
                local Tween1 = TweenService:Create(TextboxFrameOutline, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(37, 40, 43)})
                local Tween2 = TweenService:Create(TextboxFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(20, 22, 27)})
                Tween1:Play()
                Tween2:Play()
                Tween1.Completed:Once(function()
                   Tween1:Destroy()
                end)
                Tween2.Completed:Once(function()
                   Tween2:Destroy()
                end)
                if ep then
                   if #TextBox.Text > 0 then
                      if type(callback) == "function" then
                         callback(TextBox.Text)
                      else
                          error("Wevorn Library Error: Argument #4 In Method Section:Textbox Must Be A Function, Current Arguments Section:Textbox(Textbox Name: string, PlaceHolder: string, Disapper: boolean, Callback: function)")
                      end
                      if disapper then
                         TextBox.Text = ""
                      end
                   end
                end
            end)
           function TextboxAPI:SetText(Text: string)
               TextBox.Text = type(Text) == "string" and Text or ""
            end
            function TextboxAPI:GetText(): string
                return TextBox.Text
            end
            function TextboxAPI:SetPlaceHolder(Text: string)
               TextBox.PlaceholderText = type(Text) == "string" and Text or ""
            end
            function TextboxAPI:SetCallback(NewCallback: (string) -> ())
               if type(NewCallback) == "function" then
                  callback = NewCallback
               else
                  error("Wevorn Library Error: Argument #1 In Method Textbox:SetCallback Must Be A Function, Current Arguments Textbox:SetCallback(Callback: function)")
               end
            end
            TextboxAPI.Textbox = TextBox
            return TextboxAPI
         end
         
         function SectionAPI:Label(text: string): table
            local Label = Instance.new("TextButton", SectionAPI.Content)
            local LabelCorner = Instance.new("UICorner", Label)
            local LabelStroke = Instance.new("UIStroke", Label)
            local LabelTitle = Instance.new("TextLabel", Label)
            local LabelAPI = {}
            Label.Size = UDim2.new(1, -10, 0, 35)
            Label.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
            Label.BackgroundTransparency = 0.35
            Label.BorderSizePixel = 0
            Label.Text = ""
            Label.AutoButtonColor = false
            Label.Visible = true
            Label.ZIndex = 5
            Label.AnchorPoint = Vector2.new(0.5, 0)
            Label.Position = UDim2.new(0.5, -5, 0, SectionAPI.ElementPadding)
            SectionAPI.ElementPositions[Label] = Label.Position
            LabelCorner.CornerRadius = UDim.new(0, 8)
            LabelStroke.Transparency = 0.93
            LabelTitle.Size = UDim2.new(1, -10, 1, 0)
            LabelTitle.Position = UDim2.fromOffset(5, 0)
            LabelTitle.BackgroundTransparency = 1
            LabelTitle.BorderSizePixel = 0
            LabelTitle.Font = Enum.Font.Gotham
            LabelTitle.Text = type(text) == "string" and text or "Label"
            LabelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.TextSize = 14
            LabelTitle.TextXAlignment = Enum.TextXAlignment.Left
            LabelTitle.TextYAlignment = Enum.TextYAlignment.Center
            LabelTitle.ZIndex = 6
            SectionAPI.ElementPadding += 41
            function LabelAPI:Change(NewText: string)
               LabelTitle.Text = type(NewText) == "string" and NewText or "Label"
            end
            function LabelAPI:GetText(): string
               return LabelTitle.Text
            end
            LabelAPI.Label = Label
            LabelAPI.LabelTitle = LabelTitle
            return LabelAPI
         end
         
         function SectionAPI:Seperator(): table
            local Seperator = Instance.new("Frame", SectionAPI.Content)
            local SeperatorLine = Instance.new("Frame", Seperator)
            local SeperatorAPI = {}
            Seperator.Size = UDim2.new(1, -10, 0, 8)
            Seperator.BackgroundTransparency = 1
            Seperator.BorderSizePixel = 0
            Seperator.Visible = true
            Seperator.ZIndex = 5
            Seperator.AnchorPoint = Vector2.new(0.5, 0)
            Seperator.Position = UDim2.new(0.5, -5, 0, SectionAPI.ElementPadding)
            SectionAPI.ElementPositions[Seperator] = Seperator.Position
            SeperatorLine.Size = UDim2.new(1, 0, 0, 1)
            SeperatorLine.Position = UDim2.new(0, 0, 0.5, 0)
            SeperatorLine.BackgroundColor3 = Color3.fromRGB(66, 69, 74)
            SeperatorLine.BackgroundTransparency = 0
            SeperatorLine.BorderSizePixel = 0
            SeperatorLine.ZIndex = 6
            SectionAPI.ElementPadding += 14
            SeperatorAPI.Seperator = Seperator
            SeperatorAPI.Line = SeperatorLine
            return SeperatorAPI
         end
         
         function SectionAPI:Slider(text: string, min: number, max: number, start: number, callback: (number) -> ()): table
            local Slider = Instance.new("TextButton", SectionAPI.Content)
            local SliderCorner = Instance.new("UICorner", Slider)
            local SliderStroke = Instance.new("UIStroke", Slider)
            local SliderTitle = Instance.new("TextLabel", Slider)
            local SliderFrame = Instance.new("Frame", Slider)
            local SliderFrameCorner = Instance.new("UICorner", SliderFrame)
            local CurrentValueFrame = Instance.new("Frame", SliderFrame)
            local CurrentValueFrameCorner = Instance.new("UICorner", CurrentValueFrame)
            local Zip = Instance.new("Frame", SliderFrame)
            local ZipCorner = Instance.new("UICorner", Zip)
            local ZipHitbox = Instance.new("Frame", Zip)
            local ValueBubble = Instance.new("Frame", Zip)
            local ValueBubbleCorner = Instance.new("UICorner", ValueBubble)
            local SquareBubble = Instance.new("Frame", ValueBubble)
            local GlowBubble = Instance.new("ImageLabel", ValueBubble)
            local ValueLabel = Instance.new("TextLabel", ValueBubble)
            local SliderAPI = {}
            local Dragging = false
            local Minimum = type(min) == "number" and min or 0
            local Maximum = type(max) == "number" and max > Minimum and max or Minimum + 100
            local CurrentValue = type(start) == "number" and math.clamp(start, Minimum, Maximum) or Minimum

            local function GetScale(Value: number): number
               return math.clamp((Value - Minimum) / (Maximum - Minimum), 0, 1)
            end
            
            local function SetValue(Value: number, CallCallback: boolean)
               CurrentValue = math.clamp(Value, Minimum, Maximum)
               local Scale = GetScale(CurrentValue)
               CurrentValueFrame.Size = UDim2.new(Scale, 0, 0, 6)
               Zip.Position = UDim2.new(Scale, -6, 0.5, -9)
               ValueLabel.Text = tostring(math.floor(CurrentValue))
               if CallCallback and type(callback) == "function" then
                  callback(CurrentValue)
               end
            end
            Slider.Size = UDim2.new(1, -10, 0, 42)
            Slider.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
            Slider.BackgroundTransparency = 0.35
            Slider.BorderSizePixel = 0
            Slider.Text = ""
            Slider.AutoButtonColor = false
            Slider.Visible = true
            Slider.ZIndex = 5
            Slider.AnchorPoint = Vector2.new(0.5, 0)
            Slider.Position = UDim2.new(0.5, -5, 0, SectionAPI.ElementPadding)
            SectionAPI.ElementPositions[Slider] = Slider.Position
            SliderCorner.CornerRadius = UDim.new(0, 8)
            SliderStroke.Transparency = 0.93
            SliderTitle.Size = UDim2.new(1, -10, 0, 20)
            SliderTitle.Position = UDim2.fromOffset(5, 0)
            SliderTitle.BackgroundTransparency = 1
            SliderTitle.BorderSizePixel = 0
            SliderTitle.Font = Enum.Font.Gotham
            SliderTitle.Text = type(text) == "string" and text or "Slider"
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 14
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
            SliderTitle.TextYAlignment = Enum.TextYAlignment.Center
            SliderTitle.ZIndex = 6
            SliderFrame.Size = UDim2.new(1, -20, 0, 5)
            SliderFrame.Position = UDim2.new(0.5, 0, 0, 27)
            SliderFrame.AnchorPoint = Vector2.new(0.5, 0)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(79, 84, 92)
            SliderFrame.BorderSizePixel = 0
            SliderFrame.ZIndex = 6
            SliderFrameCorner.CornerRadius = UDim.new(1, 0)
            CurrentValueFrame.Size = UDim2.new(0, 0, 0, 10)
            CurrentValueFrame.BackgroundColor3 = Color3.fromRGB(114, 137, 218)
            CurrentValueFrame.BorderSizePixel = 0
            CurrentValueFrame.ZIndex = 7
            CurrentValueFrameCorner.CornerRadius = UDim.new(1, 0)
            Zip.Size = UDim2.fromOffset(10, 18)
            Zip.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Zip.BorderSizePixel = 0
            Zip.ZIndex = 8
            ZipCorner.CornerRadius = UDim.new(0, 3)
            ZipHitbox.Size = UDim2.fromOffset(40, 40)
            ZipHitbox.Position = UDim2.new(0.5, -20, 0.5, -20)
            ZipHitbox.BackgroundTransparency = 1
            ZipHitbox.BorderSizePixel = 0
            ZipHitbox.ZIndex = 9
            ValueBubble.Size = UDim2.fromOffset(36, 21)
            ValueBubble.Position = UDim2.new(0.5, 0, -1.008, 0)
            ValueBubble.AnchorPoint = Vector2.new(0.5, 0.5)
            ValueBubble.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            ValueBubble.BorderSizePixel = 0
            ValueBubble.Visible = false
            ValueBubble.ZIndex = 10
            ValueBubbleCorner.CornerRadius = UDim.new(0, 3)
            SquareBubble.Size = UDim2.fromOffset(19, 19)
            SquareBubble.Position = UDim2.new(0.493, 0, 0.638, 0)
            SquareBubble.AnchorPoint = Vector2.new(0.5, 0.5)
            SquareBubble.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            SquareBubble.BorderSizePixel = 0
            SquareBubble.Rotation = 45
            SquareBubble.ZIndex = 9
            GlowBubble.Size = UDim2.new(1, 30, 1, 30)
            GlowBubble.Position = UDim2.fromOffset(-15, -15)
            GlowBubble.BackgroundTransparency = 1
            GlowBubble.BorderSizePixel = 0
            GlowBubble.ZIndex = 8
            GlowBubble.Image = "rbxassetid://4996891970"
            GlowBubble.ImageColor3 = Color3.fromRGB(15, 15, 15)
            GlowBubble.ScaleType = Enum.ScaleType.Slice
            GlowBubble.SliceCenter = Rect.new(20, 20, 280, 280)
            ValueLabel.Size = UDim2.fromOffset(36, 21)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.BorderSizePixel = 0
            ValueLabel.Font = Enum.Font.Gotham
            ValueLabel.Text = tostring(math.floor(CurrentValue))
            ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ValueLabel.TextSize = 10
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Center
            ValueLabel.TextYAlignment = Enum.TextYAlignment.Center
            ValueLabel.ZIndex = 11
            SectionAPI.ElementPadding += 47
            
            local function UpdateFromInput(Input)
               local Scale = math.clamp((Input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
               local Value = Minimum + (Maximum - Minimum) * Scale
               SetValue(math.floor(Value), true)
            end
            
            ZipHitbox.MouseEnter:Connect(function()
               if not Dragging then
                  ValueBubble.Visible = true
               end
            end)
            
            ZipHitbox.MouseLeave:Connect(function()
               if not Dragging then
                  ValueBubble.Visible = false
               end
            end)
            
            ZipHitbox.InputBegan:Connect(function(Input)
               if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                  Dragging = true
                  ValueBubble.Visible = true
               end
            end)
            
           UserInputService.InputChanged:Connect(function(Input)
              if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
                 UpdateFromInput(Input)
              end
           end)
           
           UserInputService.InputEnded:Connect(function(Input)
              if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                 if Dragging then
                    Dragging = false
                    ValueBubble.Visible = false
                 end
              end
           end)
           
           SliderFrame.InputBegan:Connect(function(Input)
              if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                 UpdateFromInput(Input)
                 Dragging = true
                 ValueBubble.Visible = true
             end
          end)
          
          Slider.MouseEnter:Connect(function()
             local Tween1 = TweenService:Create(Slider, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(30, 33, 40)})
             local Tween2 = TweenService:Create(SliderStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.78})
             Tween1:Play()
             Tween2:Play()
             Tween1.Completed:Once(function()
                Tween1:Destroy()
             end)
            Tween2.Completed:Once(function()
               Tween2:Destroy()
            end)
         end)
         
         Slider.MouseLeave:Connect(function()
            local Tween1 = TweenService:Create(Slider, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(20, 22, 27)})
            local Tween2 = TweenService:Create(SliderStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.93})
            Tween1:Play()
            Tween2:Play()
            Tween1.Completed:Once(function()
               Tween1:Destroy()
            end)
            Tween2.Completed:Once(function()
               Tween2:Destroy()
            end)
        end)
        
        function SliderAPI:Change(Value: number)
           if type(Value) ~= "number" then
              return
           end
           SetValue(Value, true)
        end
        
        function SliderAPI:GetValue(): number
           return CurrentValue
        end
        
        function SliderAPI:SetCallback(NewCallback: (number) -> ())
           if type(NewCallback) == "function" then
              callback = NewCallback
           else
              error("Wevorn Library Error: Argument #1 In Method Slider:SetCallback Must Be A Function, Current Arguments Slider:SetCallback(Callback: function)")
           end
        end
        SliderAPI.Slider = Slider
        SliderAPI.SliderFrame = SliderFrame
        SliderAPI.Zip = Zip
        SetValue(CurrentValue, false)
        return SliderAPI
     end
     
     function SectionAPI:Colorpicker(text: string, preset: Color3, callback: (Color3) -> ()): table
        local Colorpicker = Instance.new("Frame", SectionAPI.Content)
        local ColorpickerTitle = Instance.new("TextLabel", Colorpicker)
        local ColorpickerFrameOutline = Instance.new("Frame", Colorpicker)
        local ColorpickerFrameOutlineCorner = Instance.new("UICorner", ColorpickerFrameOutline)
        local ColorpickerFrame = Instance.new("Frame", ColorpickerFrameOutline)
        local ColorpickerFrameCorner = Instance.new("UICorner", ColorpickerFrame)
        local Color = Instance.new("ImageLabel", ColorpickerFrame)
        local ColorCorner = Instance.new("UICorner", Color)
        local ColorSelection = Instance.new("ImageLabel", Color)
        local Hue = Instance.new("ImageLabel", ColorpickerFrame)
        local HueCorner = Instance.new("UICorner", Hue)
        local HueGradient = Instance.new("UIGradient", Hue)
        local HueSelection = Instance.new("ImageLabel", Hue)
        local PresetClr = Instance.new("Frame", ColorpickerFrame)
        local PresetClrCorner = Instance.new("UICorner", PresetClr)
        local ColorpickerAPI = {}
        
        local CurrentPreset = typeof(preset) == "Color3" and preset or Color3.fromRGB(255, 255, 255)
        local ColorH, ColorS, ColorV = Color3.toHSV(CurrentPreset)
        local ColorInput = nil
        local HueInput = nil
        local DraggingColor = false
        local DraggingHue = false
        Colorpicker.Name = RandomName()
        Colorpicker.Size = UDim2.new(1, -10, 0, 175)
        Colorpicker.BackgroundTransparency = 1
        Colorpicker.BorderSizePixel = 0
        Colorpicker.Visible = true
        Colorpicker.ZIndex = 5
        Colorpicker.AnchorPoint = Vector2.new(0.5, 0)
        Colorpicker.Position = UDim2.new(0.5, -5, 0, SectionAPI.ElementPadding)
        SectionAPI.ElementPositions[Colorpicker] = Colorpicker.Position
        ColorpickerTitle.Size = UDim2.new(1, 0, 0, 29)
        ColorpickerTitle.Position = UDim2.fromOffset(5, 0)
        ColorpickerTitle.BackgroundTransparency = 1
        ColorpickerTitle.BorderSizePixel = 0
        ColorpickerTitle.Font = Enum.Font.Gotham
        ColorpickerTitle.Text = type(text) == "string" and text or "Colorpicker"
        ColorpickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        ColorpickerTitle.TextSize = 14
        ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left
        ColorpickerTitle.TextYAlignment = Enum.TextYAlignment.Center
        ColorpickerTitle.ZIndex = 6
        ColorpickerFrameOutline.Size = UDim2.fromOffset(238, 139)
        ColorpickerFrameOutline.Position = UDim2.fromOffset(5, 29)
        ColorpickerFrameOutline.BackgroundColor3 = Color3.fromRGB(37, 40, 43)
        ColorpickerFrameOutline.BorderSizePixel = 0
        ColorpickerFrameOutline.ZIndex = 5
        ColorpickerFrameOutlineCorner.CornerRadius = UDim.new(0, 3)
        ColorpickerFrame.Size = UDim2.new(1, -4, 1, -4)
        ColorpickerFrame.Position = UDim2.fromOffset(2, 2)
        ColorpickerFrame.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
        ColorpickerFrame.BorderSizePixel = 0
        ColorpickerFrame.ClipsDescendants = true
        ColorpickerFrame.ZIndex = 6
        ColorpickerFrameCorner.CornerRadius = UDim.new(0, 3)
        Color.Size = UDim2.fromOffset(154, 118)
        Color.Position = UDim2.fromOffset(10, 10)
        Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
        Color.BorderSizePixel = 0
        Color.ZIndex = 10
        Color.Image = "rbxassetid://4155801252"
        ColorCorner.CornerRadius = UDim.new(0, 3)
        ColorSelection.Size = UDim2.fromOffset(18, 18)
        ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
        ColorSelection.Position = UDim2.new(ColorS, 0, 1 - ColorV, 0)
        ColorSelection.BackgroundTransparency = 1
        ColorSelection.BorderSizePixel = 0
        ColorSelection.ZIndex = 11
        ColorSelection.Image = "rbxassetid://4805639000"
        ColorSelection.ScaleType = Enum.ScaleType.Fit
        Hue.Size = UDim2.fromOffset(18, 118)
        Hue.Position = UDim2.fromOffset(171, 10)
        Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Hue.BorderSizePixel = 0
        Hue.ZIndex = 10
        HueCorner.CornerRadius = UDim.new(0, 3)
        HueGradient.Color = ColorSequence.new {
           ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
           ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)),
           ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)),
           ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)),
           ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)),
           ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)),
           ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
         }
        HueGradient.Rotation = 270
        HueSelection.Size = UDim2.fromOffset(18, 18)
        HueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
        HueSelection.Position = UDim2.new(0.5, 0, 1 - ColorH, 0)
        HueSelection.BackgroundTransparency = 1
        HueSelection.BorderSizePixel = 0
        HueSelection.ZIndex = 11
        HueSelection.Image = "rbxassetid://4805639000"
        PresetClr.Size = UDim2.fromOffset(25, 25)
        PresetClr.Position = UDim2.new(0.846153855, 0, 0.0740740746, 0)
        PresetClr.BackgroundColor3 = CurrentPreset
        PresetClr.BorderSizePixel = 0
        PresetClr.ZIndex = 10
        PresetClrCorner.CornerRadius = UDim.new(0, 3)
        SectionAPI.ElementPadding += 170
        local function UpdateColorPicker()
           local NewColor = Color3.fromHSV(ColorH, ColorS, ColorV)
           PresetClr.BackgroundColor3 = NewColor
          Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
          if type(callback) == "function" then
             callback(NewColor)
          end
       end
       local function UpdateColorPosition(Input)
          local ColorX = math.clamp((Input.Position.X - Color.AbsolutePosition.X) / Color.AbsoluteSize.X, 0, 1)
          local ColorY = math.clamp((Input.Position.Y - Color.AbsolutePosition.Y) / Color.AbsoluteSize.Y, 0, 1)
          ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
          ColorS = ColorX
          ColorV = 1 - ColorY
          UpdateColorPicker()
       end
      
       local function UpdateHuePosition(Input)
          local HueY = math.clamp((Input.Position.Y - Hue.AbsolutePosition.Y) / Hue.AbsoluteSize.Y, 0, 1)
          HueSelection.Position = UDim2.new(0.5, 0, HueY, 0)
          ColorH = 1 - HueY
          UpdateColorPicker()
       end
   
       Color.InputBegan:Connect(function(Input)
          if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
             DraggingColor = true
             SectionAPI.Content.ScrollingEnabled = false
             UpdateColorPosition(Input)
          end
       end)
      
       Hue.InputBegan:Connect(function(Input)
          if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
             DraggingHue = true
             SectionAPI.Content.ScrollingEnabled = false
             UpdateHuePosition(Input)
          end
       end)

       UserInputService.InputChanged:Connect(function(Input)
          if DraggingColor and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
             UpdateColorPosition(Input)
          elseif DraggingHue and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
             UpdateHuePosition(Input)
          end
       end)

       UserInputService.InputEnded:Connect(function(Input)
          if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
             DraggingColor = false
             DraggingHue = false
             SectionAPI.Content.ScrollingEnabled = true
          end
       end)
       
       function ColorpickerAPI:Change(NewColor: Color3)
          if typeof(NewColor) ~= "Color3" then
             return
          end
          CurrentPreset = NewColor
          ColorH, ColorS, ColorV = Color3.toHSV(NewColor)
          ColorSelection.Position = UDim2.new(ColorS, 0, 1 - ColorV, 0)
          HueSelection.Position = UDim2.new(0.5, 0, 1 - ColorH, 0)
          UpdateColorPicker()
       end
       function ColorpickerAPI:GetColor(): Color3
          return PresetClr.BackgroundColor3
       end
       function ColorpickerAPI:SetCallback(NewCallback: (Color3) -> ())
          if type(NewCallback) == "function" then
             callback = NewCallback
          else
             error("Wevorn Library Error: Argument #1 In Method Colorpicker:SetCallback Must Be A Function, Current Arguments Colorpicker:SetCallback(Callback: function)")
          end
       end
       ColorpickerAPI.Colorpicker = Colorpicker
       ColorpickerAPI.Preset = PresetClr
       ColorpickerAPI.Color = Color
       ColorpickerAPI.Hue = Hue
       UpdateColorPicker()
       return ColorpickerAPI
    end
    
    function SectionAPI:Dropdown(Name: string, List: table, Callback: (any) -> ()): table
       local DropdownAPI = {}
       local Opened = false
       local CurrentValue = nil
       local Items = {}
       local ElementsAfter = {}
       local ListSize = 0
       
       local Dropdown = Instance.new("Frame", SectionAPI.Content)
       local DropdownCorner = Instance.new("UICorner", Dropdown)
       local DropdownStroke = Instance.new("UIStroke", Dropdown)
       local DropdownTitle = Instance.new("TextLabel", Dropdown)
       local DropdownButton = Instance.new("TextButton", Dropdown)
       local DropdownButtonCorner = Instance.new("UICorner", DropdownButton)
       local DropdownArrow = Instance.new("TextLabel", DropdownButton)
       local DropdownList = Instance.new("ScrollingFrame", Dropdown)
       local DropdownListCorner = Instance.new("UICorner", DropdownList)
       local DropdownListStroke = Instance.new("UIStroke", DropdownList)
       local DropdownLayout = Instance.new("UIListLayout", DropdownList)
       local DropdownPadding = Instance.new("UIPadding", DropdownList)
       local DropdownButtonStroke = Instance.new("UIStroke", DropdownButton)
       local DropdownText = Instance.new("TextLabel", DropdownButton)
       
       Dropdown.Name = RandomName()
       Dropdown.Size = UDim2.new(1, -10, 0, 73)
       Dropdown.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
       Dropdown.BackgroundTransparency = 0.35
       Dropdown.BorderSizePixel = 0
       Dropdown.ClipsDescendants = false
       Dropdown.ZIndex = 20
       Dropdown.AnchorPoint = Vector2.new(0.5, 0)
       SectionAPI.ElementPadding += 5
       Dropdown.Position = UDim2.new(0.5, -5, 0, SectionAPI.ElementPadding)
       SectionAPI.ElementPositions[Dropdown] = Dropdown.Position 
       DropdownCorner.CornerRadius = UDim.new(0, 8)
       DropdownStroke.Color = Color3.fromRGB(255, 255, 255)
       DropdownStroke.Transparency = 0.93
       DropdownStroke.Thickness = 1
       DropdownTitle.Size = UDim2.new(1, -20, 0, 25)
       DropdownTitle.Position = UDim2.fromOffset(10, 0)
       DropdownTitle.BackgroundTransparency = 1
       DropdownTitle.BorderSizePixel = 0
       DropdownTitle.Font = Enum.Font.GothamMedium
       DropdownTitle.Text = type(Name) == "string" and Name or "Dropdown"
       DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
       DropdownTitle.TextSize = 14
       DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
       DropdownTitle.TextYAlignment = Enum.TextYAlignment.Center
       DropdownTitle.ZIndex = 21
       DropdownButton.Size = UDim2.new(1, -10, 0, 35)
       DropdownButton.Position = UDim2.fromOffset(5, 30)
       DropdownButton.BackgroundColor3 = Color3.fromRGB(14, 15, 18)
       DropdownButton.BackgroundTransparency = 0.15
       DropdownButton.BorderSizePixel = 0
       DropdownButton.AutoButtonColor = false
       DropdownButton.Text = ""
       DropdownButton.ZIndex = 22
       DropdownButtonCorner.CornerRadius = UDim.new(0, 7)
       DropdownButtonStroke.Color = Color3.fromRGB(255, 255, 255)
       DropdownButtonStroke.Transparency = 0.93
       DropdownButtonStroke.Thickness = 1
       DropdownText.Size = UDim2.new(1, -45, 1, 0)
       DropdownText.Position = UDim2.fromOffset(10, 0)
       DropdownText.BackgroundTransparency = 1
       DropdownText.BorderSizePixel = 0
       DropdownText.Font = Enum.Font.Gotham
       DropdownText.Text = "..."
       DropdownText.TextColor3 = Color3.fromRGB(165, 167, 171)
       DropdownText.TextSize = 13
       DropdownText.TextXAlignment = Enum.TextXAlignment.Left
       DropdownText.TextYAlignment = Enum.TextYAlignment.Center
       DropdownText.ZIndex = 23
       DropdownArrow.Size = UDim2.fromOffset(25, 35)
       DropdownArrow.Position = UDim2.new(1, -32, 0, 0)
       DropdownArrow.BackgroundTransparency = 1
       DropdownArrow.BorderSizePixel = 0
       DropdownArrow.Font = Enum.Font.GothamMedium
       DropdownArrow.Text = "↓"
       DropdownArrow.TextColor3 = Color3.fromRGB(165, 167, 171)
       DropdownArrow.TextSize = 18
       DropdownArrow.TextXAlignment = Enum.TextXAlignment.Center
       DropdownArrow.TextYAlignment = Enum.TextYAlignment.Center
       DropdownArrow.ZIndex = 23
       DropdownList.Size = UDim2.new(1, -10, 0, 0)
       DropdownList.Position = UDim2.fromOffset(5, 69)
       DropdownList.BackgroundColor3 = Color3.fromRGB(14, 15, 18)
       DropdownList.BackgroundTransparency = 0.05
       DropdownList.BorderSizePixel = 0
       DropdownList.AutomaticCanvasSize = Enum.AutomaticSize.None
       DropdownList.ScrollBarThickness = 0
       DropdownList.ScrollBarImageColor3 = Color3.fromRGB(70, 73, 80)
       DropdownList.ScrollingDirection = Enum.ScrollingDirection.Y
       
       DropdownList.ElasticBehavior = Enum.ElasticBehavior.Never
       
       DropdownList.CanvasSize = UDim2.fromOffset(0, 0)
       DropdownList.Visible = false
       DropdownList.ZIndex = 24
       DropdownListCorner.CornerRadius = UDim.new(0, 7)
       DropdownListStroke.Color = Color3.fromRGB(255, 255, 255)
       DropdownListStroke.Transparency = 0.93
       DropdownListStroke.Thickness = 1
       DropdownPadding.PaddingTop = UDim.new(0, 8)
       DropdownPadding.PaddingBottom = UDim.new(0, 4)
       DropdownPadding.PaddingLeft = UDim.new(0, 8)
       DropdownPadding.PaddingRight = UDim.new(0, 4)
       
       DropdownLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
          DropdownList.CanvasSize = UDim2.fromOffset(0, DropdownLayout.AbsoluteContentSize.Y + DropdownPadding.PaddingTop.Offset + DropdownPadding.PaddingBottom.Offset)
       end)
       
       DropdownLayout.SortOrder = Enum.SortOrder.LayoutOrder
       DropdownLayout.Padding = UDim.new(0, 3)
       
       local function UpdateCanvas()
          SectionAPI.Content.CanvasSize = UDim2.fromOffset(0, SectionAPI.ElementPadding + 10)
       end
       
       local function UpdateSize()
          local Count = #Items
          local ListSize = math.clamp(Count * 32 + 8, 0, 104)
          if Opened then
             Dropdown.Size = UDim2.new(1, -10, 0, 73 + ListSize + 8)
             DropdownList.Size = UDim2.new(1, -10, 0, ListSize)
          else
             Dropdown.Size = UDim2.new(1, -10, 0, 73)
             DropdownList.Size = UDim2.new(1, -10, 0, 0)
          end
          UpdateCanvas()
       end
       
       local function Close()
          if not Opened then
             return
          end
          Opened = false
          if OpenDropdownClose == Close then
             OpenDropdownClose = nil
          end
          for _, v in ipairs(SectionAPI.Content:GetChildren()) do
             if v:IsA("GuiObject") then
                local Position = SectionAPI.ElementPositions[v]
                if Position then
                   local Tween = TweenService:Create(v, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = Position})
                   Tween:Play()
                   Tween.Completed:Once(function()
                      Tween:Destroy()
                   end)
                end
             end
          end
          local Tween1 = TweenService:Create(Dropdown, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, -10, 0, 73)})
          local Tween2 = TweenService:Create(DropdownList, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, -10, 0, 0), Position = UDim2.fromOffset(5, 69)})
          local Tween3 = TweenService:Create(DropdownListStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 1})
          local Tween4 = TweenService:Create(DropdownArrow, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Rotation = 0})
          Tween1:Play()
          Tween2:Play()
          Tween3:Play()
          Tween4:Play()
          Tween1.Completed:Once(function()
             Tween1:Destroy()
          end)
          Tween2.Completed:Once(function()
             Tween2:Destroy()
          end)
          Tween3.Completed:Once(function()
             Tween3:Destroy()
          end)
          Tween4.Completed:Once(function()
             Tween4:Destroy()
          end)
          if SectionAPI._DropdownCanvasTween then
             SectionAPI._DropdownCanvasTween:Cancel()
          end
          SectionAPI._DropdownCanvasTween = TweenService:Create(SectionAPI.Content, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {CanvasSize = UDim2.fromOffset(0, SectionAPI.ElementPadding + 10)})
          SectionAPI._DropdownCanvasTween:Play()
          task.delay(0.25, function()
             if not Opened then
                DropdownList.Visible = false
             end
          end)
       end
       
       local function Open()
          if Opened or #Items == 0 then
             return
          end
          if OpenDropdownClose then
             OpenDropdownClose()
          end
          Opened = true
          OpenDropdownClose = Close
          DropdownList.Visible = true  
          DropdownListStroke.Transparency = 1
          local Tween = TweenService:Create(DropdownListStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.93})
          Tween:Play()
          Tween.Completed:Once(function()
             Tween:Destroy()
          end)
          local Count = #Items
          local ListSize = math.clamp(Count * 32 + 8, 0, 104)     
          local DropdownPosition = SectionAPI.ElementPositions[Dropdown]
          for _, v in ipairs(SectionAPI.Content:GetChildren()) do
             if v:IsA("GuiObject") and v ~= Dropdown then
                local Position = SectionAPI.ElementPositions[v]
                if Position then
                   local TargetPosition = Position
                   if DropdownPosition and Position.Y.Offset > DropdownPosition.Y.Offset then
                      TargetPosition = Position + UDim2.fromOffset(0, ListSize + 8)
                   end
                   local Tween = TweenService:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = TargetPosition})
                   Tween:Play()
                   Tween.Completed:Once(function()
                      Tween:Destroy()
                   end)
                end
             end
          end
          DropdownList.Size = UDim2.new(1, -10, 0, 0)
          if SectionAPI._DropdownCanvasTween then
             SectionAPI._DropdownCanvasTween:Cancel()
          end
          SectionAPI.Content.CanvasSize = UDim2.fromOffset(0, SectionAPI.ElementPadding + ListSize + 10)
          local Tween_1 = TweenService:Create(Dropdown, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, -10, 0, 73 + ListSize + 8)})
          local Tween_2 = TweenService:Create(DropdownList, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, -10, 0, ListSize), Position = UDim2.fromOffset(5, 72)})
          local Tween_3 = TweenService:Create(DropdownArrow, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Rotation = 180})
          Tween_1:Play()
          Tween_2:Play()
          Tween_3:Play()
          Tween_1.Completed:Once(function()
             Tween_1:Destroy()
          end)
          Tween_2.Completed:Once(function()
             Tween_2:Destroy()
          end)
          Tween_3.Completed:Once(function()
             Tween_3:Destroy()
          end)
       end
       
       local function AddItem(Value: string)
          local Item = Instance.new("TextButton", DropdownList)
          local ItemCorner = Instance.new("UICorner", Item)
          local ItemStroke = Instance.new("UIStroke", Item)
          local ItemText = Instance.new("TextLabel", Item)
          table.insert(Items, Item)
          Item.Name = "Item"
          Item.Size = UDim2.new(1, -4, 0, 29)
          Item.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
          Item.BackgroundTransparency = 0.35
          Item.BorderSizePixel = 0
          Item.AutoButtonColor = false
          Item.Text = ""
          Item.ZIndex = 25
          ItemCorner.CornerRadius = UDim.new(0, 7)
          ItemStroke.Color = Color3.fromRGB(255, 255, 255)
          ItemStroke.Transparency = 0.96
          ItemStroke.Thickness = 1
          ItemText.Size = UDim2.new(1, -20, 1, 0)
          ItemText.Position = UDim2.fromOffset(10, 0)
          ItemText.BackgroundTransparency = 1
          ItemText.BorderSizePixel = 0
          ItemText.Font = Enum.Font.Gotham
          ItemText.Text = type(Value) == "string" and Value or "Dropdown"
          ItemText.TextColor3 = Color3.fromRGB(212, 212, 212)
          ItemText.TextSize = 13
          ItemText.TextXAlignment = Enum.TextXAlignment.Left
          ItemText.TextYAlignment = Enum.TextYAlignment.Center
          ItemText.ZIndex = 26

          Item.MouseEnter:Connect(function()
             local Tween = TweenService:Create(Item, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(30, 33, 40), BackgroundTransparency = 0.1})
             local Tween2 = TweenService:Create(ItemStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.85})
             Tween:Play()
             Tween2:Play()
             Tween.Completed:Once(function()
                Tween:Destroy()
             end)
             Tween2.Completed:Once(function()
                Tween2:Destroy()
             end)
          end)
          
          Item.MouseLeave:Connect(function()
             local Tween = TweenService:Create(Item, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(20, 22, 27), BackgroundTransparency = 0.35})
             local Tween2 = TweenService:Create(ItemStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.96})
             Tween:Play()
             Tween2:Play()
             Tween.Completed:Once(function()
                Tween:Destroy()
             end)
             Tween2.Completed:Once(function()
                Tween2:Destroy()
             end)
          end)    
 
          Item.Activated:Connect(function()
             CurrentValue = Value
             DropdownText.Text = type(Value) == "string" and Value or "Dropdown"
             if type(Callback) == "function" then
                Callback(Value)
             end
             Close()
          end)
          UpdateSize()
      end
      
      DropdownButton.MouseEnter:Connect(function()
         local Tween = TweenService:Create(DropdownButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(22, 24, 29)})
         local Tween2 = TweenService:Create(DropdownButtonStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.78})
         Tween:Play()
         Tween2:Play()
         Tween.Completed:Once(function()
            Tween:Destroy()
         end)
         Tween2.Completed:Once(function()
            Tween2:Destroy()
         end)
      end)
      
      DropdownButton.MouseLeave:Connect(function()
         local Tween = TweenService:Create(DropdownButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(14, 15, 18)})
         local Tween2 = TweenService:Create(DropdownButtonStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.93})
         Tween:Play()
         Tween2:Play()
         Tween.Completed:Once(function()
            Tween:Destroy()
         end)
         Tween2.Completed:Once(function()
            Tween2:Destroy()
         end)
      end)
      
      DropdownButton.Activated:Connect(function()
         if Opened then
            Close()
         else
            Open()
         end
      end)
      
      if type(List) == "table" then
         for _, v in next, List do
            AddItem(v)
         end
      end
      SectionAPI.ElementPadding += 81
      UpdateSize()
      SectionAPI.Content.CanvasSize = UDim2.fromOffset(0, SectionAPI.ElementPadding + 10)
      task.defer(function()
         SectionAPI.Content.CanvasSize = UDim2.fromOffset(0, SectionAPI.ElementPadding + 10)
      end)
      function DropdownAPI:Add(Value: string): nil
         if type(Value) == "string" then
            AddItem(Value)
         else
            AddItem("Dropdown")
         end
      end
      function DropdownAPI:Clear(): nil
         Close()
         for _, v in ipairs(Items) do
            v:Destroy()
         end
         table.clear(Items)
         CurrentValue = nil
         DropdownText.Text = "..."
         UpdateSize()
      end
      function DropdownAPI:Set(Value: string)
         CurrentValue = Value
         DropdownText.Text = type(Value) == "string" and Value or "Dropdown"
      end
      function DropdownAPI:GetValue()
         return CurrentValue
      end
      function DropdownAPI:SetCallback(NewCallback: (any) -> ())
         if type(NewCallback) == "function" then
            Callback = NewCallback
         else
            error("Wevorn Library Error: Argument #1 In Method Dropdown:SetCallback Must Be A Function, Current Arguments Dropdown:SetCallback(Callback: function)")
         end
      end
      function DropdownAPI:Close()
         Close()
      end
      DropdownAPI.Dropdown = Dropdown
      DropdownAPI.Button = DropdownButton
      DropdownAPI.List = DropdownList
      DropdownAPI.Text = DropdownText
      return DropdownAPI
   end
    -- Я ненавижу отступы сука где я опять просрал 5 пробеов
          table.insert(self.Sections, SectionAPI)
          if CurrentServer == self then
             SectionButton.Visible = true
          else
             SectionButton.Visible = false
          end
          if not ServerAPI.CurrentSection then
             SectionAPI:Select()
          end
          return SectionAPI
       end
       ServerButton.Name = RandomName()
       ServerButton.Size = UDim2.fromOffset(65, 65)
       ServerButton.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
       ServerButton.BackgroundTransparency = 0.432
       ServerButton.BorderSizePixel = 0
       ServerButton.Text = "" 
       ServerButton.AutoButtonColor = false
       ServerButton.LayoutOrder = #Servers + 1
       ServerButton.ZIndex = 2
       ServerCorner.CornerRadius = UDim.new(0, 12)
       ServerStroke.Transparency = 0.93
       ServerImage.Size = UDim2.fromOffset(35, 35)
       ServerImage.Position = UDim2.fromOffset(15, 15)
       ServerImage.BackgroundTransparency = 1
       ServerImage.Image = ServerImageId
       ServerImage.ScaleType = Enum.ScaleType.Crop
       ServerImage.Visible = ServerImageId ~= ""
       ServerImage.ZIndex = 3
       local FirstLetter = string.upper(string.sub(ServerName, 1, 1))
       ServerLetter.Size = UDim2.fromScale(1, 1)
       ServerLetter.BackgroundTransparency = 1
       ServerLetter.Text = FirstLetter
       ServerLetter.TextColor3 = Color3.fromRGB(255, 255, 255)
       ServerLetter.TextSize = 24
       ServerLetter.Font = Enum.Font.GothamSemibold
       ServerLetter.TextXAlignment = Enum.TextXAlignment.Center
       ServerLetter.TextYAlignment = Enum.TextYAlignment.Center
       ServerLetter.Visible = ServerImageId == ""
       ServerLetter.ZIndex = 3
       function ServerAPI:Select()
          if CurrentServer == self then
             return
          end
          if CurrentServer then
             CurrentServer.Selected = false
             local Tween = TweenService:Create(CurrentServer.Button, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(14, 15, 18)})
             Tween:Play()
             Tween.Completed:Once(function()
                Tween:Destroy()
             end)
             local OldStroke = CurrentServer.Button:FindFirstChildOfClass("UIStroke")
             if OldStroke then
                local Tween2 = TweenService:Create(OldStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Transparency = 0.93})
                Tween2:Play()
                Tween2.Completed:Once(function()
                   Tween2:Destroy()
                end)
             end
             for _, v in ipairs(CurrentServer.Sections) do
                if v.ButtonObject then
                   v.ButtonObject.Visible = false
                end
                if v.Content then
                   v.Content.Visible = false
                end
             end
          end
          CurrentServer = self
          self.Selected = true
          TitleText.Text = WindowName .. " | " .. tostring(self.Name)
          for _, v in ipairs(self.Sections) do
             if v.ButtonObject then
                v.ButtonObject.Visible = true
             end
          end
          
          for _, v in ipairs(self.Sections) do
            v.Content.Visible = v.Selected
          end

          if self.CurrentSection then
             self.CurrentSection:Select()
          end
          
          local Tween_4 = TweenService:Create(self.Button, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),{BackgroundColor3 = Color3.fromRGB(35, 37, 44)})
          Tween_4:Play()
          Tween_4.Completed:Once(function()
             Tween_4:Destroy()
          end)
          local NewStroke = self.Button:FindFirstChildOfClass("UIStroke")
          if NewStroke then
             local Tween = TweenService:Create(NewStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),{Transparency = 0.85})
             Tween:Play()
             Tween.Completed:Once(function()
                Tween:Destroy()
             end)
          end
       end
      function ServerAPI:Channel(Name: string): table
         return ServerAPI:Section(type(Name) == "string" and Name or "Channel")
      end
      ServerButton.Activated:Connect(function()
         ServerAPI:Select()
      end)
      table.insert(Servers, ServerAPI)
      if not CurrentServer then         
         ServerAPI:Select()
      end
      ServerButton.Visible = ServersOpen and not Minimized
      return ServerAPI
   end
   return WindowAPI
end
return Libary
