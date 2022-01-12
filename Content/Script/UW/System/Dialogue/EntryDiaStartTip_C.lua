require "UnLua"

local EntryDiaStartTip_C=Class()

function EntryDiaStartTip_C:Construct()
    self.btn_tip.OnClicked:Add(self,self.StartDia)
end
function EntryDiaStartTip_C:OnListItemObjectSet(obj_item)
    local req_dia_info_ui=obj_item:MyGetData().req_dia_info_ui
    self.TB_NPCName:SetText(req_dia_info_ui.speaker_name)
    self.dia_sys = req_dia_info_ui.dia_sys
    self.id_sent=req_dia_info_ui.id_sent
end
function EntryDiaStartTip_C:StartDia()
    --print("touma,id sent to start:",self.id_sent)
    self.dia_sys:StartDialogue(self.id_sent)
end
function EntryDiaStartTip_C:OnFocusReceived()
    print("touma,entry focus rec in lua")
    UE.UButton.SetFocus(self.btn_tip)
    return UE.UWidgetBlueprintLibrary.Handled()
end
return EntryDiaStartTip_C