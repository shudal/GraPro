// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Engine/GameInstance.h"
#include "MyGameInstance.generated.h"

class USuqsProgression; 
class UMyDialogueSystem;
class USuqsSpudWrapper;
/**
 * 
 */
UCLASS()
class GRAPRO_API UMyGameInstance : public UGameInstance
{
	GENERATED_BODY()
public:
	UMyGameInstance();
	
	virtual void Init() override;
protected:
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
		USuqsProgression* suqs_prog;
	UPROPERTY()
		USuqsSpudWrapper* QuestSpudWrapper;
	UFUNCTION(BlueprintImplementableEvent)
	void MyLuaIni();

	UFUNCTION(BlueprintCallable)
		void MyCallLuaInit() { MyLuaIni(); }
public:
	UFUNCTION(BlueprintCallable)
	UMyDialogueSystem* GetMyDialogueSys();
	UFUNCTION(BlueprintCallable)
		USuqsProgression* GetSuqsProg() { return suqs_prog; }

	UFUNCTION(BlueprintCallable)
	class USpudSubsystem* GetSpudSystem();
};
