
require "UnLua"

---@class JumpSection_C : UAnimNotifyState
local JumpSection_C=Class()

print("touma,jumpsection_c lua file loaded")
function JumpSection_C:GetCompCombo(compmesh)
    local act=compmesh:GetOwner()
    assert(act~=nil)
    ---@type AC_AttackCombo_C
    local compcombo=act:GetComponentByClass(self.cls_comp_attackcombo)
    assert(compcombo~nil) 
    return compcombo
end
---@param compmesh USkeletalMeshComponent
function JumpSection_C:Received_NotifyBegin(compmesh,animseq,totalduration)
    local compcombo=self:GetCompCombo(compmesh)
    compcombo:SetCanCombo(true)
    compcombo:SetComboRandomSectionsNext(self.NextRandomSections)
    print("touma,in jumpsection state,begin")
    return true
end
function JumpSection_C:Received_NotifyEnd(compmesh,animseq)
    self:GetCompCombo(compmesh):SetCanCombo(false)
    return true
end
return JumpSection_C