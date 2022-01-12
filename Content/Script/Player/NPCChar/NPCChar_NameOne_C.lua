require "UnLua"

---@type ACharacter
local NPCChar_NameOne_C = Class()

function NPCChar_NameOne_C:ReceiveBeginPlay()
    if (self.bListenForDiaComp) then 
        MyLuaFuncLib_C:GetDiaSys(self).DelegateMyDiaComp:Add(self,self.DiaComp)
        self.task_dia_around_ever_add = {}
    end
end
function NPCChar_NameOne_C:DiaComp(id_sent)
    local ids_dia_around_sent = {"dia_around_1","dia_around_2","dia_around_3"}
    for i,v in ipairs(ids_dia_around_sent) do
        if (v==id_sent and self.task_dia_around_ever_add[v]==nil) then
            MyLuaFuncLib_C:GetSuqsProg(self):ProgressTask("QuestOne","ask_around",1)
            self.task_dia_around_ever_add[v]=true
        end
    end
end
return NPCChar_NameOne_C