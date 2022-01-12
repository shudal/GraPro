require "UnLua"

---@class GameInst_C : UMyGameInstance
---@field protected mysavedata BP_MySaveData
local GameInst_C = Class()

print("touma,gaminst_c lua file loaded")
function GameInst_C:MyGetDTQuest()
    assert(self.dt_quest~=nil)
    return self.dt_quest
end
function GameInst_C:MyLuaIni()
    self:MyGetSuqsProg():InitWithQuestDataTables(self:MyGetDTQuest())
    --self:InitDialogueSys()
    self.bEverIniDiaSys=false
    self.bEverSpudLoad=false

    self.mysavedata = NewObject(self.cls_mysavedata,self)
    assert(self.mysavedata~=nil)
    print("touma,game inst,lua ini")
    --self:GetSpudSystem():AddPersistentGlobalObjectWithName(self:MyGetSaveData(),"gameinst_savedata")
end 
function GameInst_C:MyGetEverSpudLoad()
    return self.bEverSpudLoad
end
function GameInst_C:MySetEverSpudLoad(x)
    self.bEverSpudLoad=x
end
function GameInst_C:MyGetSaveData()
    return self.mysavedata
end
--function GameInst_C:InitDialogueSys()

--end
---@return USuqsProgression
function GameInst_C:MyGetSuqsProg()
    assert(self.suqs_prog ~= nil)
    return self.suqs_prog
end 
function GameInst_C:SetEverIniDiaSys(x)
    self.bEverIniDiaSys=x
end
function GameInst_C:GetEverIniDiaSys(x)
    return self.bEverIniDiaSys
end
return GameInst_C