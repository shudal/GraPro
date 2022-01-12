
require "UnLua"

---@type UUserWidget
---@field public LV_DiaStartTip UListView
local DiaStartTip_C=Class()


function DiaStartTip_C:Construct() 
    self.pengding_dia_start_tip = {}
    self.showing_tip_info = {}
    self.max_show_count=2
    self.bGetFoc=false

    --self.LV_DiaStartTip.BP_OnItemSelectionChanged:Add(self,self.lv_item_sel_change)
end
--[[ 
function DiaStartTip_C:lv_item_sel_change(item,bseled)
    print("touma",item,bseled)
    if (bseled) then 
    end
end
--]]
function DiaStartTip_C:CheckPengdingShowList()
    if (#self.showing_tip_info < self.max_show_count) then
        --print("t2")
        if (#self.pengding_dia_start_tip >= 1) then
            local req_dia_info_ui=table.remove(self.pengding_dia_start_tip,1)

            local showing_info = {}
            showing_info.req_dia_info_ui=req_dia_info_ui

            ---@type UListView
            local lv=self.LV_DiaStartTip
            local obj_item=NewObject(self.cls_entry_item,self)
            obj_item.data = {}
            obj_item.data.req_dia_info_ui=req_dia_info_ui
            lv:AddItem(obj_item)
            --print("add item")

            showing_info.obj_item=obj_item
            table.insert(self.showing_tip_info,showing_info)
        end
    end

    if (#self.showing_tip_info == 0 and self.bGetFoc) then
        self:RemoveFoc()
    end
end

function DiaStartTip_C:ReqShowDia(req_dia_info_ui,bshow) 
    print("touma,ui req show dia\n")

    if (bshow) then
        table.insert(self.pengding_dia_start_tip,req_dia_info_ui)
        --print("t")
        self:CheckPengdingShowList()
    else
        for i,pending_req in ipairs(self.pengding_dia_start_tip) do
            if (pending_req.id_sent == req_dia_info_ui.id_sent) then
                table.remove(self.pengding_dia_start_tip,i)
                break
            end
        end
        for i,showing_info in ipairs(self.showing_tip_info) do
            if (showing_info.req_dia_info_ui.id_sent == req_dia_info_ui.id_sent) then 
                ---@type UListView
                local lv=self.LV_DiaStartTip
                lv:RemoveItem(showing_info.obj_item)

                table.remove(self.showing_tip_info,i)
                self:CheckPengdingShowList()
                break
            end
        end
    end
    
end
function DiaStartTip_C:GetFoc()
    local con_player=UE.UGameplayStatics.GetPlayerController(self,MyLuaFuncLib_C:MyGetPlayerIdx())
    
    
    --UE.UWidgetBlueprintLibrary.SetInputMode_UIOnlyEx(con_player,lv,UE.EMouseLockMode.DoNotLock)
    --UE.UWidgetBlueprintLibrary.SetInputMode_UIOnly()
    --UE.UWidgetBlueprintLibrary.SetInputMode_GameAndUIEx()
    UE.UWidgetBlueprintLibrary.SetInputMode_GameAndUI(con_player,self)
    --lv:SetSelectedIndex(0)
    self:SetFocToTipBtnOne()

    con_player.bShowMouseCursor=true
    --UE.UGameplayStatics.SetGamePaused(self,true)
    self.bGetFoc=true
end
function DiaStartTip_C:RemoveFoc()
    if (self.bGetFoc) then
        local con_player=UE.UGameplayStatics.GetPlayerController(self,MyLuaFuncLib_C:MyGetPlayerIdx())
        UE.UWidgetBlueprintLibrary.SetInputMode_GameOnly(con_player)
        UE.UGameplayStatics.SetGamePaused(self,false)
        self.bGetFoc=false 
    end
end
function DiaStartTip_C:FocToUI(b)
    local ans=false
    if (b) then
        if (self.bGetFoc==false) then 
            if (#self.showing_tip_info > 0) then
                self:GetFoc()
                ans=true
            end
        else
            self:RemoveFoc()
            --print("touma,diastartip remove foc")
            ans=true
        end
        
    end
    return ans
end
function DiaStartTip_C:SetFocToTipBtnOne()
    ---@type UListView
    local lv=self.LV_DiaStartTip
    local wids=lv:GetDisplayedEntryWidgets()
    if (wids:Length()>0) then
        wids:Get(1):SetFocus()
    end
end
function DiaStartTip_C:OnRemovedFromFocusPath()
    if (self.bGetFoc) then 
        self:SetFocToTipBtnOne()
    end
end
return DiaStartTip_C