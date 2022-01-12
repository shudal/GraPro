require "UnLua"
local QuestEntryWidget_C=Class()

function QuestEntryWidget_C:Construct() 
    UE.UTextBlock.SetVisibility(self.Tb_times,UE.ESlateVisibility.Hidden)
end
function QuestEntryWidget_C:OnListItemObjectSet(obj_item)
    UE.UTextBlock.SetText(self.TB_quest_title,obj_item:MyGetData().quest_title)
    self.TB_nxt_task_title:SetText(obj_item:MyGetData().nxt_task_title) 

    if (obj_item:MyGetData().nxt_task_tar > 1) then 
        self.Tb_times:SetText(tostring(obj_item:MyGetData().nxt_task_num) .. "/" .. tostring(obj_item:MyGetData().nxt_task_tar) )
        UE.UTextBlock.SetVisibility(self.Tb_times,UE.ESlateVisibility.Visible)
    else 
        UE.UTextBlock.SetVisibility(self.Tb_times,UE.ESlateVisibility.Hidden)
    end
end
return QuestEntryWidget_C