getgenv().newcclosure = function(a) return a end
getgenv().new_c_closure = function(b) return b end

getgenv().hookmetamethod = function(table, method, func)
   local mt = getrawmetatable(table)
   setreadonly(mt, false)
   local old = mt[method]
   mt[method] = function(...)
       return func(...)
   end
   return old
end

getgenv().hook_meta_method = hookmetamethod
getgenv().HookMetaMethod = hookmetamethod
