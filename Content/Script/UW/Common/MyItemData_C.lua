
require "UnLua"

local MyItemData_C=Class() 
function MyItemData_C:MyGetData()
    return self.data
end
return MyItemData_C