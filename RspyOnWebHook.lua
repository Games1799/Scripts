-- даже не знаю зачем я это создал...
-- RspyButOnWebHook v1.1
local httprequest = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local payload

local EnableColor = getgenv().EnableColor
if not EnableColor then getgenv().EnableColor = false end
local Color = getgenv().Color or 16711680

local Webhook = getgenv().Webhook 
if not Webhook then
StarterGui:SetCore("SendNotification",{
Title = "Snaiper error",
Text = "Ошибка — введите вебхук",
Duration = 3,
Button1 = "Ок"
})
return
end

local mt = getrawmetatable(game)
setreadonly(mt,false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self,...)
local method = getnamecallmethod()
local args = {...}
local class = self.ClassName
if (class == "RemoteEvent" and method == "FireServer") or
(class == "RemoteFunction" and method == "InvokeServer") or
(class == "BindableEvent" and method == "Fire") or
(class == "BindableFunction" and method == "Invoke") or
(class == "UnstableRemoteEvent" and method == "FireServer") then 
if EnableColor then
payload = HttpService:JSONEncode({embeds = {{title = "RspyOnWebHook",description = "Событие: "..class.."\nМетод: "..method.."\nАргументы: "..HttpService:JSONEncode(args),color = Color}}})
else
payload = HttpService:JSONEncode({content = "Событие: "..class.."\nМетод: "..method.."\nАргументы: "..HttpService:JSONEncode(args)})
end
pcall(function()
httprequest({Url = Webhook,Method = "POST",Headers = {["Content-Type"] = "application/json"},Body = payload})
end)
end
return old(self,...)
end)

StarterGui:SetCore("SendNotification",{Title = "Rspy started",Text = "Ремот спай успешно запущен ✅",Duration = 3,Button1 = "Ок"})
