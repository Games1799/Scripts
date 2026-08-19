-- Bypass VirtualInputManager detections v2 by @Games1799
local getrawmetatable = getrawmetatable or get_raw_metatable or nil
local setreadonly = ssetreadonly or set_read_only or nil
local getexecutorname = getexecutorname or get_executor_name or function()
   return "Unknown"
end
local newcclosure = newcclosure or new_c_closure or function(Closure)
   return Closure 
end
if string.find(getexecutorname():lower(), "eclipse") then
   newcclosure = function(Closure)
      return Closure
   end
end

local mt = getrawmetatable(game)
local old = mt.__namecall
local old2 = mt.__index
local old3 = mt.__tostring

setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
   local method = getnamecallmethod()
   local args = {...}
   if not checkcaller() then
      if self == game and method == "GetService" and args[1] == "VirtualInputManager" then
         return nil
      end
      if (method == "WaitForChild" or method == "FindFirstChild" or method == "FindFirstChildRecursive") and args[1] == "VirtualInputManager" then
         return nil
      end
   end
   local Res = old(self, ...)
   if typeof(Res) == "Instance" and Res.Name == "VirtualInputManager" and not checkcaller() then 
      return nil 
   end
   return Res
end)

mt.__index = newcclosure(function(self, key)
   if self == game and key == "VirtualInputManager" and not checkcaller() then 
      return nil 
   end
   local value = old2(self, key)
   if type(value) == "function" then
      return function(obj,...)
         local args = {...}
         if (key == "WaitForChild" or key == "FindFirstChild" or key == "FindFirstChildRecursive" or key == "FindFirstChildOfClass" or key == "FindFirstChildWhichIsA") and args[1] == "VirtualInputManager" and not checkcaller() then
            return nil
         end
         if key == "GetChildren" or key == "GetDescendants" then
            local tbl = value(obj,...)
            local out = {}
            for i = 1, #tbl do
               local v = tbl[i]
               if not (typeof(v) == "Instance" and v.Name == "VirtualInputManager") or checkcaller() then
                  out[#out + 1] = v
               end
            end
            return out
         end
         local Res = value(obj,...)
         if typeof(Res) == "Instance" and Res.Name == "VirtualInputManager" and not checkcaller() then
            return nil 
         end
         return Res
      end
   end
   local Res = value
   if typeof(Res) == "Instance" and Res.Name == "VirtualInputManager" and not checkcaller() then 
      return nil 
   end
   return Res
end)

mt.__tostring = newcclosure(function(self, ...)
  if typeof(self) == "Instance" and self.Name == "VirtualInputManager" and not checkcaller() then
     return "Instance"
  end
  return old3(self, ...)
end)

hookfunction(rawget, function(t, k)
   if a == game and b == "VirtualInputManager" and not checkcaller() then 
      return nil 
   end
   return rawget(a, b)
end)

hookfunction(rawequal, function(a, b)
   if not checkcaller() and ((typeof(a) == "Instance" and a.Name == "VirtualInputManager") or (typeof(b) == "Instance" and b.Name == "VirtualInputManager")) then 
      return false
   end
   return rawequal(a, b)
end)

-- local VirtualInputManager = game:GetService("VirtualInputManager")
