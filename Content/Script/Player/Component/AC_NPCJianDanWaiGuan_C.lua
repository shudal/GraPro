 require "UnLua"
 local AC_NPCjianDanWaiGuan_C = Class()

 function AC_NPCjianDanWaiGuan_C:ReceiveBeginPlay()
   print("touma,unlua1")
   
   self:SetSkeletonMat()

   if (self.bCapCompRandomScale) then 
      local capcomp = self:GetOwner():GetComponentByClass(UE.UCapsuleComponent)
      local scale=UE.UKismetMathLibrary.RandomFloatInRange(self.CapCompRandomScaleMin,self.CapCompRandomScaleMax)
      capcomp:SetWorldScale3D(UE.FVector(scale,scale,scale))
   end
 end

 function AC_NPCjianDanWaiGuan_C:SetSkeletonMat()
   local player=self:GetOwner()
   local skecomp = player:GetComponentByClass(UE.USkeletalMeshComponent)
    
   UE.USkeletalMeshComponent.SetMaterialByName(skecomp,"Mat_Player",self:CreateMd(self.ColorPlayerBase))
   UE.USkeletalMeshComponent.SetMaterialByName(skecomp,"Mat_Player_TShirt",self:CreateMd(self.ColorPlayerShirt))
   UE.USkeletalMeshComponent.SetMaterialByName(skecomp,"Mat_Player_Pants",self:CreateMd(self.ColorPlayerPants))
   UE.USkeletalMeshComponent.SetMaterialByName(skecomp,"Mat_Player_Shoes",self:CreateMd(self.ColorPlayerShoes))
   UE.USkeletalMeshComponent.SetMaterialByName(skecomp,"Mat_Player_Head",self:CreateMd(self.ColorPlayerHead))
 
 end
 function AC_NPCjianDanWaiGuan_C:CreateMd(color)
   if (self.bColorUseRandom) then
      color=UE.FLinearColor()
      color.A=UE.UKismetMathLibrary.RandomFloat()
      color.R=UE.UKismetMathLibrary.RandomFloat()
      color.G=UE.UKismetMathLibrary.RandomFloat()
      color.B=UE.UKismetMathLibrary.RandomFloat()
   end
   local md = UE.UKismetMaterialLibrary.CreateDynamicMaterialInstance(self,self.MI_NPCSimple)
   md:SetVectorParameterValue("BaseColor",color)
   return md
 end
 return AC_NPCjianDanWaiGuan_C