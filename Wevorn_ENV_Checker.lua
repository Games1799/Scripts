--[[
░██████╗░░█████╗░███╗░░░███╗███████╗░██████╗
██╔════╝░██╔══██╗████╗░████║██╔════╝██╔════╝
██║░░██╗░███████║██╔████╔██║█████╗░░╚█████╗░
██║░░╚██╗██╔══██║██║╚██╔╝██║██╔══╝░░░╚═══██╗
╚██████╔╝██║░░██║██║░╚═╝░██║███████╗██████╔╝
 ░╚═════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝╚═════╝░
]]-- Wevorn ENV Checker V1
-- https://discord.gg/pcjAQpa2H

if type(workspace) ~= "userdata" then while true do end end
if type(game) ~= "userdata" then while true do end end
if typeof(workspace) ~= "Instance" then while true do end end
if typeof(game) ~= "Instance" then while true do end end
if type(game.Parent) ~= "nil" then while true do end end
if typeof(game.Parent) ~= "nil" then while true do end end
if type(true) ~= "boolean" then while true do end end
if typeof(true) ~= "boolean" then while true do end end
if type(false) ~= "boolean" then while true do end end
if typeof(false) ~= "boolean" then while true do end end
if type(nil) ~= "nil" then while true do end end
if typeof(nil) ~= "nil" then while true do end end
if type(table) ~= "table" then while true do end end
if typeof(table) ~= "table" then while true do end end
if type({}) ~= "table" then while true do end end
if typeof({}) ~= "table" then while true do end end
if type(math) ~= "table" then while true do end end
if typeof(math) ~= "table" then while true do end end
if type(string) ~= "table" then while true do end end
if typeof(string) ~= "table" then while true do end end
if type(os) ~= "table" then while true do end end
if typeof(os) ~= "table" then while true do end end
if type(coroutine) ~= "table" then while true do end end
if typeof(coroutine) ~= "table" then while true do end end
if type(utf8) ~= "table" then while true do end end
if typeof(utf8) ~= "table" then while true do end end
if type(bit32) ~= "table" then while true do end end
if typeof(bit32) ~= "table" then while true do end end
if type(debug) ~= "table" then while true do end end
if typeof(debug) ~= "table" then while true do end end
if type(task) ~= "table" then while true do end end
if typeof(task) ~= "table" then while true do end end
if type(buffer) ~= "table" then while true do end end
if typeof(buffer) ~= "table" then while true do end end
if type(_G) ~= "table" then while true do end end
if typeof(_G) ~= "table" then while true do end end
if type(shared) ~= "table" then while true do end end
if typeof(shared) ~= "table" then while true do end end
if type(script) ~= "userdata" then while true do end end
if typeof(script) ~= "Instance" then while true do end end
if type(CFrame) ~= "table" then while true do end end
if typeof(CFrame) ~= "table" then while true do end end
if type(Vector2) ~= "table" then while true do end end
if typeof(Vector2) ~= "table" then while true do end end
if type(Vector3) ~= "table" then while true do end end
if typeof(Vector3) ~= "table" then while true do end end
if type(UDim) ~= "table" then while true do end end
if typeof(UDim) ~= "table" then while true do end end
if type(UDim2) ~= "table" then while true do end end
if typeof(UDim2) ~= "table" then while true do end end
if type(Color3) ~= "table" then while true do end end
if typeof(Color3) ~= "table" then while true do end end
if type(BrickColor) ~= "table" then while true do end end
if typeof(BrickColor) ~= "table" then while true do end end
if type(Ray) ~= "table" then while true do end end
if typeof(Ray) ~= "table" then while true do end end
if type(Region3) ~= "table" then while true do end end
if typeof(Region3) ~= "table" then while true do end end
if type(Region3int16) ~= "table" then while true do end end
if typeof(Region3int16) ~= "table" then while true do end end
if type(Rect) ~= "table" then while true do end end
if typeof(Rect) ~= "table" then while true do end end
if type(NumberRange) ~= "table" then while true do end end
if typeof(NumberRange) ~= "table" then while true do end end
if type(NumberSequence) ~= "table" then while true do end end
if typeof(NumberSequence) ~= "table" then while true do end end
if type(ColorSequence) ~= "table" then while true do end end
if typeof(ColorSequence) ~= "table" then while true do end end
if type(PhysicalProperties) ~= "table" then while true do end end
if typeof(PhysicalProperties) ~= "table" then while true do end end
if type(TweenInfo) ~= "table" then while true do end end
if typeof(TweenInfo) ~= "table" then while true do end end
if type(DateTime) ~= "table" then while true do end end
if typeof(DateTime) ~= "table" then while true do end end
if type(Random) ~= "table" then while true do end end
if typeof(Random) ~= "table" then while true do end end
if type(OverlapParams) ~= "table" then while true do end end
if typeof(OverlapParams) ~= "table" then while true do end end
if type(RaycastParams) ~= "table" then while true do end end
if typeof(RaycastParams) ~= "table" then while true do end end
if type(math.random(1, 99999)) ~= "number" then while true do end end
if typeof(math.random(1, 99999)) ~= "number" then while true do end end
if type(string.char(math.random(1, 255))) ~= "string" then while true do end end
if typeof(string.char(math.random(1, 255))) ~= "string" then while true do end end
if typeof(coroutine.create(function() end)) ~= "thread" then while true do end end
if typeof(Vector3.new()) ~= "Vector3" then while true do end end
if typeof(Vector2.new()) ~= "Vector2" then while true do end end
if typeof(CFrame.new()) ~= "CFrame" then while true do end end
if typeof(UDim.new(0, 0)) ~= "UDim" then while true do end end
if typeof(UDim2.new()) ~= "UDim2" then while true do end end
if typeof(Color3.new()) ~= "Color3" then while true do end end
if typeof(BrickColor.new()) ~= "BrickColor" then while true do end end
if typeof(Ray.new(Vector3.zero, Vector3.zero)) ~= "Ray" then while true do end end
if typeof(Region3.new(Vector3.zero, Vector3.one)) ~= "Region3" then while true do end end
if typeof(Region3int16.new()) ~= "Region3int16" then while true do end end
if typeof(Rect.new()) ~= "Rect" then while true do end end
if typeof(NumberRange.new(0)) ~= "NumberRange" then while true do end end
if typeof(NumberSequence.new(0)) ~= "NumberSequence" then while true do end end
if typeof(ColorSequence.new(Color3.new())) ~= "ColorSequence" then while true do end end
if typeof(PhysicalProperties.new(1, 1, 1)) ~= "PhysicalProperties" then while true do end end
if typeof(TweenInfo.new(1)) ~= "TweenInfo" then while true do end end
if typeof(DateTime.now()) ~= "DateTime" then while true do end end
if typeof(Random.new()) ~= "Random" then while true do end end
if typeof(OverlapParams.new()) ~= "OverlapParams" then while true do end end
if typeof(RaycastParams.new()) ~= "RaycastParams" then while true do end end

local MathTable = {"abs", "acos", "asin", "atan", "atan2", "ceil", "clamp", "cos", "cosh", "deg", "exp", "floor", "fmod", "frexp", "isfinite", "isinf", "isnan", "ldexp", "lerp", "log", "log10", "map", "max", "min", "modf", "noise", "pow", "rad", "random", "randomseed", "round", "sign", "sin", "sinh", "sqrt", "tan", "tanh"}
for _, v in pairs(MathTable) do
   if not math[v] or type(math[v]) ~= "function" or typeof(math[v]) ~= "function" then
      while true do end
   end
end

local StringTable = {"byte", "char", "find", "format", "gmatch", "gsub", "len", "lower", "match", "rep", "reverse", "split", "sub", "upper"}
for _, v in pairs(StringTable) do
   if not string[v] or type(string[v]) ~= "function" or typeof(string[v]) ~= "function" then
      while true do end
   end
end

local OsTable = {"clock", "date", "difftime", "time"}
for _, v in pairs(OsTable) do
   if not os[v] or type(os[v]) ~= "function" or typeof(os[v]) ~= "function" then
      while true do end
   end
end

local TaskTable = {"cancel", "defer", "delay", "desynchronize", "spawn", "synchronize", "wait"}
for _, v in pairs(TaskTable) do
   if not task[v] or type(task[v]) ~= "function" or typeof(task[v]) ~= "function" then
      while true do end
   end
end

local DebugTable = {"info", "profilebegin", "profileend", "resetmemorycategory", "setmemorycategory", "traceback"}
for _, v in pairs(DebugTable) do
   if not debug[v] or type(debug[v]) ~= "function" or typeof(debug[v]) ~= "function" then
      while true do end
   end
end

local Bit32Table = {"arshift", "band", "bnot", "bor", "btest", "bxor", "extract", "lrotate", "lshift", "replace", "rrotate", "rshift"}
for _, v in pairs(Bit32Table) do
   if not bit32[v] or type(bit32[v]) ~= "function" or typeof(bit32[v]) ~= "function" then
      while true do end
   end
end

local CoroutineTable = {"close", "create", "isyieldable", "resume", "running", "status", "wrap", "yield"}
for _, v in pairs(CoroutineTable) do
   if not coroutine[v] or type(coroutine[v]) ~= "function" or typeof(coroutine[v]) ~= "function" then
      while true do end
   end
end

local BufferTable = {"copy", "create", "fill", "fromstring", "len", "readbits", "readf32", "readf64", "readi8", "readi16", "readi32", "readu8", "readu16", "readu32", "readstring", "tostring", "writebits", "writef32", "writef64", "writei8", "writei16", "writei32", "writeu8", "writeu16", "writeu32", "writestring"}
for _, v in pairs(BufferTable) do
   if not buffer[v] or type(buffer[v]) ~= "function" or typeof(buffer[v]) ~= "function" then
      while true do end
   end
end

local Utf8Table = {"char", "codepoint", "codes", "graphemes", "len", "nfdnormalize", "nfcnormalize", "offset"}
for _, v in pairs(Utf8Table) do
   if not utf8[v] or type(utf8[v]) ~= "function" or typeof(utf8[v]) ~= "function" then
      while true do end
   end
end

local MathProperties = {"pi", "huge", "e", "nan", "phi", "sqrt2", "tau"}
for _, v in pairs(MathProperties) do
   if not math[v] or type(math[v]) ~= "number" or typeof(math[v]) ~= "number" then
       while true do end
   end
end

local GlobalFunctionsTable = {"assert", "collectgarbage", "error", "gcinfo", "getfenv", "getmetatable", "ipairs", "loadstring", "newproxy", "next", "pairs", "pcall", "print", "rawequal", "rawget", "rawlen", "rawset", "require", "select", "setfenv", "setmetatable", "tonumber", "tostring", "type", "typeof", "unpack", "warn", "xpcall", "tick", "wait", "spawn", "delay"}
for _, v in pairs(GlobalFunctionsTable) do
   if type(getfenv()[v]) ~= "function" or typeof(getfenv()[v]) ~= "function" then 
     while true do end
   end 
end

local MarketplaceService = game:GetService("MarketplaceService")
if type(MarketplaceService) ~= "userdata" then while true do end end
if typeof(MarketplaceService) ~= "Instance" then while true do end end
local MarketplaceServiceTable = {"BindReceiptHandler", "ClearProductInfoCaches", "GetAvailableSubscriptionProductsAsync", "GetDeveloperProductsAsync", "GetProductInfo", "GetProductInfoAsync", "GetRobloxSubscriptionDetailsAsync", "GetRobuxBalance", "GetSubscriptionProductInfoAsync", "GetSubscriptionPurchaseInfoAsync", "GetUserSubscriptionDetailsAsync", "GetUserSubscriptionDetailsInternalAsync", "GetUserSubscriptionPaymentHistoryAsync", "GetUserSubscriptionStatusAsync", "GetUsersPriceLevelsAsync", "IsPurchaseSimulated", "OpenShop", "PerformBulkPurchase", "PerformCancelSubscription", "PerformPurchase", "PerformPurchaseV2", "PerformSubscriptionPurchase", "PerformSubscriptionPurchaseV2", "PerformSubscriptionPurchaseV3Async", "PerformSubscriptionPurchaseWithRobuxAsync", "PlayerCanMakePurchases", "PlayerOwnsAsset", "PlayerOwnsAssetAsync", "PlayerOwnsBundle", "PlayerOwnsBundleAsync", "PrepareCollectiblesPurchase", "PromptBulkPurchase", "PromptBundlePurchase", "PromptCancelSubscription", "PromptCollectiblesPurchase", "PromptGamePassPurchase", "PromptNativePurchase", "PromptNativePurchaseWithLocalPlayer", "PromptNativePurchaseWithLocalPlayerWithPaymentSessionId", "PromptNativePurchaseWithPaymentSessionId", "PromptPremiumPurchase", "PromptProductPurchase", "PromptPurchase", "PromptRobloxPurchase", "PromptRobloxSubscriptionPurchase", "PromptRobuxTransferAsync", "PromptSubscriptionPurchase", "PromptThirdPartyPurchase", "RankProductsAsync", "RecommendTopProductsAsync", "ReportAssetSale", "ReportRobuxUpsellStarted", "UserOwnsGamePassAsync"}
for _, v in pairs(MarketplaceServiceTable) do
    if not MarketplaceService[v] or type(MarketplaceService[v]) ~= "function" or typeof(MarketplaceService[v]) ~= "function" then
        while true do end
    end
end

local MarketplaceServiceSignals = {"PromptBulkPurchaseFinished", "PromptBundlePurchaseFinished", "PromptGamePassPurchaseFinished", "PromptPremiumPurchaseFinished", "PromptProductPurchaseFinished", "PromptPurchaseFinished", "PromptRobloxSubscriptionPurchaseFinished", "PromptSubscriptionPurchaseFinished", "RobuxTransferCompleted", "ThirdPartyPurchaseFinished", "UserSubscriptionStatusChanged", "MockConfirmUserSubscriptionPurchase", "ConfirmUserSubscriptionPurchase"}
for _, v in pairs(MarketplaceServiceSignals) do
    if not MarketplaceService[v] or type(MarketplaceService[v]) ~= "userdata" or typeof(MarketplaceService[v]) ~= "RBXScriptSignal" then
        while true do end
    end
end

local Fake = false
local cloneref = cloneref or clonereference or clone_ref or clonereference or (cache and cache.cloneref)
if not cloneref then
   Fake = true 
   cloneref = function(Closure)
      return Closure
   end
end
if type(cloneref) ~= "function" then while true do end end
if typeof(cloneref) ~= "function" then while true do end end
if not Fake then
   if workspace == cloneref(workspace) then
      while true do end
   end
end

local ServicesTable = {"AdService", "AssetService", "BadgeService", "Chat", "CollectionService", "ContentProvider", "ContextActionService", "DataStoreService", "Debris", "GroupService", "GuiService", "HttpService", "InsertService", "KeyframeSequenceProvider", "LocalizationService", "LogService", "MarketplaceService", "MemoryStoreService", "MessagingService", "PathfindingService", "PhysicsService", "Players", "PolicyService", "ProximityPromptService", "ReplicatedFirst", "ReplicatedStorage", "RunService", "ServerScriptService", "ServerStorage", "SoundService", "StarterGui", "StarterPack", "StarterPlayer", "Stats", "Teams", "TeleportService", "TextService", "TextChatService", "TweenService", "UserInputService", "UserService", "VoiceChatService", "Workspace"}
for _, v in pairs(ServicesTable) do
   local Service = cloneref(game:GetService(v))
   if type(Service) ~= "userdata" or typeof(Service) ~= "Instance" then 
       while true do end 
   end
end

local InstanceMethodsTable = {"AddTag", "children", "ClearAllChildren", "Clone", "clone", "Destroy", "destroy", "FindFirstAncestor", "FindFirstAncestorOfClass", "FindFirstAncestorWhichIsA", "FindFirstChild", "findFirstChild", "FindFirstChildOfClass", "FindFirstChildWhichIsA", "FindFirstDescendant", "GetActor", "GetAttribute", "GetAttributeChangedSignal", "GetAttributes", "GetChildren", "getChildren", "GetDebugId", "GetDescendants", "GetFullName", "GetStyled", "GetStyledPropertyChangedSignal", "GetTags", "HasTag", "IsAncestorOf", "IsDescendantOf", "isDescendantOf", "IsPropertyModified", "QueryDescendants", "Remove", "remove", "RemoveTag", "ResetPropertyToDefault", "SetAttribute", "WaitForChild"}
for _, v in pairs(InstanceMethodsTable) do
   if type(workspace[v]) ~= "function" or typeof(workspace[v]) ~= "function" then 
      while true do end 
   end
end

local sus, res = pcall(function()
   local VM = Instance.new("VirtualInputManager")
   if type(VM) ~= "userdata" then while true do end end
   if typeof(VM) ~= "Instance" then while true do end end
   local VMFUNC = {"Dump", "HandleGamepadAxisInput", "HandleGamepadButtonInput", "HandleGamepadConnect", "HandleGamepadDisconnect", "SendAccelerometerEvent", "SendGravityEvent", "SendGyroscopeEvent", "SendKeyEvent", "SendMouseButtonEvent", "SendMouseMoveDeltaEvent", "SendMouseMoveEvent", "SendMouseWheelEvent", "SendScroll", "SendTextInputCharacterEvent", "SendTouchEvent", "SetInputTypesToIgnore", "StartPlaying", "StartPlayingJSON", "StartRecording", "StopPlaying", "StopRecording", "WaitForInputEventsProcessed", "sendRobloxEvent", "sendThemeChangeEvent"}
   for _, v in pairs(VMFUNC) do
      if type(VM[v]) ~= "function" or typeof(VM[v]) ~= "function" then
        while true do end
      end
   end
   VM:Destroy()
end)
if not sus then
   while true do end
end

if not iscclosure then
   iscclosure = function(func)
      return debug.info(func, "s") == "[C]"
   end
end

local getrawmetatable = getrawmetatable or get_raw_metatable
if type(getrawmetatable) == "function" then
   local sus, res = pcall(function()
      return getrawmetatable(game)
   end)
   if not sus or not res then
      while true do end
   end
   local mt = res
   if not mt["__namecall"] then while true do end end
   if not mt["__index"] then while true do end end
   if not mt["__newindex"] then while true do end end
   if not mt["__tostring"] then while true do end end
   if not iscclosure(mt["__namecall"]) then while true do end end
   if not iscclosure(mt["__index"]) then while true do end end
   if not iscclosure(mt["__newindex"]) then while true do end end
   if not iscclosure(mt["__tostring"]) then while true do end end
   local old = mt.__namecall
   local sus, res = pcall(function()
      mt.__namecall = function(self, ...) return old(self, ...) end
      return res
   end)
   if sus and res then
      while true do end 
   end
end

local Vector3FunctionsTable = {"new", "FromNormalId", "FromAxis"}
for _, v in pairs(Vector3FunctionsTable) do
   if type(Vector3[v]) ~= "function" or typeof(Vector3[v]) ~= "function" then
      while true do end
   end
end

local v3 = Vector3.new()
local Vector3MethodsTable = {"Abs", "Ceil", "Floor", "Sign", "Cross", "Angle", "Dot", "FuzzyEq", "Lerp", "Max", "Min"}
for _, v in pairs(Vector3MethodsTable) do
   if type(v3[v]) ~= "function" or typeof(v3[v]) ~= "function" then
      while true do end
   end
end

local Vector3PropertiesTable = {"X", "Y", "Z", "Magnitude"}
for _, v in pairs(Vector3PropertiesTable) do
   if type(v3[v]) ~= "number" or typeof(v3[v]) ~= "number" then
      while true do end
   end
end

if typeof(v3.Unit) ~= "Vector3" then
   while true do end
end

local Vector2FunctionsTable = {"new"}
for _, v in pairs(Vector2FunctionsTable) do
    if type(Vector2[v]) ~= "function" or typeof(Vector2[v]) ~= "function" then
       while true do end
    end
end

local v2 = Vector2.new()
local Vector2MethodsTable = {"Abs", "Ceil", "Floor", "Sign", "Cross", "Angle", "Dot", "FuzzyEq", "Lerp", "Max", "Min"}
for _, v in pairs(Vector2MethodsTable) do
  if type(v2[v]) ~= "function" or typeof(v2[v]) ~= "function" then
     while true do end
  end
end

local Vector2PropertiesTable = {"X", "Y", "Magnitude"}
for _, v in pairs(Vector2PropertiesTable) do
  if type(v2[v]) ~= "number" or typeof(v2[v]) ~= "number" then
     while true do end
  end
end

if typeof(v2.Unit) ~= "Vector2" then
   while true do end
end

local Vector2ConstantsTable = {"zero", "one", "xAxis", "yAxis"}
for _, v in pairs(Vector2ConstantsTable) do
   if typeof(Vector2[v]) ~= "Vector2" then
      while true do end
   end
end

local Color3FunctionsTable = {"new", "fromRGB", "fromHSV", "fromHex", "toHSV"}
for _, v in pairs(Color3FunctionsTable) do
   if type(Color3[v]) ~= "function" or typeof(Color3[v]) ~= "function" then
      while true do end
   end
end

local c3 = Color3.new()
local Color3MethodsTable = {"Lerp", "ToHSV", "ToHex"}
for _, v in pairs(Color3MethodsTable) do
   if type(c3[v]) ~= "function" or typeof(c3[v]) ~= "function" then
      while true do end
   end
end

local Color3PropertiesTable = {"R", "G", "B"}
for _, v in pairs(Color3PropertiesTable) do
   if type(c3[v]) ~= "number" or typeof(c3[v]) ~= "number" then
      while true do end
   end
end

-- Your Script Here
