
require "UnLua"

local MyLuaFuncLib_C=require "Utility/MyLuaFuncLib_C"
local UW_Quest = Class()

function UW_Quest:Construct()
    local suqs_prog=MyLuaFuncLib_C:GetSuqsProg(self)
    assert(suqs_prog~=nil)
    
    UE.USuqsProgression.AcceptQuest(suqs_prog,"QuestOne")
    self:RefreshQuestInfo()

    suqs_prog.OnProgressionEvent:Add(self,self.QuestProged)

    --self.TimerHandle = UE.UKismetSystemLibrary.K2_SetTimerDelegate({ self, self.OnTimer }, 1, true)
end

function UW_Quest:OnTimer()
    self:RefreshQuestInfo()
end
---@return UListView
function UW_Quest:GetLVQuest()
    return self.LV_quests
end
function UW_Quest:RefreshQuestInfo()
    self:GetLVQuest():ClearListItems()
    local quest_states=MyLuaFuncLib_C:GetSuqsProg(self):GetAcceptedQuests()
    print("touma,quest acepted count",quest_states:Length())
    local bNotRefres=false
    for i=1,quest_states:Length() do 
        
        local q=quest_states:GetRef(i)
        assert(q~=nil) 
        local obj_item=NewObject(self.cls_quest_item_info,self)
        
        
        obj_item.data.quest_title=UE.USuqsQuestState.GetTitle(q) 
        obj_item.data.quest_des=UE.USuqsQuestState.GetDescription(q)  
        MyLuaFuncLib_C:MyDumpTable(obj_item.data)
        local que_obj=UE.USuqsQuestState.GetCurrentObjective(q)

        if (que_obj==nil) then
            bNotRefres=true
            break
        end
        --obj_item.data.que_obj_title=que_obj:GetTitle()
        --obj_item.data.que_obj_des=que_obj:GetDescription()  
 
        local nxt_task=que_obj:GetNextMandatoryTask()
        if (nxt_task==nil) then
            bNotRefres=true 
            break
        end
        
        obj_item.data.nxt_task_title=nxt_task:GetTitle()
        obj_item.data.nxt_task_num=nxt_task:GetNumber() 
        obj_item.data.nxt_task_tar=nxt_task:GetTargetNumber()

        
        UE.UListView.AddItem(self.LV_quests,obj_item)
    end 
end
function UW_Quest:QuestProged(evt_detail) 
    self:RefreshQuestInfo()
end
return UW_Quest