require "UnLua"
local AC_JianDanWaiGuanEnemy_C = Class()

function AC_JianDanWaiGuanEnemy_C:ReceiveBeginPlay()
    print("touma,enemy begin play")

    local player=self:GetOwner()
    local skecomp = player:GetComponentByClass(UE.USkeletalMeshComponent)
    UE.USkeletalMeshComponent.SetMaterialByName(skecomp,"M_EnemyMale_Body",self:CreateMD())
end

function AC_JianDanWaiGuanEnemy_C:CreateMD()
    local md = UE.UKismetMaterialLibrary.CreateDynamicMaterialInstance(self,self.MI_EnemyBody)

    if (self.bMatParamUseU) then
        md:SetScalarParameterValue("ParamUseU",1)
    else
        md:SetScalarParameterValue("ParamUseU",0) 
    end

    md:SetScalarParameterValue("ParamBeiShu",self.MatParamBeiShu)
    md:SetVectorParameterValue("ParameSpeed",self.MatParamSpeed)  
    return md
end
return AC_JianDanWaiGuanEnemy_C