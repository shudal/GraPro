
require "UnLua"

_G.MyLuaFuncLib_C = Class()

---@param obj UObject
---@return GameInst_C
function MyLuaFuncLib_C:GetMyGameInst(obj)
   local ga_inst= UE.UGameplayStatics.GetGameInstance(obj)
   assert(ga_inst ~= nil)
   return ga_inst
end
function MyLuaFuncLib_C:GetDiaSys(obj)
   local ga_inst=self:GetMyGameInst(obj)
   local dia_sys=ga_inst:GetMyDialogueSys()
   assert(dia_sys~=nil) 
   return dia_sys
end
---@return USuqsProgression
function MyLuaFuncLib_C:GetSuqsProg(obj)
   local ga_inst=self:GetMyGameInst(obj)
   assert(ga_inst ~= nil, "game inst can not null")
   local suqs_prog=ga_inst:MyGetSuqsProg()
   return suqs_prog
end
function MyLuaFuncLib_C:MyGetPlayerCon(obj) 
   return UE.UGameplayStatics.GetPlayerController(obj,self:MyGetPlayerIdx())
end
function MyLuaFuncLib_C:MyGetPlayerIdx()
   return 0
end
function MyLuaFuncLib_C:MyDumpTable(t)
   for k,v in pairs(t) do
      print("key:",k,"value:",v)
   end
end
function MyLuaFuncLib_C:IsNameNone(name)
   return UE.UKismetStringLibrary.Conv_NameToString(name)=="None"
end
---@return USpudSubsystem
function MyLuaFuncLib_C:MyGetSpudSys(obj)
   local gainst=self:GetMyGameInst(obj)
   local spud=gainst:GetSpudSystem()
   assert(spud~=nil) 
   return spud
end
return MyLuaFuncLib_C