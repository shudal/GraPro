require "UnLua"


---@type UActorComponent
local AC_DialogueStart_C=Class()

function AC_DialogueStart_C:ReceiveBeginPlay()
    self.last_detect_req_add = {}

    if (self.bDetect) then 
        UE.UKismetSystemLibrary.K2_SetTimer(self,"DetectPlayer",0.5,true)
    end
    
    ---@type ACharacter
    self.myact=self:GetOwner()

    if self.bIsChar then
        --@type FText
        self.dia_name_id=self.DiaCharNameId
    else
       self.dia_name_id=self.DiaNPCNameId 
    end  
    local str_id_name=UE.UKismetStringLibrary.Conv_NameToString(self.dia_name_id) 
    --local b=UE.UKismetTextLibrary.TextIsEmpty(txt_id_name)
    local b=str_id_name=="None"
    print("touma,name null?",self.dia_name_id,b)
    assert(b==false)

    local gmgr=UE.UGameplayStatics.GetActorOfClass(self,self.cls_gameplay_mgr)
    self.dia_sys=gmgr:GetDiaSys()
    assert(self.dia_sys~=nil)
    local tmp2=self.dia_sys:ExistIdInSpeaker(self.dia_name_id)
    --assert(tmp2==true,"dialogue speaker id:" .. tostring(self.dia_name_id) .. " not exist in speaker" .. "\n" .. tostring(self:GetOwner():GetActorLabel()))
end
function AC_DialogueStart_C:GetDiaNameId()
    return self.dia_name_id
end
function AC_DialogueStart_C:DetectPlayer()
    --print("touma,detect player") 
    local boxloc=self.myact:K2_GetActorLocation()

    local boxloc_forward=self.myact:GetActorForwardVector() 
    UE.UKismetMathLibrary.Vector_Normalize(boxloc_forward) 
    boxloc_forward = boxloc_forward*100  

    boxloc = boxloc + boxloc_forward
    local obj_types=UE.TArray(UE.EObjectTypeQuery)
    obj_types:Add(UE.EObjectTypeQuery.Pawn)
    local box_ext=UE.FVector(50,50,50)

    local act_ign=UE.TArray(UE.AActor)
    act_ign:Add(self.myact)
    local acts,bever_found=UE.UKismetSystemLibrary.BoxOverlapActors(self,boxloc,box_ext,obj_types,UE.ACharacter,act_ign)
    --print(bever_found)
    --UE.UKismetSystemLibrary.DrawDebugBox(self,boxloc,box_ext,UE.FLinearColor(1,0,0),UE.FRotator(),1,1)

    local this_detect_req_add = {}
    for i=1,acts:Length() do
        ---@type AActor
        local tact=acts:Get(i)
        local cls_dia_comp=UE.UGameplayStatics.GetObjectClass(self)
        local other_dia_com=tact:GetComponentByClass(cls_dia_comp)
        if (other_dia_com~=nil) then
            local other_id=other_dia_com:GetDiaNameId()
            --print(self:GetDiaNameId(),other_id)
            --print(tact:GetActorLabel())
            local bCanAct,id_act_sent=self.dia_sys:CanActDiaByNameId(self:GetDiaNameId(),other_id)
            if (bCanAct) then
                local req_dia_info = {}
                req_dia_info.other_id=other_id
                req_dia_info.id_sent=id_act_sent
                table.insert(this_detect_req_add,req_dia_info)
                --this_detect_req_add:insert(id_act_sent)
            end
        end
    end
 
    local req_this_detect_new = self:ReqDiaInfoSub(this_detect_req_add,self.last_detect_req_add)
    for i,req_dia_info in ipairs(req_this_detect_new) do 
        self.dia_sys:RequestShowDia(req_dia_info,true)
    end
    local req_last_detect_more = self:ReqDiaInfoSub(self.last_detect_req_add,this_detect_req_add)
    for i,req_dia_info in ipairs(req_last_detect_more) do
        self.dia_sys:RequestShowDia(req_dia_info,false)
    end
 
    self.last_detect_req_add = this_detect_req_add
end

-- a-b
function AC_DialogueStart_C:ReqDiaInfoSub(a,b)
    local ans={}
    for i,areq in ipairs(a) do
        local bfound=false
        for k,breq in ipairs(b) do
            if (areq.id_sent==breq.id_sent) then
                bfound=true
            end
        end

        if (bfound==false) then
            table.insert(ans,areq)
        end
    end
    return ans
end
return AC_DialogueStart_C