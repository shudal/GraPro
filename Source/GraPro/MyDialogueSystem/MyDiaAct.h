#pragma once
#include "CoreMinimal.h"

#include "Engine/DataTable.h"
#include "SuqsQuestState.h"
#include "SuqsObjectiveState.h"
#include "SuqsTaskState.h"
#include "MyDialogueSentence.h"
#include "MyDiaAct.generated.h"
 
 

USTRUCT(BlueprintType)
struct GRAPRO_API FDiaActCondQuestSimple
{
    GENERATED_BODY()
public: 
    FDiaActCondQuestSimple() { bNegate = false; }
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Quest")
        FName IdQuest;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Quest")
        FName IdObj;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Quest")
        FName IdTask;

    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Limit")
        bool bLimitQuest;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Limit")
        bool bLimitObj;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Limit")
        bool bLimitTask;

    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Quest")
        ESuqsQuestStatus StaQue;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Quest")
        ESuqsObjectiveStatus StaObj; 
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Quest")
        ESuqsTaskStatus StaTask;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Negate")
        bool bNegate;
};

USTRUCT(BlueprintType)
struct GRAPRO_API FDiaActCondArrQuestAnd
{
    GENERATED_BODY()
public:
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
    TArray<FDiaActCondQuestSimple> Conds;
};

class UDiaActCond;
USTRUCT(BlueprintType)
struct GRAPRO_API FMyDiaAct : public FTableRowBase
{
    GENERATED_USTRUCT_BODY()
public: 
    /* 
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        FName IdChar;
    */
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        FDataTableRowHandle RowHandleSpeakerChar; 
     
    /* 
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        FName IdNPC;
    */
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        FDataTableRowHandle RowHandleSpeakerNPC;
    /* 
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        FName IdSent;
    */
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        FDataTableRowHandle RowHandleSent;

    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        FDiaActCondArrQuestAnd CondArrQuestAnd;
     
};

