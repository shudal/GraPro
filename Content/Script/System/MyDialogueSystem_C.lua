
require "UnLua"

local MyLuaFuncLib_C=require "Utility/MyLuaFuncLib_C"

---type UMyDialogueSystem
local MyDialogueSystem_C=Class()

function MyDialogueSystem_C:MyLuaIni()
    self.uw_dia_cls=UE.UClass.Load("/Game/MJH/GamePlay/BP/DialogueSystem/UI/BP_UW_Dialogue.BP_UW_Dialogue")
    self.cls_uw_menustack=UE.UClass.Load("/Game/Blueprints/UI/Widget_MainMenuStack_Dialogue.Widget_MainMenuStack_Dialogue")
    self.cls_uw_dia_start_tip=UE.UClass.Load("/Game/MJH/GamePlay/BP/DialogueSystem/UI/BP_UW_DiaStartTip.BP_UW_DiaStartTip")

    self.game_mgr = nil
end
function MyDialogueSystem_C:MyCreUW()  
    self.uw_menustack=NewObject(self.cls_uw_menustack,self)
    self.uw_menustack:SetOwningPlayer(UE.UGameplayStatics.GetPlayerController(self,MyLuaFuncLib_C:MyGetPlayerIdx()))
    
    self.uw_menustack:AddToViewPort()

    self.uw_dia=NewObject(self.uw_dia_cls,self)
    UE.UUserWidget.SetOwningPlayer(self.uw_dia,UE.UGameplayStatics.GetPlayerController(self,MyLuaFuncLib_C:MyGetPlayerIdx()))
    
    self.uw_menustack:PushMenuByObject(self.uw_dia)
    --self.uw_dia:AddToViewPort()
    --UE.UUserWidget.SetVisibility(self.uw_dia,UE.ESlateVisibility.Hidden)
    self.uw_menustack:SetVisibility(UE.ESlateVisibility.Hidden)
end
function MyDialogueSystem_C:MyStartSent(sentspec)  
    if (self.uw_dia == nil) then
        self:MyCreUW()
    end
    self.uw_dia:SetSent(sentspec,self)
    self.uw_menustack:SetVisibility(UE.ESlateVisibility.Visible)
    --self.uw_dia:SetDefaultFoc()
end
function MyDialogueSystem_C:StartDialogue(start_id) 
   
    --print("touma,start dialogue")

    local sentid=self.SentName2Idx:Find(start_id)
    if (sentid == nil) then
        print("touma,sent id null,start id:",start_id)
    else
        print(sentid)
        local sentspec=self.Sentences:Get(sentid+1)
        
        assert(self.uw_dia_tip~=nil) 
        self.uw_dia_tip:RemoveFoc()
        self.uw_dia_tip:SetVisibility(UE.ESlateVisibility.Hidden)

        --self.now_dia_start_sentspec = sentspec
        self.now_dia_start_rowname=start_id
        self:MyStartSent(sentspec)
    end
end
function MyDialogueSystem_C:QuitDia(def_sent_last) 
    self.uw_menustack:RemoveFromViewPort()
    self.uw_menustack=nil
    self.uw_dia=nil
    assert(self.uw_dia_tip~=nil) 
    self.uw_dia_tip:SetVisibility(UE.ESlateVisibility.Visible)

    --local ds_start=self.now_dia_start_sentspec:GetDefDiaSent()
    --local id_start=ds_start.Identifier 
    self.DelegateMyDiaComp:Broadcast(self.now_dia_start_rowname)
end
function MyDialogueSystem_C:OptMade(sentspec,str_opt)
    --print("touma,dia sys receive opt made")
    
    local ds=UE.UMyDiaSentSpec.GetDefDiaSent(sentspec)
    local opts=ds.Options
    local cnt_found_opt=0
    for i=1,opts:Length() do
        local opt=opts:Get(i)
        if (opt.Identifier==str_opt) then
            cnt_found_opt = cnt_found_opt + 1
            if (opt.Action==UE.EMyDialogueOptionAction.Quit) then
                self:QuitDia(ds)
                break
            else
                if (opt.Action==UE.EMyDialogueOptionAction.JMP) then
                    print("touma,jmp")
                    local sentspec_idx=sentspec:GetIdxInSpecArr()
                    assert(sentspec_idx~=nil)
                    local next_idx=sentspec_idx+opt.JmpOffset

                    -- unlua tarray index need +1
                    local next_sent=self.Sentences:Get(next_idx+1)
                    self:MyStartSent(next_sent)
                end 
            end 
        end
    end
    assert(cnt_found_opt==1)
    self.DelegateMyOptMade:Broadcast(self.now_dia_start_rowname,str_opt)
end

function MyDialogueSystem_C:ContentClicked(sentspec) 
    local ds=UE.UMyDiaSentSpec.GetDefDiaSent(sentspec)
    local opts=ds.Options

    if (opts:Length()==0) then
        if(ds.ClickAction==UE.EDialogueSentenceClickAction.Quit) then
            self:QuitDia(ds)
        end
        if(ds.ClickAction==UE.EDialogueSentenceClickAction.ToNextRow) then
            local sentspec_idx=sentspec:GetIdxInSpecArr()
            local next_idx=sentspec_idx+1

            -- unlua tarray index need +1
            local next_sent=self.Sentences:Get(next_idx+1)
            self:MyStartSent(next_sent)
        end
    end
end
---@param condquest FDiaActCondSimple
function MyDialogueSystem_C:IsDiaActCondSimpleSatisfy(condquest)
    local ans=true

    
    if condquest.bLimitQuest then  
        assert(MyLuaFuncLib_C:IsNameNone(condquest.IdQuest)==false)
        ---@type USuqsProgression
        local suqs_prog=self.suqs_prog
        local stat_que=suqs_prog:GetQuest(condquest.IdQuest)
        --assert(stat_que~=nil) 
        if (condquest.StaQue~=stat_que:GetStatus()) then
            ans=false
        else 
            if (condquest.bLimitObj) then
                assert(MyLuaFuncLib_C:IsNameNone(condquest.IdObj)==false)
                local stat_obj=stat_que:GetObjective(condquest.IdObj)
                --assert(stat_obj~=nil)
                if (stat_obj:GetStatus() ~= condquest.StaObj) then
                    ans=false
                end
            end
            if (condquest.bLimitTask) then
                assert(MyLuaFuncLib_C:IsNameNone(condquest.IdTask)==false)
                local stat_task=stat_que:GetTask(condquest.IdTask)
                if (stat_task:GetStatus()~=condquest.StaTask) then
                    ans=false
                end
            end
        end
    end
     
    return ans
end
function MyDialogueSystem_C:CanActDiaByNameId(id_char,id_npc)
    assert(self:ExistIdInSpeaker(id_char))
    assert(self:ExistIdInSpeaker(id_npc))
    --print("touma,can act dia by name id",id_char,id_npc)

    local ans=false
    local id_sent_act=nil
    for i=1,self.dia_acts:Length() do
        ---@type FMyDiaAct
        local dia_activate=self.dia_acts:Get(i)
 
        if (dia_activate.RowHandleSpeakerChar.RowName==id_char and dia_activate.RowHandleSpeakerNPC.RowName==id_npc) then
            local condarr_queand=dia_activate.CondArrQuestAnd.Conds
            if (condarr_queand:Length()==0) then 
                ans=true 
                --print(1)
                id_sent_act=dia_activate.RowHandleSent.RowName
            end
            for i=1,condarr_queand:Length() do
                local condquest=condarr_queand:Get(i)
                if (self:IsDiaActCondSimpleSatisfy(condquest)) then 
                    ans=true
                    id_sent_act=dia_activate.IdSent
                end
                

                --test just for
                if (ans) then
                    --self:StartDialogue(dia_activate.IdSent)
                    break
                end
            end
        else 
            --print(2)
        end
    end
    return ans,id_sent_act
end
function MyDialogueSystem_C:CreateUWDiaTip()
    
    ---@type UUserWidget
    self.uw_dia_tip=NewObject(self.cls_uw_dia_start_tip,self)
    self.uw_dia_tip:SetOwningPlayer(UE.UGameplayStatics.GetPlayerController(self,MyLuaFuncLib_C:MyGetPlayerIdx()))
    self.uw_dia_tip:AddToViewport()

    assert(self.game_mgr~=nil) 
    self.game_mgr:ListWaitUserFocAdd(self.uw_dia_tip)
end
function  MyDialogueSystem_C:RequestShowDia(diainfo,bshow)
    print("touma,request show dia ",diainfo.id_sent, diainfo.other_id,bshow)
    if (self.uw_dia_tip==nil) then
        self:CreateUWDiaTip()
    end

    local req_dia_info_ui = {}
    req_dia_info_ui.id_sent=diainfo.id_sent
    req_dia_info_ui.dia_sys=self
    for i=1,self.speakers:Length() do
        if (self.speakers:Get(i).Identifier==diainfo.other_id) then
            req_dia_info_ui.speaker_name=self.speakers:Get(i).SpeakerName
        end
    end
    self.uw_dia_tip:ReqShowDia(req_dia_info_ui,bshow) 
end
return MyDialogueSystem_C