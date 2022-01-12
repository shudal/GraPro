
require "UnLua"

---@class AC_PlayerInventory_C : BP_AC_PlayerInventory
---@field protected IniItems TArray(UMyItemWeaponSpec) 
local AC_PlayerInventory_C = Class()

function AC_PlayerInventory_C:AddWeaponSpecUniq(spec)
    self.weaponspecs:AddUnique(spec)
end
function AC_PlayerInventory_C:ResolveWeaponSepcs()
    print("touma,ready to resolve weapon sepcs")
    
    local ownact=self:GetOwner()
    local abycomp=UE.UAbilitySystemBlueprintLibrary.GetAbilitySystemComponent(ownact)
    assert(abycomp~=nil)
     
    assert(self.weaponspecs:Length() > 0)
    for i=1,self.weaponspecs:Length() do
        ---@type UMyItemWeaponSpec
        local spec=self.weaponspecs:Get(i)
        print(spec:GetRowKey())
        assert(spec:MyGetItem().GrantedAbility~=nil)
        local abilityspec= UE.UMyBlueprintFunctionLibrary.MakeGameplayAbilitySpec(spec:MyGetItem().GrantedAbility,spec.level) --UE.FGameplayAbilitySpec()
        assert(abilityspec~=nil)
        print(abilityspec)

        --ownact:MyGiveAbility(abilityspec)
        abycomp:GiveAbility(abilityspec)
        print("ability gived")
    end
end
function AC_PlayerInventory_C:GetGAWeaponCur() 
    local spec=self.weaponspecs:Get(self:GetIdxWeaponCur())
    return spec:MyGetItem().GrantedAbility
end
function AC_PlayerInventory_C:GetIdxWeaponCur()
    assert(self.IdxWeaponCur >= 1 and self.IdxWeaponCur <= self.weaponspecs:Length())
    return self.IdxWeaponCur
end
function AC_PlayerInventory_C:ReceiveBeginPlay()
    local savedata=MyLuaFuncLib_C:GetMyGameInst(self):MyGetSaveData()
    assert(savedata ~= nil)
    self.weaponspecs:Append(savedata.CharWeapons)

    local ownact=self:GetOwner()
    for i=1,self.IniItems:Length() do
        local item_handle=self.IniItems:Get(i)
        local weapon=UE.FMyItemWeapon()
        local ans=UE.UMyBlueprintFunctionLibrary.GetDataTableRowItemWeapon(item_handle,weapon) 
        assert(ans)  
        print("touma,give initial",weapon,weapon.ItemName,weapon.ItemDescription,weapon.GrantedAbility)
        local spec=NewObject(UE.UMyItemWeaponSpec,self)
        spec:MySetItem(weapon,item_handle.RowName)
        self:AddWeaponSpecUniq(spec)
    end

    self:ResolveWeaponSepcs()

    self.IdxWeaponCur=1
end
return AC_PlayerInventory_C