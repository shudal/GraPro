

require "UnLua"

local MyLuaFuncLib_C=require "Utility/MyLuaFuncLib_C"
local UW_Enter_C = Class()

function UW_Enter_C:Construct()
   self.btn_game_new.OnClicked:Add(self,self.MyGameNew) 
   self.btn_game_cont.OnClicked:Add(self,self.MyGameCont)
   self.btn_game_quit.OnClicked:Add(self,self.MyQuitGame)
end
--[[
function UW_Enter_C:MyNotPreventSelfDisapper()
    assert(self.mgr~=nil)
    self.mgr:MySetPreventUWDisappear(false)
end
]]
function UW_Enter_C:MyGameNew()
    --self:MyNotPreventSelfDisapper()
    UE.UGameplayStatics.OpenLevel(self,self.level_game_play)
    --MyLuaFuncLib_C:GetMyGameInst(self):MySetEverSpudLoad(true)
    --MyLuaFuncLib_C:MyGetSpudSys(self):QuickLoadGame()
end
function UW_Enter_C:MyGameCont() 
    --self:MyNotPreventSelfDisapper()
    UE.UGameplayStatics.OpenLevel(self,self.level_game_play)
end
function UW_Enter_C:MyQuitGame()
    --self:MyNotPreventSelfDisapper()
    UE.UKismetSystemLibrary.QuitGame(self,UE.UGameplayStatics.GetPlayerController(self,MyLuaFuncLib_C:MyGetPlayerIdx()),UE.EQuitPreference.Quit,false)
    print("touma,quit game btn quit")
end
function UW_Enter_C:Destruct()
    self:Release()
end
return UW_Enter_C