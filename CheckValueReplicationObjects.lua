local PrintServerNetworkOwner = true

local Players = cloneref(game:GetService("Players"))
local Player = cloneref(Players.LocalPlayer)

local mt = getrawmetatable(game)
local old = mt.__newindex
local tbl = {}
for _, v in ipairs(Player:GetDescendants()) do
   if v:IsA("ValueBase") then
      tbl[v] = true
   end
end

setreadonly(mt, false)
mt.__newindex = newcclosure(function(self, key, value)
   if tbl[self] and key == "Value" then
      tbl[self] = nil
      print("[Client Network Owner] " .. self:GetFullName())
   end
   return old(self, key, value)
end)

for v in pairs(tbl) do
   local Connection
   Connection = v:GetPropertyChangedSignal("Value"):Connect(function()
      if Connection then
         Connection:Disconnect()
      end
      if PrintServerNetworkOwner then
         print("[Server Network Owner]", v:GetFullName())
      end
   end)
end
