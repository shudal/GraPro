#pragma once
#include "CoreMinimal.h"

#include "Engine/DataTable.h"

#include "MyDialogueSentence.generated.h"

UENUM(BlueprintType)
enum class EMyDialogueOptionAction : uint8
{
    JMP,
    Quit,
};
USTRUCT(BlueprintType)
struct GRAPRO_API FMyDialogueOption {

    GENERATED_BODY()
public:

    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        FText Description;

    /// <summary>
    /// if not none, should be unique logically,because this used to broadcast which option made
    /// </summary>
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        FName Identifier;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        EMyDialogueOptionAction Action;
    /// <summary>
    /// used when aciton is jmp
    /// </summary>
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        int JmpOffset;
};

USTRUCT(BlueprintType)
struct GRAPRO_API FMyDialogueSpeaker : public FTableRowBase {
    GENERATED_USTRUCT_BODY()
public:
    /*
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        FName Identifier;
        */
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        FText SpeakerName;
};
UENUM(BlueprintType)
enum class EDialogueSentenceClickAction : uint8
{ 
    ToNextRow,
    Quit,
};
USTRUCT(BlueprintType)
struct GRAPRO_API FMyDialogueSentence :
    public FTableRowBase
{
    GENERATED_USTRUCT_BODY()
public:
    FMyDialogueSentence();
    /// <summary>
    /// should be unique globally within starting sentences
    /// </summary>
    /*
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        FName Identifier; 
    */

    /// <summary>
    /// whether this sentence is starting place of a dialogue
    /// </summary>
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        bool bStartingSentence;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        FText Content;

    /*
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        FName SpeakerIdentifier;
    */
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
    FDataTableRowHandle RowHandleSpeaker;


    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        TArray<FMyDialogueOption> Options;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "AutoNext")
        bool bAutoNext;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "AutoNext")
        float AutoToNextDelayTime;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        EDialogueSentenceClickAction ClickAction;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Dialogue")
        bool bBroadCastOptionMade;

    
};

