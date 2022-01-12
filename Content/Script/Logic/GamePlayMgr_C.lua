require "UnLua"
local MyLuaFuncLib_C=require "Utility/MyLuaFuncLib_C"

---@class GamePlayMgr_C : AActor
local GamePlayMgr_C = Class()

function GamePlayMgr_C:MyGetDTSuqs()
    assert(self.dt_quest~=nil)
    return self.dt_quest
end
function GamePlayMgr_C:MyInitQuestSys()
    --[[
    local ga_inst=MyLuaFuncLib_C:GetMyGameInst(self)
    assert(ga_inst ~= nil, "game inst can not null")
    local suqs_prog=ga_inst:MyGetSuqsProg()
    self.suqs_prog=suqs_prog
    --UE.USuqsProgression.InitWithQuestDataTables(suqs_prog,self:MyGetDTSuqs())
    --print("touma,suqs init with table ok")
    ]]
    

    self.uw_quest=NewObject(self.cls_uw_quest,self)
    UE.UUserWidget.SetOwningPlayer(self.uw_quest,UE.UGameplayStatics.GetPlayerController(self,MyLuaFuncLib_C:MyGetPlayerIdx()))
    self.uw_quest:AddToViewPort()
end
function GamePlayMgr_C:MyGetDTDialogue()
    assert(self.dt_dia~=nil)
    return self.dt_dia
end
function GamePlayMgr_C:MyGetDTSpeaker()
    assert(self.dt_speakers)
    return self.dt_speakers
end
function GamePlayMgr_C:MyGetDTDialogueActivator()
    assert(self.dt_dia_act)
    return self.dt_dia_act
end
function GamePlayMgr_C:MyInitDialogueSys()
    --local ga_inst = MyLuaFuncLib_C:GetMyGameInst(self)
    --assert(ga_inst~=nil)
    self.dia_sys=MyLuaFuncLib_C:GetDiaSys(self)
    assert(self.dia_sys ~= nil)
    
    print(MyLuaFuncLib_C:GetMyGameInst(self):GetEverIniDiaSys())
    if (MyLuaFuncLib_C:GetMyGameInst(self):GetEverIniDiaSys()==false) then 
        print("dialogue sys, not result",not MyLuaFuncLib_C:GetMyGameInst(self):GetEverIniDiaSys())
        self.dia_sys:MyInitSpeakerWithDataTables(self:MyGetDTSpeaker())
        UE.UMyDialogueSystem.MyInitWithDataTables(self.dia_sys,self:MyGetDTDialogue())
        self.dia_sys:MyInitDialogueActivatorWithDataTables(self:MyGetDTDialogueActivator())
        MyLuaFuncLib_C:GetMyGameInst(self):SetEverIniDiaSys(true)
    else 
        -- magic!
        print("dialogue sys, in else,not result",not MyLuaFuncLib_C:GetMyGameInst(self):GetEverIniDiaSys())
    end
    
    self.dia_sys.game_mgr=self

end
function GamePlayMgr_C:MyInitMiniMap()
    self.uw_minimap=NewObject(self.cls_uw_minimap,self)
    self.uw_minimap:SetOwningPlayer(MyLuaFuncLib_C:MyGetPlayerCon(self))
    self.uw_minimap:AddToViewPort()
end 
function GamePlayMgr_C:MyInit()
    self:MyInitQuestSys()
    self:MyInitDialogueSys() 
    self:MyInitMiniMap()
    
    --self.dia_sys:StartDialogue("dia_1")
    self.list_wait_to_user_foc = {}
end
function GamePlayMgr_C:ReceiveBeginPlay()
    --self:MyInit()
    
    
    local gainst=MyLuaFuncLib_C:GetMyGameInst(self)
    assert(gainst~=nil) 
    print(gainst:MyGetEverSpudLoad())
    if (gainst:MyGetEverSpudLoad()==false) then
        gainst:MySetEverSpudLoad(true)

        local spud=MyLuaFuncLib_C:MyGetSpudSys(self)
        assert(spud~=nil)
        if (spud:GetQuickSaveGame()==nil) then
            print("touma,not ever saved")
            self:MyInit()
        else 
            print("touma,going to load")
            
            spud:QuickLoadGame() 
            --print("touma,fake load")
            --self:MyInit()
            --UE.UGameplayStatics.OpenLevel(self,"LevelFirst",true)
        end
    else 
        print("touma,ever loaded ,not going to load")
        self:MyInit()
    end
    --]] 
end

function GamePlayMgr_C:GetDiaSys()
    return self.dia_sys
end
function GamePlayMgr_C:ListWaitUserFocAdd(obj) 
    table.insert(self.list_wait_to_user_foc,obj)
end
function GamePlayMgr_C:FocToUI(b) 
    for i,v in ipairs(self.list_wait_to_user_foc) do
        local ans=v:FocToUI(b)
        if (ans) then
            break
        end
    end 
end  
function GamePlayMgr_C:ReceiveEndPlay(r)
    self:MyLuaEndPlay()
end
function GamePlayMgr_C:MyLuaEndPlay()
    print("touma,in lua,going to quick save game")
    MyLuaFuncLib_C:MyGetSpudSys(self):QuickSaveGame("",false)
end
return GamePlayMgr_C