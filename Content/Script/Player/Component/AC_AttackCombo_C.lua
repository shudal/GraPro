
require "UnLua"

---@class AC_AttackCombo_C : UActorComponent
local AC_AttackCombo_C=Class()

function AC_AttackCombo_C:ReceiveBeginPlay()
    local act=self:GetOwner()
    assert(act~=nil) 
    --print(act:GetActorLabel())
    table.insert(act:GetOnAttackNormal(),self)

    self.CanCombo=false

    --[[
        0 started
        1 interrupeted
        2 ended
    ]]
    self.AttackState=2
end
function AC_AttackCombo_C:SetCanCombo(x)
    self.CanCombo=x
end
function AC_AttackCombo_C:GetCanCombo()
    return self.AttackState==0 and self.CanCombo
end
function AC_AttackCombo_C:GetComboNextSectionRandom()
    local idx=UE.UKismetMathLibrary.RandomIntegerInRange(1,self.RandomNextSections:Length())
    return self.RandomNextSections:Get(idx)
end
function AC_AttackCombo_C:SetComboRandomSectionsNext(secs)
    self.RandomNextSections = secs
end
function AC_AttackCombo_C:AttackNormal(bpressed)
    ---@type MyMainChar_C
    local act=self:GetOwner()
    assert(act~=nil) 
    if (bpressed) then 
        if (self:GetCanCombo()) then
            ---@type USkeletalMeshComponent 
            local compskm=act:GetComponentByClass(UE.USkeletalMeshComponent)
             assert(compskm~=nil) 
             local animinst=compskm:GetAnimInstance()
             
             animinst:Montage_JumpToSection(self:GetComboNextSectionRandom(),animinst:GetCurrentActiveMontage())
             print("attack normal jump seciton ok")
        else
            print("attacknormal in  attackcombo component")
            ---@type AC_PlayerInventory_C
            local compinventory=act:GetComponentByClass(self.cls_comp_playerinventory)
            local ga=compinventory:GetGAWeaponCur()
            local ans=UE.UAbilitySystemBlueprintLibrary.GetAbilitySystemComponent(act):TryActivateAbilityByClass(ga)
            print(ans)
            self.AttackState=0
        end
    end
end
return AC_AttackCombo_C