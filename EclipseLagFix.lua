getgenv().newcclosure = function(a) return a end
getgenv().new_c_closure = function(b) return b end

getgenv().hookmetamethod = function(table, method, func)
   local mt = getrawmetatable(table)
   setreadonly(mt, false)
   if method == "__namecall" then
      local old = mt.__namecall
      mt.__namecall = function(self, ...)
         return func(self, ...)
      end
      return old
   elseif method == "__index" then
      local old = mt.__index
      mt.__index = function(self, key, ...)
         return func(self, key, ...)
      end
      return old
   elseif method == "__newindex" then
      local old = mt.__newindex
      mt.__newindex = function(self, key, value, ...)
         return func(self, key, value, ...)
      end
      return old
   elseif method == "__tostring" then
      local old = mt.__tostring 
      mt.__tostring = function(self, ...)
         return func(self, ...)
      end
      return old
   end
end
