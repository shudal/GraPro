

require "UnLua"
local MyItemData_C=require "UW/Common/MyItemData_C"

---@type UUserWidget
local UW_MyDialogue_C=Class()

function UW_MyDialogue_C:Construct()
     self.FBtn_content.OnClicked:Add(self,self.ContentClicked)
     --self.bEverSetFoc=false
     self.cnt_opt_showed=0
     self.cnt_opt_target=0
end
function UW_MyDialogue_C:ContentClicked()
    self.dia_sys:ContentClicked(self.sentspec)
end
function UW_MyDialogue_C:SetSent(sentspec,dia_sys)
    self.TB_name:SetText(sentspec.def_speaker.SpeakerName)
    self.TB_content:SetText(sentspec.def_sent.Content)

    self.cnt_opt_showed=0
    self.cnt_opt_target=sentspec.def_sent.Options:Length()
    self.LV_options:ClearListItems()
    if (sentspec.def_sent.Options:Length()>0) then
        for i=1,sentspec.def_sent.Options:Length() do
            local opt=sentspec.def_sent.Options:Get(i)
            local item_data=NewObject(self.cls_item_data,self)
            item_data.data = {}
            item_data.data.opt = opt
            item_data.data.uw_dia = self
            self.LV_options:AddItem(item_data)
        end
        
    end

    self.sentspec = sentspec
    self.dia_sys = dia_sys
end
function UW_MyDialogue_C:OptMade(str_opt)
    print("touma,option made:",str_opt)
    self.dia_sys:OptMade(self.sentspec,str_opt)

end

---@return UListView
function UW_MyDialogue_C:GetLVOption()
    return self.LV_options
end 

function UW_MyDialogue_C:AddCntOptShowed()
    self.cnt_opt_showed = self.cnt_opt_showed + 1
    if (self.cnt_opt_showed==self.cnt_opt_target) then
        if self:GetLVOption():GetDisplayedEntryWidgets():Length()>0 then
            ---@type UUserWidget
            local uw_entry=self:GetLVOption():GetDisplayedEntryWidgets():Get(1) 
            --uw_entry:SetUserFocus(MyLuaFuncLib_C:MyGetPlayerCon(self))
            uw_entry:SetFocus()
            print("touma,set foc to opt")
        else
            self.FBtn_content:SetFocus()
            print("touma,set foc to content")
        end 
    end
end
--[[ 
function UW_MyDialogue_C:SetDefaultFoc()
   --[[

    print("touma,hasanyuserfocus",self:HasAnyUserFocus())
    print("touma,hasusefocus",self:HasUserFocus())
    print("touma,haskeyboardfocus",self:HasKeyboardFocus())
    print("touma,hasfocuseddescendatns",self:HasFocusedDescendants())
    --print("touma,has",self:HasUserFocusedDescendants())
    
end
]]
return UW_MyDialogue_C