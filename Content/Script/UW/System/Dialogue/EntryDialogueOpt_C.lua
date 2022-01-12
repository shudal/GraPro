
require "UnLua"

local EntryDialogueOpt_C=Class()

function EntryDialogueOpt_C:Construct()
    self.FBtn_opt.OnClicked:Add(self,self.OptMade)
end
function EntryDialogueOpt_C:OnListItemObjectSet(obj_item)
    self.obj_item=obj_item

    self.TB_des:SetText(obj_item.data.opt.Description)
    print("touma,set optiondes:",obj_item.data.opt.Description)
    self.uw_dia=obj_item.data.uw_dia
    self.uw_dia:AddCntOptShowed()
end
function EntryDialogueOpt_C:OptMade()
    self.uw_dia:OptMade(self.obj_item.data.opt.Identifier)
end
function EntryDialogueOpt_C:SetFocToMyBtn() 
    UE.UButton.SetFocus(self.FBtn_opt)
end
function EntryDialogueOpt_C:OnFocusReceived()
    self:SetFocToMyBtn()
    print("entry dia opt set foc to btn")
    return UE.UWidgetBlueprintLibrary.Handled()
end
return EntryDialogueOpt_C