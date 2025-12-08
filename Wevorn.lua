local LoadTime = tick()
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ProximityPromptService = game:GetService("ProximityPromptService")
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local MarketplaceService  = game:GetService("MarketplaceService")
local CoreGui  = game:GetService("CoreGui")
local VirtualUser  = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local workspace  = game:GetService("Workspace")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local AssetService = game:GetService("AssetService")
local NetworkClient = game:GetService("NetworkClient")
local NetworkSettings = settings().Network
local oldNamecall
local oldNewindex
local UgcId
local PlaceId = game.PlaceId
local LocalName = player.Name
local BindableRemoteEventToggle
local BindableRemoteFunctionToggle
local _Remotes = {}
local __Remotes = {}
local Number1
local Number2
local Number3
local Number4
local Number5
local Number6
local Prompt1
local Prompt2
local Light1 
local Light2
local Light3
local Light4 
local Light5
local PlaceIds = {}
local Places = {}
local _PlaceId
local pp
local GamePassLink
local GamePass
local GamePassNames = {}
local GamePassIds = {}
local DevProductLink
local DevProduct 
local DevProductsNames = {}
local DevProductsIds = {}
local AntiTeleport = false
local PurchasePrice
local Price
local _Price
local PurchaseLink
local SettingsWevorn = {}
local Home
local HidePlayers = {}
local Conn_1
local old_namecall = nil
getgenv().NotificationRemotes = true
getgenv().EnableNumber = false
getgenv().AutoClickerPurchase = false
getgenv().AutoClickerClose = false
getgenv().AutoClickerCloseErors = false
getgenv().OpenConsole = false 
getgenv().BuyPaidItems = false
getgenv().UseTools = false
getgenv().SelectRemote = nil
getgenv().LevelConnect = nil
getgenv().LoopFireAllProximityPrompt = false
getgenv().LoopFireAllClickDetector = false
getgenv().LoopFireAllTouchInterest = false
getgenv().LoopFireDevProduct = false
getgenv().LoopFireGamePass = false
getgenv().AutoHidePlayers = false
getgenv().HumPosition = nil
getgenv().Ticket = false 

local defaultSettings = {
    ["Change Log"] = true,
    ["Home"] = true,
    ["Scripts"] = true,
    ["UGC Limiteds"] = true,
    ["Remotes"] = true,
    ["Games"] = true,
    ["Players"] = true,
    ["Network"] = true,
    ["Input Automations"] = true,
    ["Purchase Exploits"] = true,
    ["Purchase Signals"] = true
}

for i, v in pairs(defaultSettings) do
if getgenv().Settings and getgenv().Settings[i] ~= nil then
SettingsWevorn[i] = getgenv().Settings[i]
else
SettingsWevori.[i]= v
end
end

local BindableRemoteEventToggle = false
local BindableFunctionToggle = false

pcall(function()
for _, v in ipairs(game:GetService("RobloxReplicatedStorage"):GetChildren()) do
v:Destroy()
end
end)

local discord = loadstring(game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/DiscordLubary.lua"))()

local win = discord:Window("Wevorn v1.0.1")

local serv = win:Server("Wevorn", "http://www.roblox.com/asset/?id=6031075938")

if SettingsWevorn["Change Log"] then
local changelog = serv:Channel("Change Log")

changelog:Label("Welcome to Wevorn! \nThis script maked by Games1799")
changelog:Label("---------------------------------------------------------------------\nReleased! Update v1.0.1!")
changelog:Seperator()
changelog:Label("Fixed settings bug")
end

if SettingsWevorn["Home"] then
Home = serv:Channel("Home")
Home:Label("\nThank you for using Wevorn!\nThe #2 UGC Games Penetration Testing Tool! (mine is still better)")
Home:Label("Check out the other Discord channels to see our available tools!")
Home:Seperator()
end

if SettingsWevorn["Scripts"] then
local Scripts = serv:Channel("Scripts")

Scripts:Label("All popular script worthy of your attention ")

Scripts:Button("Infinite yield",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

Scripts:Button("Dex explorer",function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))()
end)

Scripts:Button("Remote spy",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
end)

Scripts:Button("Dev Products Purchaser", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ckw69/Wyborn/refs/heads/main/Dev%20Product%20Purchase"))()
end)

Scripts:Button("Hydroxide", function()
local owner = "Upbolt"
local branch = "revision"
local function webImport(file)
return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
end
webImport("init")
webImport("ui/main")
end)

Scripts:Button("Adonis Anti Cheat Bypass", function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua'))()
end)

Scripts:Seperator()

Scripts:Label("Scripts by Games1799")

Scripts:Button("JustScript",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/JustScript.lua"))()
end)

Scripts:Button("RemoteBrowser",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/RemoteBrowser"))()
end)

Scripts:Button("RemoteBrowser V3 (Beta)",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Games1799/Scripts/refs/heads/main/RemoteBrowserV3_Beta"))()
end)
end
if SettingsWevorn["UGC Limiteds"] then
local UGCLimiteds = serv:Channel("UGC Limiteds")

UGCLimiteds:Label("Looking for Remote Bruteforcing? Check out #Remotes!")
UGCLimiteds:Seperator()
UGCLimiteds:Label("\nThis will auto purchase any limited that gets prompted!\nThis is recommended to use in the rolimons game.\n")
UGCLimiteds:Label("With this, you can get #1 serials of web UGC item drops!")

UGCLimiteds:Button("Teleport to Rolimons UGC Game", function()
TeleportService:Teleport(14056754882,game.Players.LocalPlayer)
end)

UGCLimiteds:Toggle("Enable Auto Click Purchaser",false,function(state)
getgenv().AutoClickerPurchase = state
while getgenv().AutoClickerPurchase and task.wait() do
task.spawn(function()
pcall(function()
if CoreGui.PurchasePromptApp then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchaseModal then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchaseModal.AlertContents then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchaseModal.AlertContents.Footer then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchaseModal.AlertContents.Footer.Buttons then 
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchaseModal.AlertContents.Footer.Buttons[1] then
local SusButtonFullName = CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchaseModal.AlertContents.Footer.Buttons[1]
local SusButtonPos = SusButtonFullName.AbsolutePosition + (SusButtonFullName.AbsolutePosition / 2.4)
VirtualInputManager:SendMouseButtonEvent(SusButtonPos.X,SusButtonPos.Y,0,true,game,0)
task.wait()
VirtualInputManager:SendMouseButtonEvent(SusButtonPos.X,SusButtonPos.Y,0,false,game,0)
end end end end end end end end 
end)
end)
end
end)

UGCLimiteds:Toggle("Enable Auto Click Close Error",false,function(state)
getgenv().AutoClickerCloseErors = state

while getgenv().AutoClickerCloseErors and task.wait() do
task.spawn(function()
pcall(function()
if CoreGui.PurchasePromptApp then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchasePrompt then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchasePrompt.AlertContents then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchasePrompt.AlertContents.Footer then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchasePrompt.AlertContents.Footer.Buttons then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchasePrompt.AlertContents.Footer.Buttons["1"] then
local CloseErrorButton = game:GetService("CoreGui").PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchasePrompt.AlertContents.Footer.Buttons["1"]
local CloseErrorButtonPos = CloseErrorButton.AbsolutePosition + (CloseErrorButton.AbsolutePosition / 2.4)
VirtualInputManager:SendMouseButtonEvent(CloseErrorButtonPos.X,CloseErrorButtonPos.Y,0,true,game,0)
task.wait()
VirtualInputManager:SendMouseButtonEvent(CloseErrorButtonPos.X,CloseErrorButtonPos.Y,0,false,game,0)
end end end end end end end end
end)
end)
end

end)

UGCLimiteds:Toggle("Enable Auto Close Prompt (No Error)",false,function(state)
getgenv().AutoClickerClose = state
while getgenv().AutoClickerClose and task.wait() do
task.spawn(function()
pcall(function()
if CoreGui.PurchasePromptApp then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer then 
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchaseModal then 
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchaseModal.AlertContents then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchaseModal.AlertContents.TitleContainer then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchaseModal.AlertContents.TitleContainer.TitleArea then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchaseModal.AlertContents.TitleContainer.TitleArea.Title then
if CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchaseModal.AlertContents.TitleContainer.TitleArea.Title.CloseButton then
local CloseButtonFullName = CoreGui.PurchasePromptApp.ProductPurchaseContainer.Animator.ProductPurchaseModal.AlertContents.TitleContainer.TitleArea.Title.CloseButton
local CloseButtonPos = CloseButtonFullName.AbsolutePosition + (CloseButtonFullName.AbsoluteSize * 1.65) -  Vector2.new(10,-15)
VirtualInputManager:SendMouseButtonEvent(CloseButtonPos.X,CloseButtonPos.Y,0,true,game,0)
task.wait()
VirtualInputManager:SendMouseButtonEvent(CloseButtonPos.X,CloseButtonPos.Y,0,false,game,0)
end end end end end end end end end
end)
end)
end
end)

UGCLimiteds:Seperator()

UGCLimiteds:Toggle("Open Console After Purchase",function(state)
getgenv().OpenConsole = state
end)

UGCLimiteds:Toggle("Auto Purchase Paid Items (For Below)",function(state)
getgenv().BuyPaidItems = state
end)

UGCLimiteds:Toggle("Auto Purchaser",false,function(state)
if state then
discord:Notification("Waiting","Waiting for any free UGC item to be prompted...","Okay!")

local Conn = MarketplaceService.PromptPurchaseRequestedV2:Connect(function(...)
local t = {...}
discord:Notification("Prompt Detected","If this is a UGC item, this script will attempt purchase. Please check console.","Okay!")
local PurchaseProductId = t[2]
local IdempotencyKey = t[5]
local PurchaseAuthToken = t[6]
local info = MarketplaceService:GetProductInfo(PurchaseProductId)
local PurchaseCollectibleItemId = info.CollectibleItemId
local PurchaseCollectibleProductId = info.CollectibleProductId
local PurchaseInfoType = Enum.InfoType.Asset
if getgenv().BuyPaidItem then PurchasePrice = info.PriceInRobux else PurchasePrice = 0 end
local IsRobloxPurchase = true
local PurchaseRequestId = HttpService:GenerateGUID(false)

print("ProductId — ",PurchaseProductId)
print("IdempotencyKey — ",IdempotencyKey)
print("AuthToken — ",PurchaseAuthToken)
print("CollectibleItemId — ",PurchaseCollectibleItemId)
print("CollectibleProductId — ",PurchaseCollectibleProductId)
print("InfoType — ",PurchaseInfoType)
print("Price — ",PurchasePrice)
print("IsRobloxPurchase — ",IsRobloxPurchase)
print("RequestId — ",PurchaseRequestId)
warn("———————————————————————————————")
warn("FIRST PURCHASE  ITEM!")
if getgenv().OpenConsole then 
VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F9, false, nil)
task.wait(0.01)
VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F9, false, nil)
local sus,eror = pcall(function()
MarketplaceService:PerformPurchase(PurchaseInfoType,PurchaseProductId,PurchasePrice,PurchaseRequestId,IsRobloxPurchase,PurchaseCollectibleItemId,PurchaseCollectibleProductId,IdempotencyKey,PurchaseAuthToken)
end)
if not sus then error("Snaiper V1 Eror — "..eror) else print("Purchase success!") end
end
end)
else
Conn:Disconnect()
end
end)

UGCLimiteds:Toggle("Auto Purchaser V2 (Only UGC Limiteds)",false,function(state)
if state then
discord:Notification("Waiting","Waiting for any free UGC item to be prompted...","Okay!")
local _Conn = MarketplaceService.PromptPurchaseRequestedV2:Connect(function(...)
discord:Notification("Prompt Detected","If this is a UGC item, this script will attempt purchase. Please check console.","Okay!")
local k = {...}
local InfoType = Enum.InfoType.Asset
local ProductId  = k[2]
local info = MarketplaceService:GetProductInfo(ProductId)
if getgenv().BuyPaidItem then Price = info.PriceInRobux else Price = 0 end
local RequestId = HttpService:GenerateGUID(false)
local IsRbxPurchase = true
local collectiblesProductDetails = info.CollectibleDetails
print("InfoType — ",InfoType)
print("ProductId — ",ProductId)
print("Price — ",Price)
print("RequestId — ",RequestId)
print("IsRobloxPurchase — ",IsRbxPurchase)
print("collectiblesProductDetails — ",collectiblesProductDetails)
warn("———————————————————————————————")
warn("FIRST PURCHASE  ITEM!")
local _sus,_eror = pcall(function()
if not _sus then error("Snaiper V2 Eror — ".._eror) else print("Purchase success!") end
if getgenv().OpenConsole then 
VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F9, false, nil)
task.wait(0.01)
VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F9, false, nil)
end
MarketplaceService:PerformPurchaseV2(InfoType,ProductId,Price,RequestId,IsRbxPurchase,collectiblesProductDetails)
end)
end)
else
_Conn:Disconnect()
end
end)

UGCLimiteds:Toggle("Auto Purchaser V3 (WEB Only)",false,function(state)
if state then
discord:Notification("Waiting","Waiting for any free UGC item to be prompted...","Okay!")
local __con = MarketplaceService.PromptPurchaseRequestedV2:Connect(function(...)
local j = {...}
local _ProductId = j[2]
local _info = MarketplaceService:GetProductInfo(_ProductId)
local _CollectibleItemId = _info.CollectibleItemId
local _PurchaseCollectibleProductId = _info.CollectibleProductId
local _ExpectedCurrency = 1
if getgenv().BuyPaidItem then _Price = _info.PriceInRobux else _Price = 0 end
local _IdempotencyKey = HttpService:GenerateGUID(false)
local _SellerId = _info.Creator.Id
local _SellerType = _info.Creator.CreatorType
local _PurchaserType = "User"
local _PurchaserUserId = player.UserId
local Data = {_ProductId,_CollectibleItemId,_PurchaseCollectibleProductId,_ExpectedCurrency,_Price,_IdempotencyKey,_SellerId,_SellerType,_PurchaserType,_PurchaserUserId}
local JsonData = HttpService:JSONEncode(Data)
pcall(function()
PurchaseLink = "https://apis.roblox.com/marketplace-sales/v1/item/"..tostring(_info.CollectibleItemId).."/purchase-item"
end)
local _Ye,_No
if PurchaseLink then
if getgenv().OpenConsole then 
VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F9, false, nil)
task.wait(0.01)
VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F9, false, nil)
end
_Ye,_No = pcall(function()
HttpRbxApiService:GetAsyncFullUrl(PurchaseLink,Enum.HttpContentType.ApplicationJson,false,{},JsonData)
end)
end
if _Ye then
print("answer : "..response)
local decoded = HttpService:JSONDecode(response)
print(decoded)
else
warn("Eror Request:", response)
end
end)
else
__con:Disconnect()
end
end)

UGCLimiteds:Toggle("Auto Purchaser V4 (Only BULK)",false,function(state)
if state then 
discord:Notification("Waiting","Waiting for any free UGC item to be prompted...","Okay!")
local ___con = MarketplaceService.PromptBulkPurchaseRequested:Connect(function(...)
local w = {...}
local PurchaseOrderQuest = w[3] or {}
local PurchasOptions = w[6] or {}
print("PurchaseOrderQuest — "..PurchaseOrderQuest)
print("PurchasOptions — "..PurchasOptions)
warn("ITEM TO PURCHASE!")
if getgenv().OpenConsole then 
VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F9, false, nil)
task.wait(0.01)
VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F9, false, nil)
end
MarketplaceService:PerformBulkPurchase(PurchaseOrderQuest,PurchasOptions)
end)
else
___con:Disconnect()
end
end)
end

if SettingsWevorn["Remotes"] then
local Remotes = serv:Channel("Remotes")

Remotes:Label("\nFires all remotes in the game as an attempt to prompt the item.\nWarning: This can be risky and can fire a decoy remote!")

Remotes:Textbox("UGC Limited Item ID","Enter Item ID that you wanna be included in the arguments...",false,function(id)
getgenv().UgcId = tonumber(id)
if getgenv().UgcId then
discord:Notification("Success","The script now remembers that the Item ID you want is " .. tostring(getgenv().UgcId) .. "!","Okay!")
else
discord:Notification("Error","That's... not an Item ID.", "Okay!")
end
end)

Remotes:Dropdown("Remote Arguments...",{
         "No Arguments/Blank",
         "Bulk Purchase Function 1, (Ugc Item Id)",
         "Bulk Purchase Function 2, (Ugc Item Id, nil)",
         "Bulk Purchase Function 3, (UGC Item Id, Fake Ids)",
         "LocalPlayer",
         "Your Username",
         "Your UserId",
         "UGC Item ID",
         "UGC Item ID, LocalPlayer",
         "LocalPlayer, UGC Item ID",
         "'UGC' as a string",
         "'PromptPurchase' as a string, UGC Item Id",
         "'PromptAssetPurchase' as a string, UGC Item Id",
         "UGC Item ID, 'true' boolean",
         "UGC Item ID, 'false' boolean",
         "UGC Item ID, Your UserId",
         "'true' boolean",
         "'false' boolean",
         "literal lua code to prompt item",
         "UGC Item ID, 0",
         "UGC Item Id, negative value",
         "Positive value",
         "Negative value",
         "loadstring prompt item"
        },function(x)
        getgenv().RemoteFireMethod = (x)
end)

local function FireRemotes(...)
local Count  = 0
local args = {...}
for _, v in ipairs (game:GetDescendants()) do
if v:IsA("RemoteEvent") or v:IsA("UnreliableRemoteEvent") then
Count = Count + 1
task.spawn(function()
pcall(function()
v:FireServer(table.unpack(args))
end)
end)

elseif v:IsA("RemoteFunction") then
Count = Count + 1
task.spawn(function()
pcall(function()
v:InvokeServer(table.unpack(args))
end)
end)

elseif v:IsA("BindableEvent") then
Count = Count + 1
if BindableRemoteEventToggle then
task.spawn(function()
pcall(function()
v:Fire(table.unpack(args))
end)
end)
end

elseif v:IsA("BindableFunction") then
Count = Count + 1
if BindableFunctionToggle then
task.spawn(function()
pcall(function()
v:Invoke(table.unpack(args)) 
end)
end)
end

end
end
if getgenv().NotificationRemotes then
discord:Notification("Success","Fired "..Count.." Remotes","Okay!")
end
end

local function _FireRemotes(...)
local _Count  = 0
local _args = {...}
for _, v in ipairs (game:GetDescendants()) do
if v:IsA("RemoteEvent") or v:IsA("UnreliableRemoteEvent") then
_Count = _Count + 1
task.spawn(function()
pcall(function()
v:FireServer(unpack(_args))
end)
end)

elseif v:IsA("RemoteFunction") then
_Count = _Count + 1
task.spawn(function()
pcall(function()
v:InvokeServer(unpack(_args))
end)
end)

elseif v:IsA("BindableEvent") then
_Count = _Count + 1
if BindableRemoteEventToggle then
task.spawn(function()
pcall(function()
v:Fire(unpack(_args))
end)
end)
end

elseif v:IsA("BindableFunction") then
_Count = _Count + 1
if BindableRemoteFunctionToggle then
task.spawn(function()
pcall(function()
v:Invoke(unpack(_args)) 
end)
end)
end

end
end
if getgenv().NotificationRemotes then
discord:Notification("Success","Fired ".._Count.." Remotes","Okay!")
end
end

local function __FireRemotes(Remote1,...)
local __args = {...}
if Remote1:IsA("RemoteEvent") or Remote1:IsA("UnreliableRemoteEvent") then
task.spawn(function()
pcall(function()
Remote1:FireServer(unpack(__args))
end)
end)

elseif Remote1:IsA("RemoteFunction") then
task.spawn(function()
pcall(function()
Remote1:InvokeServer(unpack(__args))
end)
end)

elseif Remote1:IsA("BindableEvent") then
if BindableRemoteEventToggle then
task.spawn(function()
pcall(function()
Remote1:Fire(unpack(__args))
end)
end)
end

elseif Remote1:IsA("BindableFunction") then
if BindableRemoteFunctionToggle then
task.spawn(function()
pcall(function()
Remote1:Invoke(unpack(__args)) 
end)
end)
end

end
if getgenv().NotificationRemotes then
discord:Notification("Success","Fired This Remote","Okay!")
end
end

local function ___FireRemotes(Remote2,...)
local ___args = {...}
if Remote2:IsA("RemoteEvent") or Remote2:IsA("UnreliableRemoteEvent") then
task.spawn(function()
pcall(function()
Remote2:FireServer(table.unpack(___args))
end)
end)

elseif Remote2:IsA("RemoteFunction") then
task.spawn(function()
pcall(function()
Remote2:InvokeServer(table.unpack(___args))
end)
end)

elseif Remote2:IsA("BindableEvent") then
if BindableRemoteEventToggle then
task.spawn(function()
pcall(function()
Remote2:Fire(table.unpack(___args))
end)
end)
end

elseif Remote2:IsA("BindableFunction") then
if BindableFunctionToggle then
task.spawn(function()
pcall(function()
Remote2:Invoke(table.unpack(___args)) 
end)
end)
end

end
if getgenv().NotificationRemotes then
discord:Notification("Success","Fired This Remote","Okay!")
end
end

Remotes:Button("Fire All Remotes",function()

local method = getgenv().RemoteFireMethod

-- Function "FireRemotes" â€” unpack.table (all)
-- Function "_FireRemotes" â€” unpack (all)
-- Function "__FireRemotes" â€” unpack (one)
-- Function "___FireRemotes" â€” table.unpack (one)
-- Use "_FireRemotes" for Bulk Purchase and "FireRemotes" for usual
-- Use "__FireRemotes for Bulk Purchase and "___FireRemotes" for usual"

if method == "No Arguments/Blank" then 
FireRemotes()

elseif method == "LocalPlayer" then 
FireRemotes(game.Players.LocalPlayer)

elseif method == "Your Username" then 
FireRemotes(tostring(game.Players.LocalPlayer))

elseif method == "Your UserId" then 
FireRemotes(game.Players.LocalPlayer.UserId)

elseif method == "UGC Item ID" then
FireRemotes(getgenv().UgcId)

elseif method == "UGC Item ID, LocalPlayer" then
FireRemotes(getgenv().UgcId,game.Players.LocalPlayer)

elseif method == "LocalPlayer, UGC Item ID" then
FireRemotes(game.Players.LocalPlayer,getgenv().UgcId)

elseif method == "'UGC' as a string" then 
FireRemotes("UGC")

elseif method == "'PromptPurchase' as a string, UGC Item Id" then 
FireRemotes("PromptPurchase",getgenv().UgcId)

elseif method == "'PromptAssetPurchase' as a string, UGC Item Id" then 
FireRemotes("PromptAssetPurchase",getgenv().UgcId)

elseif method == "UGC Item ID, 'true' boolean" then
FireRemotes(getgenv().UgcId,true)

elseif method == "UGC Item ID, 'false' boolean" then
FireRemotes(getgenv().UgcId,false)

elseif method == "UGC Item ID, Your UserId" then
FireRemotes(getgenv().UgcId,game.Players.LocalPlayer.UserId)

elseif method == "'true' boolean" then 
FireRemotes(true)

elseif method == "'false' boolean" then 
FireRemotes(false)

elseif method == "literal lua code to prompt item" then
FireRemotes('game:GetService("MarketplaceService"):PromptPurchase(game.Players.'..LocalName..','..getgenv().UgcId..')')

elseif method == "UGC Item ID, 0" then
FireRemotes(getgenv().UgcId,0)

elseif method == "UGC Item Id, negative value" then
FireRemotes(getgenv().UgcId,-9999999999999999)

elseif method == "Positive value" then
FireRemotes(9999999999999999)

elseif method == "Negative value" then
FireRemotes(-9999999999999999)

elseif method == "loadstring prompt item" then 
FireRemotes("loadstring('game:GetService(\"MarketplaceService\"):PromptPurchase(game.Players."..LocalName..","..getgenv().UgcId..")')()")

elseif method == "Bulk Purchase Function 1, (Ugc Item Id)" then
_FireRemotes({[1] = {[1] = {Id = tostring(getgenv().UgcId),Type = Enum.MarketplaceProductType.AvatarAsset}},[2] = {} })

elseif method == "Bulk Purchase Function 2, (Ugc Item Id, nil)" then
_FireRemotes({[1] = {[1] = {Id = getgenv().UgcId,Type = Enum.MarketplaceProductType.AvatarAsset}},[2] = {Id = nil,Type = Enum.MarketplaceProductType.AvatarAsset},[3] = {Id = nil,Type = Enum.MarketplaceProductType.AvatarAsset} })

elseif method == "Bulk Purchase Function 3, (UGC Item Id, Fake Ids)" then 
_FireRemotes({[1] = {[1] = {Id = getgenv().UgcId,Type = Enum.MarketplaceProductType.AvatarAsset}},[2] = {Id = 137525346725198,Type = Enum.MarketplaceProductType.AvatarAsset},[3] = {Id = 77554705161930,Type = Enum.MarketplaceProductType.AvatarAsset} })
end
end)

if not BindableRemoteEventToggle then
Remotes:Toggle("Enable BindableRemoteEvent",false,function(state)
if state then 
BindableRemoteEventToggle = true 
else
BindableRemoteEventToggle = false
end
end)
end

if not BindableFunctionToggle then
Remotes:Toggle("Endable BindableFunction",false,function(state)
if state then
BindableFunctionToggle = true
else 
BindableFunctionToggle = false
end
end)
end

Remotes:Toggle("Loop Fire All Remotes",false,function(state)
if state then
getgenv().NotificationRemotes = false
local method = getgenv().RemoteFireMethod
getgenv().Loop = true
while getgenv().Loop do 
if method == "No Arguments/Blank" then 
FireRemotes()

elseif method == "LocalPlayer" then 
FireRemotes(game.Players.LocalPlayer)

elseif method == "Your Username" then 
FireRemotes(tostring(game.Players.LocalPlayer))

elseif method == "Your UserId" then 
FireRemotes(game.Players.LocalPlayer.UserId)

elseif method == "UGC Item ID" then
FireRemotes(getgenv().UgcId)

elseif method == "UGC Item ID, LocalPlayer" then
FireRemotes(getgenv().UgcId,game.Players.LocalPlayer)

elseif method == "LocalPlayer, UGC Item ID" then
FireRemotes(game.Players.LocalPlayer,getgenv().UgcId)

elseif method == "'UGC' as a string" then 
FireRemotes("UGC")

elseif method == "'PromptPurchase' as a string, UGC Item Id" then 
FireRemotes("PromptPurchase",getgenv().UgcId)

elseif method == "'PromptAssetPurchase' as a string, UGC Item Id" then 
FireRemotes("PromptAssetPurchase",getgenv().UgcId)

elseif method == "UGC Item ID, 'true' boolean" then
FireRemotes(getgenv().UgcId,true)

elseif method == "UGC Item ID, 'false' boolean" then
FireRemotes(getgenv().UgcId,false)

elseif method == "UGC Item ID, Your UserId" then
FireRemotes(getgenv().UgcId,game.Players.LocalPlayer.UserId)

elseif method == "'true' boolean" then 
FireRemotes(true)

elseif method == "'false' boolean" then 
FireRemotes(false)

elseif method == "literal lua code to prompt item" then
FireRemotes('game:GetService("MarketplaceService"):PromptPurchase(game.Players.'..LocalName..','..getgenv().UgcId..')')

elseif method == "UGC Item ID, 0" then
FireRemotes(getgenv().UgcId,0)

elseif method == "UGC Item Id, negative value" then
FireRemotes(getgenv().UgcId,-9999999999999999)

elseif method == "Positive value" then
FireRemotes(9999999999999999)

elseif method == "Negative value" then
FireRemotes(-9999999999999999)

elseif method == "loadstring prompt item" then 
FireRemotes("loadstring('game:GetService(\"MarketplaceService\"):PromptPurchase(game.Players."..LocalName..","..getgenv().UgcId..")')()")

elseif method == "Bulk Purchase Function 1, (Ugc Item Id)" then
_FireRemotes({[1] = {[1] = {Id = tostring(getgenv().UgcId),Type = Enum.MarketplaceProductType.AvatarAsset}},[2] = {} })

elseif method == "Bulk Purchase Function 2, (Ugc Item Id, nil)" then
_FireRemotes({[1] = {[1] = {Id = getgenv().UgcId,Type = Enum.MarketplaceProductType.AvatarAsset}},[2] = {Id = nil,Type = Enum.MarketplaceProductType.AvatarAsset},[3] = {Id = nil,Type = Enum.MarketplaceProductType.AvatarAsset} })

elseif method == "Bulk Purchase Function 3, (UGC Item Id, Fake Ids)" then 
_FireRemotes({[1] = {[1] = {Id = getgenv().UgcId,Type = Enum.MarketplaceProductType.AvatarAsset}},[2] = {Id = 137525346725198,Type = Enum.MarketplaceProductType.AvatarAsset},[3] = {Id = 77554705161930,Type = Enum.MarketplaceProductType.AvatarAsset} })
end
task.wait(0.01)
end
else
getgenv().Loop = false
getgenv().NotificationRemotes = true
end
end)

Remotes:Seperator()

Remotes:Label("\nThis will block client communication with the server.\nUseful for bypassing clientsided anticheats!\n")

Remotes:Toggle("Block All Remotes Called",false,function(state)
if state then
local mt = getrawmetatable(game)
setreadonly(mt,false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self,...)
local method = getnamecallmethod()
local class = self.ClassName
if (class == "RemoteEvent" and method == "FireServer") or
(class == "RemoteFunction" and method == "InvokeServer") or
(class == "BindableEvent" and method == "Fire") or
(class == "BindableFunction" and method == "Invoke") or
(class == "UnstableRemoteEvent" and method == "FireServer") then
return nil
end
return old(self,...)
end)
else 
mt.__namecall = old
end
setreadonly(mt,true)
end)

for _, v in ipairs(game:GetDescendants()) do
if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") or v:IsA("UnstableRemoteEvent") or v:IsA("BindableEvent") or v:IsA("BindableFunction") then
table.insert(_Remotes,v.Name)
table.insert(__Remotes,v)
end
end

Remotes:Dropdown("What Remote Do You Want Fired",_Remotes,function(x)
local ndx = table.find(_Remotes,x)
getgenv().SelectRemote = __Remotes[ndx]
end)

Remotes:Button("Fire This Remote",function()
if getgenv().SelectRemote then
local method = getgenv().RemoteFireMethod
if not method then discord:Notification("Failed","Select Remote Arguments","Okay!") return end

if method == "No Arguments/Blank" then 
___FireRemotes(getgenv().SelectRemote,"")

elseif method == "LocalPlayer" then 
___FireRemotes(getgenv().SelectRemote,game.Players.LocalPlayer)

elseif method == "Your Username" then 
___FireRemotes(getgenv().SelectRemote,tostring(game.Players.LocalPlayer))

elseif method == "Your UserId" then 
___FireRemotes(getgenv().SelectRemote,game.Players.LocalPlayer.UserId)

elseif method == "UGC Item ID" then
___FireRemotes(getgenv().SelectRemote,getgenv().UgcId)

elseif method == "UGC Item ID, LocalPlayer" then
___FireRemotes(getgenv().SelectRemote,getgenv().UgcId,game.Players.LocalPlayer)

elseif method == "LocalPlayer, UGC Item ID" then
___FireRemotes(getgenv().SelectRemote,game.Players.LocalPlayer,getgenv().UgcId)

elseif method == "'UGC' as a string" then 
___FireRemotes(getgenv().SelectRemote,"UGC")

elseif method == "'PromptPurchase' as a string, UGC Item Id" then 
___FireRemotes(getgenv().SelectRemote,"PromptPurchase",getgenv().UgcId)

elseif method == "'PromptAssetPurchase' as a string, UGC Item Id" then 
___FireRemotes(getgenv().SelectRemote,"PromptAssetPurchase",getgenv().UgcId)

elseif method == "UGC Item ID, 'true' boolean" then
___FireRemotes(getgenv().SelectRemote,getgenv().UgcId,true)

elseif method == "UGC Item ID, 'false' boolean" then
___FireRemotes(getgenv().SelectRemote,getgenv().UgcId,false)

elseif method == "UGC Item ID, Your UserId" then
___FireRemotes(getgenv().SelectRemote,getgenv().UgcId,game.Players.LocalPlayer.UserId)

elseif method == "'true' boolean" then 
___FireRemotes(getgenv().SelectRemote,true)

elseif method == "'false' boolean" then 
___FireRemotes(getgenv().SelectRemote,false)

elseif method == "literal lua code to prompt item" then
___FireRemotes(getgenv().SelectRemote,'game:GetService("MarketplaceService"):PromptPurchase(game.Players.'..LocalName..','..getgenv().UgcId..')')

elseif method == "UGC Item ID, 0" then
___FireRemotes(getgenv().SelectRemote,getgenv().UgcId,0)

elseif method == "UGC Item Id, negative value" then
___FireRemotes(getgenv().SelectRemote,getgenv().UgcId,-9999999999999999)

elseif method == "Positive value" then
___FireRemotes(getgenv().SelectRemote,9999999999999999)

elseif method == "Negative value" then
___FireRemotes(getgenv().SelectRemote,-9999999999999999)

elseif method == "loadstring prompt item" then 
___FireRemotes(getgenv().SelectRemote,"loadstring('game:GetService(\"MarketplaceService\"):PromptPurchase(game.Players."..LocalName..","..getgenv().UgcId..")')()")

elseif method == "Bulk Purchase Function 1, (Ugc Item Id)" then
__FireRemotes(getgenv().SelectRemote,{[1] = {[1] = {Id = tostring(getgenv().UgcId),Type = Enum.MarketplaceProductType.AvatarAsset}},[2] = {} })

elseif method == "Bulk Purchase Function 2, (Ugc Item Id, nil)" then
__FireRemotes(getgenv().SelectRemote,{[1] = {[1] = {Id = getgenv().UgcId,Type = Enum.MarketplaceProductType.AvatarAsset}},[2] = {Id = nil,Type = Enum.MarketplaceProductType.AvatarAsset},[3] = {Id = nil,Type = Enum.MarketplaceProductType.AvatarAsset} })

elseif method == "Bulk Purchase Function 3, (UGC Item Id, Fake Ids)" then 
__FireRemotes(getgenv().SelectRemote,{[1] = {[1] = {Id = getgenv().UgcId,Type = Enum.MarketplaceProductType.AvatarAsset}},[2] = {Id = 137525346725198,Type = Enum.MarketplaceProductType.AvatarAsset},[3] = {Id = 77554705161930,Type = Enum.MarketplaceProductType.AvatarAsset} })
else 
discord:Notification("Failed","Celect Remote","Okay!")
end
end
end)

Remotes:Button("Print All Remotes (Includes Path)",function()
for i, v in ipairs(game:GetDescendants()) do
if v:IsA("RemoteEvent") then
print(i.." — RemoteEvent "..v:GetFullName())
elseif v:IsA("RemoteFunction") then
print(i.." — RemoteFunction "..v:GetFullName())
elseif v:IsA("UnreliableRemoteEvent ") then
print(i.." — UnreliableRemoteEvent "..v:GetFullName())
elseif v:IsA("BindableEvent") then
print(i.." — BindableEvent "..v:GetFullName())
elseif v:IsA("BindableFunction") then
print(i.." — BindableFunction "..v:GetFullName())
end
end
VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F9, false, nil)
task.wait(0.01)
VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F9, false, nil)
end)

Remotes:Button("Show Number Remotes",function()
if not getgenv().EnableNumber then
getgenv().EnableNumber = true
Number1 = 0
Number2 = 0
Number3 = 0
Number4 = 0
Number5 = 0
Number6 = 0
for _, v in ipairs(game:GetDescendants()) do
if v:IsA("RemoteEvent") then Number1 = Number1 + 1
elseif v:IsA("RemoteFunction") then Number2 = Number2 + 1
elseif v:IsA("UnreliableRemoteEvent") then Number3 = Number3 + 1
elseif v:IsA("BindableEvent") then Number4 = Number4 + 1
elseif v:IsA("BindableFunction") then Number5 = Number5 + 1
end
end
Number6 = Number1 + Number2 + Number3 + Number4 + Number5
Remotes:Label("There are "..Number1.." RemoteEvents in this game")
Remotes:Label("There are "..Number2.." RemoteFunctions in this game")
Remotes:Label("There are "..Number3.." UnreliableRemoteEvent in this game")
Remotes:Label("There are "..Number4.." BindableEvent in this game")
Remotes:Label("There are "..Number5.." BindableFunction in this game")
Remotes:Label("There are "..Number6.." Remotes in this game")
discord:Notification("Success","Remotes Counted!","Okay!")
else
discord:Notification("Failed","Remotes Already Counted!","Okay!")
end 
end)
end

if SettingsWevorn["Games"] then
local Games = serv:Channel("Games")


Games:Toggle("Anti Kick on Teleport",false,function(state)
local mt = getrawmetatable(game)
setreadonly(mt,false)
if state then
if old_namecall == nil then
old_namecall = mt.__namecall
end
mt.__namecall = newcclosure(function(self,...)
local method = getnamecallmethod()
if self.ClassName == "TeleportService" and (method == "Teleport" or method == "TeleportToPlaceInstance") then
return nil
end
return old_namecall(self,...)
end)
else
if old_namecall then
mt.__namecall = old_namecall
end
end

setreadonly(mt,true)
end)

getgenv().GamesMethod = "Teleport"

Games:Dropdown("What to do with Subplace",{
          "Teleport",
          "Copy Script",
          "Copy Script and Teleport",
          "Copy Game Link",
          "Copy Subplace Id",
          "Copy Place Name"
          },function(x)
          getgenv().GamesMethod = x
end)

Games:Label("\nBelow is a list of subplaces of this game.\nChoose the one that you want to be teleported into!")

pcall(function()
pp = AssetService:GetGamePlacesAsync() 
end)

while true do
for _, v in ipairs(pp:GetCurrentPage()) do
table.insert(Places,v.Name)
table.insert(PlaceIds,v.PlaceId)
end
if pp.IsFinished then break end
pp:AdvanceToNextPageAsync() 
end
local Select 
Games:Dropdown("Subplaces/Hidden Games List",Places,function(x)
local index = nil
Select = x
for i, v in ipairs(Places) do
if v == x then
index = i 
break
end
end

local function TeleportNotification()
discord:Notification("Teleporting","Teleporting to...\n" .. x .. "\nGame ID: " .. _PlaceId,"Okay!")
end

if index then
_PlaceId = PlaceIds[index]

if getgenv().GamesMethod == "Teleport" then
TeleportNotification()
TeleportService:Teleport(_PlaceId,Players.LocalPlayer)
elseif getgenv().GamesMethod == "Copy Script" then 
setclipboard('game:GetService("TeleportService"):Teleport('.._PlaceId..',game.Players.LocalPlayer)')
elseif getgenv().GamesMethod == "Copy Script and Teleport" then
setclipboard('game:GetService("TeleportService"):Teleport('.._PlaceId..',game.Players.LocalPlayer)')
TeleportNotification()
task.wait(0.3)
TeleportService:Teleport(_PlaceId,Players.LocalPlayer)
elseif getgenv().GamesMethod == "Copy Subplace Id" then 
setclipboard(_PlaceId)
elseif getgenv().GamesMethod == "Copy Game Link"  then
setclipboard("http://roblox.com/games/"..tostring(_PlaceId))
elseif getgenv().GamesMethod == "Copy Place Name" then
setclipboard(tostring(Select))
end
end
end)

Games:Label("If you only see the main game, no other subplaces found.")
Games:Seperator()

Games:Textbox("Pause gameplay for a specified amount of time.","How long do you want to pause the game for? (In seconds)", true,function(x)
local time = tonumber(x)
if time then 
Players.LocalPlayer.GameplayPaused = true
task.wait(time)
Players.LocalPlayer.GameplayPaused = false
else
discord:Notification("Error", "You must enter a number. (In seconds)", "Okay!")
end
end)

Games:Label("Pausing the gameplay will overlay everything,\nEvery UI becomes unclickable.")
Games:Seperator()

Games:Toggle("Force Full Bright Lighting",false,function(state)
if state then 
Light1 = Lighting.Brightness
Light2 = Lighting.ClockTime
Light3 = Lighting.FogEnd
Light4 = Lighting.GlobalShadows
Light5 = Lighting.OutdoorAmbient

Lighting.Brightness = 2
Lighting.ClockTime = 14
Lighting.FogEnd = 100000
Lighting.GlobalShadows = false
Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
else
Lighting.Brightness = Light1
Lighting.ClockTime = Light2
Lighting.FogEnd = Light3
Lighting.GlobalShadows = Light4
Lighting.OutdoorAmbient = Light5
end
end)

Games:Button("Teleport  To Smaller Server", function(x)
local api = "https://games.roblox.com/v1/games/"
local server = api .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"

function list(cs)
local url = server
if cs then url = url .. "&cursor=" .. cs end
local Raw = game:HttpGet(url, true)
return HttpService:JSONDecode(Raw)
end

local _Server, Next
repeat
local Servers = list(Next)
if Servers.data and #Servers.data > 0 then
_Server = Servers.data[1]
end
Next = Servers.nextPageCursor
until _Server

if _Server then
discord:Notification("Teleporting", "Teleporting to...\n" .. PlaceId .. "\nJob ID: " .. _Server.id, "Okay!")
TeleportService:TeleportToPlaceInstance(PlaceId, _Server.id, game.Players.LocalPlayer)
else
discord:Notification("Teleport Eror", "Not Found  Server ", "Okay!")
end
end)

Games:Button("Teleport To Largest Server", function(x)
local api = "https://games.roblox.com/v1/games/"
local server = api .. PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"

function list(cs)
local url = server
if cs then url = url .. "&cursor=" .. cs end
local Raw = game:HttpGet(url, true)
return HttpService:JSONDecode(Raw)
end

local LargestServer, Next
repeat
local Servers = list(Next)
if Servers.data and #Servers.data > 0 then
for i, s in pairs(Servers.data) do
if s.maxPlayers - s.playing > 0 and (not LargestServer or s.playing > LargestServer.playing) then
LargestServer = s
end
end
end
Next = Servers.nextPageCursor
until not Next

if LargestServer then
discord:Notification("Teleporting", "Teleporting to...\n" .. PlaceId .. "\nJob ID: " .. LargestServer.id, "Okay!")
TeleportService:TeleportToPlaceInstance(PlaceId, LargestServer.id, game.Players.LocalPlayer)
else 
discord:Notification("Teleport Eror", "Not Found  Server ", "Okay!")
end
end)

Games:Button("Force  Close Roblox App",function()
game:Shutdown()
end)

Games:Label("Current Game's Place ID:\n" .. game.PlaceId)
Games:Label("Current Game's Universe ID:\n" .. game.GameId)
Games:Label("Current Game's Job ID: \n" .. game.JobId)

Games:Button("Copy Place Id",function()
setclipboard(game.PlaceId)
end)

Games:Button("Copy Universe Id",function()
setclipboard(game.GameId)
end)

Games:Button("Copy Job Id",function()
setclipboard(game.JobId)
end)
end

if SettingsWevorn["Players"] then
local players = serv:Channel("Players")

players:Label("\nUses SetLocalPlayerInfo() to change your info!")

players:Textbox("Spoof as player with User ID (Client)","Enter your new User ID...",false,function(pid)
local NewId = tonumber(pid)
if NewId then 
local name = Players:GetNameFromUserIdAsync(NewId)
discord:Notification("Success","You are now "..name.." ("..NewId..")","Okay!")
Players:SetLocalPlayerInfo(NewId,name,name,Enum.MembershipType.Premium,false)
else 
discord("Eror!","Enter a number!","Okay!")
end
end)

players:Button("Spoof yourself as the Game Owner",function()
local name = Players:GetNameFromUserIdAsync(tonumber(game.CreatorId))
discord:Notification("Success","You are now "..name.." ("..tostring(game.CreatorId)..")","Okay!")
Players:SetLocalPlayerInfo(game.CreatorId,name,name,Enum.MembershipType.Premium,false)
end)

players:Seperator()

spawn(function()
while task.wait(0.1) do
for _, v in pairs(game.Players:GetPlayers()) do
if v ~= player and v.Character then
if getgenv().AutoHidePlayers then
if not HidePlayers[v] then
HidePlayers[v] = v.Character.Parent
end
v.Character.Parent = nil
else
if HidePlayers[v] and v.Character.Parent == nil then
v.Character.Parent = HidePlayers[v]
end
end
end
end
end
end)

players:Toggle("Auto Hide Other Players", false, function(state)
getgenv().AutoHidePlayers = state
end)

local GuiToggle = {}
players:Toggle("Show Hidden GUIs of LocalPlayer",false,function(state)
if state then
GuiToggle = {}
for _, v in ipairs(player.PlayerGui:GetDescendants()) do
if (v:IsA("Frame") or v:IsA("TextButton") or v:IsA("ImageButton") or v:IsA("ScrollingFrame")) and not v.Visible then
v.Visible = true
table.insert(GuiToggle,v)
end
end
else 
for _, v in pairs(GuiToggle) do
v.Visible = false
end
GuiToggle = {}
end
end)

players:Toggle("Anti AFK",false,function(state)
if state then
Conn_1 = Players.LocalPlayer.Idled:Connect(function() 
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)
else
Conn_1:Disconnect()
end
end)

players:Seperator()
players:Button("Create Waypoint at Current Position",function()
if getgenv().Ticket then if not player.Character:FindFirstChild("HumanoidRootPart")  then discord:Notification("Error","HumanoidRootPart  is not found","Okay!") return end getgenv().HumPosition = player.Character.HumanoidRootPart.Position discord:Notification("Success","Create Waypoint as "..tostring(getgenv().HumPosition),"Okay!") return end
if not player.Character:FindFirstChild("HumanoidRootPart")  then discord:Notification("Error","HumanoidRootPart  is not found","Okay!") return end
getgenv().HumPosition = player.Character.HumanoidRootPart.Position 
discord:Notification("Success","Create Waypoint as "..tostring(getgenv().HumPosition),"Okay!")
players:Button("Teleport to Seved Waypoint",function() if getgenv().HumPosition then game.Players.LocalPlayer.Character:PivotTo(CFrame.new(getgenv().HumPosition)) else discord:Notification("Eror","No Waypoint  Found!","Okay") end end)
players:Button("Clear Waypoint",function() getgenv().HumPosition = false discord:Notification("Success","Waypoint  is cleared","Okay!") end)
players:Button("Copy Waypoint Position",function() if not getgenv().HumPosition then discord("Error","No Waypoint found","Okay!") return end setclipboard(tostring(getgenv().HumPosition)) end)
getgenv().Ticket = true
end)

end

if SettingsWevorn["Network"] then
local Network = serv:Channel("Network")
Network:Label("\nThis can bypass rate limits when firing remotes!")

Network:Textbox("KBPS Limit ","Type a big number to have no limit...",true ,function(limit1) 
local limit2 = tonumber(limit1)
if limit2 then 
NetworkClient:SetOutgoingKBPSLimit(limit2)
discord:Notification("Success!","KBPS Limit has been set to "..tostring(limit2), "Okay!")
else
discord:Notification("Hold up!","KBPS Limit must be a number.","Okay!")
end
end)

Network:Seperator()
Network:Label("Simulates lag/delay from client -> server.")

Network:Dropdown("Delay Intensiveness",{
	            "Normal",
	            "Mild",
	            "Medium",
	            "Severe",
	            "Hard",
	            "Very Hard", 
	            "Mega Hard",
	            "No Connection"
	             },function(Level)
	            getgenv().LevelConnect = Level
end)

Network:Button("Apply Settings",function()
if getgenv().LevelConnect then

if getgenv().LevelConnect == "Normal" then
NetworkSettings.IncomingReplicationLag = 0
elseif getgenv().LevelConnect == "Mild" then 
NetworkSettings.IncomingReplicationLag = 1
elseif getgenv().LevelConnect == "Medium" then
NetworkSettings.IncomingReplicationLag = 2
elseif getgenv().LevelConnect == "Severe" then
NetworkSettings.IncomingReplicationLag = 3
elseif getgenv().LevelConnect == "Hard" then 
NetworkSettings.IncomingReplicationLag = 5
elseif getgenv().LevelConnect == "Very Hard" then
NetworkSettings.IncomingReplicationLag = 7
elseif getgenv().LevelConnect == "Mega Hard" then
NetworkSettings.IncomingReplicationLag = 9
elseif getgenv().LevelConnect == "No Connection" then
NetworkSettings.IncomingReplicationLag = 10
end
discord:Notification("Success!","Success Settings Applied","Okay!")
else
discord:Notification("Eror","Select Connection Level","Okay!")
end
end)

Network:Seperator()

Network:Button("Show Average Client -> Server Ping",function()
discord:Notification("Average Ping",math.round(Players.LocalPlayer:GetNetworkPing() * 1000).."ms","Okay!")
end)
end

if SettingsWevorn["Input Automations"] then
local InputAutomations = serv:Channel("Input Automations")

InputAutomations:Toggle("Auto Use Tools in Inventory",false,function(state)
getgenv().UseTools = state
spawn(function()
while getgenv().UseTools and task.wait() do
local char = game.Players.LocalPlayer.Character  
if not char then continue end
local tool = char:FindFirstChildWhichIsA("Tool")
if tool and tool:FindFirstChild("Handle") then
tool:Activate()
end
end
end)
end)

InputAutomations:Toggle("Auto Grab All Dropped Tools",false,function(state)
if state then
for i, v in pairs(workspace:GetChildren()) do
if Players.LocalPlayer.Character:FindFirstChild("Humanoid") and v:IsA("BackpackItem") and v:FindFirstChild("Handle") then
Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):EquipTool(v)
end
end
if getgenv().connected then
getgenv().connected:Disconnect()
end
getgenv().connected = workspace.ChildAdded:Connect(function(child)
if Players.LocalPlayer.Character:FindFirstChild("Humanoid") and child:IsA("BackpackItem") and child:FindFirstChild("Handle") then 
Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):EquipTool(child)
end
end)
elseif not bool then
if getgenv().connected then
getgenv().connected:Disconnect()
end
end 
end)

InputAutomations:Toggle("Infinite ProximityPrompt Range",false,function(state)
if state then
Prompt1 = ProximityPromptService.MaxPromptsVisible
ProximityPromptService.MaxPromptsVisible = math.huge
for _, v in ipairs(workspace:GetChildren()) do
if v:IsA("ProximityPrompt") then
v.MaxActivationDistance = math.huge
end
end
else
ProximityPromptService.MaxPromptsVisible = Prompt1
for _, v in ipairs(workspace:GetChildren()) do
if v:IsA("ProximityPrompt") then
v.MaxActivationDistance = 10
end
end
end
end)

InputAutomations:Toggle("Instant ProximityPrompt",false,function(state)
if state then 
Prompt2 = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
pcall(function()
fireproximityprompt(prompt)
end)
end)
else
Prompt2:Disconnect()
end
end)

InputAutomations:Button("Equip All Tools",function()
for _, v in ipairs(Players.LocalPlayer.Backpack:GetChildren()) do
if v:IsA("Tool") then
v.Parent = Players.LocalPlayer.Character
end
end
end)

InputAutomations:Button("Force Drop Tool",function()
for _, v in ipairs(Players.LocalPlayer.Backpack:GetChildren()) do
if v:IsA("Tool") then
v.Parent = workspace
end
end
end)

InputAutomations:Seperator()

InputAutomations:Button("Fire All ProximityPrompt",function()
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("ProximityPrompt") then
fireproximityprompt(v)
end
end
end)

InputAutomations:Button("Fire All ClickDetectors",function()
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("ClickDetector") then
fireclickdetector(v)
end
end
end)

InputAutomations:Button("Fire All TouchInterest",function()
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("TouchTransmitter") then
v:Firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Parent,1)
v:Firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Parent,0)
if v.Parent:IsA("BasePart") then v.Parent.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
elseif v.Parent:IsA("Model") and v.Parent.PrimaryPart then v.Parent:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame) end
end
end
end)

InputAutomations:Toggle("Loop Fire All ProximityPrompts",false,function(state)
getgenv().LoopFireAllProximityPrompt = state
while getgenv().LoopFireAllProximityPrompt and task.wait() do
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("ProximityPrompt") then
fireproximityprompt(v)
end
end
end
end)

InputAutomations:Toggle("Loop Fire All ClickDetectors",false,function(state)
getgenv().LoopFireAllClickDetector = state
while getgenv().LoopFireAllClickDetector and task.wait() do
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("ClickDetector") then
fireclickdetector(v)
end
end
end
end)

InputAutomations:Toggle("Loop Fire All TouchInterest",false,function(state)
getgenv().LoopFireAllTouchInterest = state

while getgenv().LoopFireAllTouchInterest and task.wait() do
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("TouchTransmitter") then
v:Firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Parent,1)
v:Firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Parent,0)
if v.Parent:IsA("BasePart") then v.Parent.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
elseif v.Parent:IsA("Model") and v.Parent.PrimaryPart then v.Parent:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame) end
end
end
end
end)
end

if SettingsWevorn["Purchase Exploits"] then
local PurchaseExploits = serv:Channel("Purchase Exploits")

PurchaseExploits:Label("Fake Purchaser!\nThis tricks server that you bought a Game Pass!")
PurchaseExploits:Label("Only works in some games...")

pcall(function()
GamePassLink = HttpService:JSONDecode(game:HttpGet("https://apis.roblox.com/game-passes/v1/universes/"..game.GameId.."/game-passes?passView=Full&pageSize=500"))
end)

if GamePassLink then
pcall(function()
for _, v in ipairs(GamePassLink.gamePasses) do
table.insert(GamePassNames,v.name)
table.insert(GamePassIds,v.id)
end
end)
end

PurchaseExploits:Dropdown("Below is a list of all Game Passes  in this game!",GamePassNames,function(SelectedGamePass)
for i, v in ipairs(GamePassNames) do
if v == SelectedGamePass then
GamePass = GamePassIds[i]
end
end
end)

PurchaseExploits:Label("If nothing shows above, no GamePass found.")

PurchaseExploits:Button("Fire Selected Gamepass",function()
if GamePass then
pcall(function()
MarketplaceService:SignalPromptGamePassPurchaseFinished(game.Players.LocalPlayer,tostring(GamePass),true)
discord:Notification("Success","Fired PromptProductGamePassPurchaseFinished signal to server with Id: "..tostring(GamePass),"Okay!")
end)
end
end)

PurchaseExploits:Toggle("Loop Fire Selected  Game Pass",false,function(state)
getgenv().LoopFireGamePass = state 
while getgenv().LoopFireGamePass and task.wait() do
if GamePass then
MarketplaceService:SignalPromptGamePassPurchaseFinished(game.Players.LocalPlayer,tostring(GamePass),true)
end
end
end)

PurchaseExploits:Label("Pretty much the same as the one above but for Dev Products")

pcall(function()
DevProductLink = HttpService:JSONDecode(game:HttpGet("https://apis.roblox.com/developer-products/v2/universes/"..game.GameId.."/developerproducts?limit=30000"))
end)

if DevProductLink then
pcall(function()
for i, v in ipairs(DevProductLink.developerProducts) do
table.insert(DevProductsNames,v.Name)
table.insert(DevProductsIds,v.ProductId)
end
end)
end

PurchaseExploits:Dropdown("Below is a list of all Dev Products in this game!",DevProductsNames,function(SelectedDevProduct)
for i, v in ipairs(DevProductsNames) do
if v == SelectedDevProduct then
DevProduct = DevProductsIds[i]
end
end
end)

PurchaseExploits:Label("If nothing shows above, no Dev Products  found.")

PurchaseExploits:Button("Fire Selected Dev Product",function()
if DevProduct then
pcall(function()
MarketplaceService:SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId,tostring(DevProduct),true)
discord:Notification("Success","Fired SignalPromptProductPurchaseFinished signal to server with ProductId: "..tostring(DevProduct),"Okay!")
end)
end
end)

PurchaseExploits:Toggle("Loop Fire Selected  Dev Product",false,function(state)
getgenv().LoopFireDevProduct = state
while getgenv().LoopFireDevProduct and task.wait() do
if DevProduct then
MarketplaceService:SignalPromptProductPurchaseFinished(game.Players.LocalPlayer.UserId,tostring(DevProduct),true)
end
end
end)
end

if SettingsWevorn["Purchase Signals"] then
local PurchaseSignals = serv:Channel("Purchase Signals")
PurchaseSignals:Label("Released in Wevorn v1.2")
end

for _, v in ipairs(game:GetDescendants()) do
if v.Name == "__function" then
discord:Notification("Adonis Anti Cheat Found!","You can check !BuyItem and !BuyAsset","Okay!")
end
end
local TimeLoaded = tick() - LoadTime
if SettingsWevorn["Home"] then
Home:Label("Wevorn is loaded in "..TimeLoaded.."s")
else
Home:Label("Eror Loaded Wevorn, Check console")
Home:Button("Open Console",function()
VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F9, false, nil)
task.wait(0.01)
VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F9, false, nil)
end)
end
