--!strict
local metamethods: table = {
   __index = true,
   __newindex = true,
   __call = true,
   __namecall = true,
   __tostring = true,
   __metatable = true,
   __mode = true,
   __len = true,
   __eq = true,
   __lt = true,
   __le = true,
   __concat = true,
   __unm = true,
   __add = true,
   __sub = true,
   __mul = true,
   __div = true,
   __idiv = true,
   __mod = true,
   __pow = true,
   __iter = true,
   __type = true,
}

type Closure = (...any) -> (...any)
if not isexecutorclosure then
   isexecutorclosure = function(func: Closure): boolean
      return false
   end
end
local tbl, tbl2 = {}, {}
local function checkmt(mt: table, name: string?): nil
   if tbl2[mt] then
      return
   end
   tbl2[mt] = true
   for i, v in pairs(mt) do
      if type(v) == "table" then
         if metamethods[i] then
            checkmt(v, name)
         else
            checkmt(v, name .. tostring(i) .. ".")
         end
      elseif type(v) == "function" and isexecutorclosure(v) then
         table.insert(tbl, name .. tostring(i))
      end
   end
   tbl2[mt] = nil
end
local function func(table2: table, name: string?): nil
   if tbl2[table2] then
      return
   end
   tbl2[table2] = true
   for i, v in pairs(table2) do
      if type(v) == "table" then
         func(v, name .. tostring(i) .. ".")
      elseif type(v) == "function" then
         table.insert(tbl, name .. tostring(i))
      end
   end
   if getrawmetatable then
      local mt = getrawmetatable(table2)
      if mt then
         checkmt(mt, name)
      end
   end
   tbl2[table2] = nil
end
func(getgenv(), "")
local Methods = {"HttpGet", "HttpGetAsync", "HttpPost", "HttpPostAsync"}
for _, v in pairs(Methods) do
   pcall(function()
      if game[v] and isexecutorclosure(game[v]) then
         table.insert(tbl, "game." .. tostring(v))
      end
   end)
end
task.defer(function()
   writefile("Functions.lua", table.concat(tbl, "\n"))
end)
