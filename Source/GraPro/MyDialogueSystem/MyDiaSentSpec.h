#pragma once


#include "CoreMinimal.h"
#include "MyDialogueSentence.h"
#include "MyDiaSentSpec.generated.h"

UCLASS()
class GRAPRO_API UMyDiaSentSpec :
    public UObject
{
    GENERATED_BODY()
protected:
    UPROPERTY(BlueprintReadWrite, EditAnywhere)
    FMyDialogueSentence def_sent;
    UPROPERTY(BlueprintReadWrite, EditAnywhere)
    FMyDialogueSpeaker def_speaker;

    UPROPERTY(BlueprintReadWrite, EditAnywhere)
    int IdxInSpecArr;
public:
    UMyDiaSentSpec() = default;
    UMyDiaSentSpec(const FMyDialogueSentence& sent);
    UFUNCTION(BlueprintCallable)
    void SetDefSent(const FMyDialogueSentence& sent);
    UFUNCTION(BlueprintCallable)
        void SetDefSpeaker(const FMyDialogueSpeaker& sp) { def_speaker = sp; }
    UFUNCTION(BlueprintCallable)
        FMyDialogueSentence GetDefDiaSent() { return def_sent; }
    UFUNCTION(BlueprintCallable)
        FMyDialogueSpeaker GetDefSpeaker() { return def_speaker;  }

    UFUNCTION(BlueprintCallable)
        void SetIdxInSpecArr(int x) { IdxInSpecArr = x; }
    UFUNCTION(BlueprintCallable)
        int GetIdxInSpecArr() { return IdxInSpecArr; }

};

