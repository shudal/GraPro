require "UnLua"

local Item_Quest_Info_C=Class()
 
Item_Quest_Info_C.data={}
function Item_Quest_Info_C:MyGetData()
    return self.data
end
return Item_Quest_Info_C