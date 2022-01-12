require "UnLua"

local MyLuaFuncLib_C=require "Utility/MyLuaFuncLib_C"

local EnterLevelMgr = Class()

function EnterLevelMgr:ReceiveBeginPlay()
    self.bPreventUWDisappear=true
    self:MyInitMenuStack()
end
--[[ 
function EnterLevelMgr:MySetPreventUWDisappear(b)
    self.bPreventUWDisappear=b
end
]]
function EnterLevelMgr:MyInitMenuStack()
    self.uw_menustack=NewObject(self.clas_uw_menustack,self)
    self.uw_enterlevel=NewObject(self.cls_uw_enterlevel,self)
     
    UE.UUserWidget.SetOwningPlayer(self.uw_menustack,UE.UGameplayStatics.GetPlayerController(self,MyLuaFuncLib_C:MyGetPlayerIdx()))
    UE.UUserWidget.SetOwningPlayer(self.uw_enterlevel,UE.UGameplayStatics.GetPlayerController(self,MyLuaFuncLib_C:MyGetPlayerIdx()))
    self.uw_menustack:SetCanCloseAll(false) 
    self.uw_menustack:AddToViewPort()
    UE.UMenuStack.PushMenuByObject(self.uw_menustack,self.uw_enterlevel)


    --[[ 
        self.uw_menustack.OnClosed:Add(self,self.MyOnMenuStackClose)
        self.uw_enterlevel.mgr=self
    ]] 
end

--[[

function EnterLevelMgr:MyOnMenuStackClose(mstack,b_was_cancle)
    if (self.bPreventUWDisappear) then 
        coroutine.resume(coroutine.create(function(self) 
            UE.UKismetSystemLibrary.Delay(self,0.2) 
            self:MyInitMenuStack()
        end),self)
    end
end
]] 

return EnterLevelMgr