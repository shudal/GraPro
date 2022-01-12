
require"UnLua"

---@class AttackFist_C : UGameplayAbility
local AttackFist_C = Class()
function AttackFist_C:K2_ActivateAbility()
    print("activate ability in lua")
    self:K2_CommitAbility()
    local task=UE.UAbilityTask_PlayMontageAndWait.CreatePlayMontageAndWaitProxy(self,"None",self.mon_anim)
    task:ReadyForActivation()
end
return AttackFist_C