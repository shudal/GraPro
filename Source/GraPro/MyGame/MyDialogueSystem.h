// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Subsystems/GameInstanceSubsystem.h"
#include "Engine/DataTable.h"
#include "../MyDialogueSystem/MyDiaSentSpec.h"
#include "../MyDialogueSystem/MyDiaAct.h"
#include "UnLuaInterface.h"
#include "MyDialogueSystem.generated.h"

DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FDelegateMyDialogueComplete, FName, IdStartSent);

DECLARE_DYNAMIC_MULTICAST_DELEGATE_TwoParams(FDelegateMyDialogueOptMade, FName, IdStartSent, FName, IdOpt);
class USuqsProgression;


/**
 * 
 */
UCLASS()
class GRAPRO_API UMyDialogueSystem : public UGameInstanceSubsystem,public IUnLuaInterface
{
	GENERATED_BODY()

private:

    USuqsProgression* GetSuqsProg();
protected:
    UPROPERTY(BlueprintReadWrite,EditAnywhere)
        TArray<UDataTable*> DialogueDataTables;
    UPROPERTY(BlueprintReadWrite, EditAnywhere)
        TArray<UDataTable*> DT_Speaker;
    UPROPERTY(BlueprintReadWrite, EditAnywhere)
        TArray<UDataTable*> DT_DiaActivator;


    UPROPERTY(BlueprintReadWrite, EditAnywhere)
        TArray<UMyDiaSentSpec*> Sentences;
    UPROPERTY(BlueprintReadWrite, EditAnywhere)
        TMap<FName, int32> SentName2Idx;
    UPROPERTY(BlueprintReadWrite, EditAnywhere)
        TArray<FMyDialogueSpeaker> speakers;
    UPROPERTY(BlueprintReadWrite, EditAnywhere)
        TArray<FMyDiaAct> dia_acts;
    UPROPERTY(BlueprintReadWrite, EditAnywhere)
        USuqsProgression* suqs_prog;

public:
    // Begin USubsystem
    virtual void Initialize(FSubsystemCollectionBase& Collection) override;
    virtual void Deinitialize() override; 

    UFUNCTION(BlueprintCallable)
        void MyInitSpeakerWithDataTables(TArray<UDataTable*> Tables);
    UFUNCTION(BlueprintCallable)
    void MyInitWithDataTables(TArray<UDataTable*> Tables);
    UFUNCTION(BlueprintCallable)
        void MyInitDialogueActivatorWithDataTables(TArray<UDataTable*> Tables);
    
    virtual FString GetModuleName_Implementation() const override;

    UFUNCTION(BlueprintImplementableEvent)
        bool StartDialogue(const FString & StartingIdentifier);
    UFUNCTION(BlueprintImplementableEvent)
        void MyLuaIni();

    UFUNCTION(BlueprintCallable)
        bool ExistIdInSpeaker(FName id);
        /*
    UFUNCTION(BlueprintCallable)
        bool ExistIdInSentences(FName id);
        */
    UFUNCTION(BlueprintCallable)
        bool IsDiaActValid(FMyDiaAct dia_act, const FName& Key);

    UFUNCTION(BlueprintImplementableEvent)
    bool CanActDiaByNameId(const FName& id_char,const FName& id_npc);

    UPROPERTY(BlueprintReadWrite, EditAnywhere)
    FDelegateMyDialogueComplete DelegateMyDiaComp;
    UPROPERTY(BlueprintReadWrite, EditAnywhere)
    FDelegateMyDialogueOptMade DelegateMyOptMade; 
};
