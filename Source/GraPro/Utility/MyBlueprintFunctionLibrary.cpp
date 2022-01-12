// Fill out your copyright notice in the Description page of Project Settings.


#include "MyBlueprintFunctionLibrary.h"
#include "LuaCore.h"
#include "UnLua.h"
#include "UnLuaEx.h"
#include "SuqsTaskState.h"
#include "SuqsQuestState.h"
#include "Engine/GameInstance.h"
#include "Components/ListView.h"
#include "../MyDialogueSystem/MyDialogueSentence.h"
#include "../InventorySystem/MyInventoryItem.h"
#include "../Common/MyCommonHeader.h"
#include "AbilitySystemComponent.h"

bool UMyBlueprintFunctionLibrary::GetDataTableRowItemWeapon(FDataTableRowHandle handle,FMyItemWeapon& inweapon) {
	bool ans = false;
	auto p_item_weapon = handle.GetRow<FMyItemWeapon>("just test in func lib");
	if (p_item_weapon != nullptr) {
		inweapon = *p_item_weapon;
		ans = true;
	}
	return ans;
	//FMyInventoryItemBase* ans = nullptr;
	//auto p_dia_spkaer=handle.GetRow<FMyDialogueSpeaker>("just test in func lib");
	//ans = p_dia_spkaer == nullptr ? ans : p_dia_spkaer;

	/*
	auto p_item_weapon = handle.GetRow<FMyItemWeapon>("just test in func lib");
	ans = (p_item_weapon == nullptr ? ans : p_item_weapon);
	
	auto p_item_weapon2 = handle.GetRow<FMyInventoryItemBase>("just test in func lib");
	ans = (p_item_weapon2 == nullptr ? ans : p_item_weapon2);
	 
	*/
	/*
	if (p_item_weapon2 != nullptr) { 
		UE_LOG(LogJunhao, Log, TEXT("name:%s"),* p_item_weapon2->ItemName.ToString());
	
		auto p3 = (FMyItemWeapon*)p_item_weapon2; 
		UE_LOG(LogJunhao, Log, TEXT("p3 null?%d"), p3==nullptr ? 1:0);
		if (p3 != nullptr) { 
			UE_LOG(LogJunhao, Log, TEXT("p3 weapon actor name:%s"), *p3->WeaponActor->GetName());
		}

	}
	*/
	 
	//if (ans != nullptr) return *ans;
	//return FMyDialogueSpeaker();
}

FGameplayAbilitySpec UMyBlueprintFunctionLibrary::MakeGameplayAbilitySpec(TSubclassOf<UGameplayAbility> InAbilityClass, int32 InLevel) {
	auto ans = FGameplayAbilitySpec(InAbilityClass, InLevel);
	return ans;
}
BEGIN_EXPORT_REFLECTED_CLASS(USuqsTaskState)
ADD_FUNCTION(GetNumber)
END_EXPORT_CLASS()
IMPLEMENT_EXPORTED_CLASS(USuqsTaskState)
 
BEGIN_EXPORT_REFLECTED_CLASS(UAbilitySystemComponent)
ADD_FUNCTION(GiveAbility)
END_EXPORT_CLASS()
IMPLEMENT_EXPORTED_CLASS(UAbilitySystemComponent)

