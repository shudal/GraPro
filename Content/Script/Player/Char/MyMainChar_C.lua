require "UnLua"

---@class MyMainChar_C : AGraProCharacter
local MyMainChar_C=Class()
 
function MyMainChar_C:PreInitializeComponentsForLua()
    print("touma,initialize recieve beginplay thirdperson char")
    self.OnAttackNormal = {}
end
function MyMainChar_C:GetGamePlayMgr()
    if (self.game_mgr==nil) then
        self.game_mgr=UE.UGameplayStatics.GetActorOfClass(self,self.cls_gameplaymgr)
        assert(self.game_mgr~=nil)
    end
    return self.game_mgr
end
function MyMainChar_C:FocToUI_Pressed()
    self:GetGamePlayMgr():FocToUI(true)
    --print(2)
end
function MyMainChar_C:FocToUI_Released()
    --print(1)
    self:GetGamePlayMgr():FocToUI(false)
end
function MyMainChar_C:GetOnAttackNormal()
    return self.OnAttackNormal
end
function MyMainChar_C:AttackNormal_Pressed()
    for i=1,#self.OnAttackNormal do
        local a=self.OnAttackNormal[i]
        a:AttackNormal(true)
    end
end
return MyMainChar_C