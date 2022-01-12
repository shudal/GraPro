// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"

#include "Engine/DataTable.h"
#include "../InventorySystem/MyInventoryItem.h"
#include "GameplayAbilitySpec.h"
#include "MyBlueprintFunctionLibrary.generated.h"

/**
 * 
 */
UCLASS()
class GRAPRO_API UMyBlueprintFunctionLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
public:
	UFUNCTION(BlueprintCallable)
	static bool GetDataTableRowItemWeapon(FDataTableRowHandle handle, FMyItemWeapon& inweapon);
	UFUNCTION(BlueprintCallable)
	static FGameplayAbilitySpec MakeGameplayAbilitySpec(TSubclassOf<UGameplayAbility> InAbilityClass, int32 InLevel = 1);
};
