#pragma once

#include "CoreMinimal.h"

#include "Engine/DataTable.h"
#include "Styling/SlateBrush.h"
#include "../Item/Weapon/MyWeaponBase.h"
#include "MyInventoryItem.generated.h"


class UGameplayAbility;
class UGameplayEffect;
UENUM(BlueprintType)
enum class EMyInventoryItemType : uint8
{
    Weapon,
    Potion,
};
USTRUCT(BlueprintType)
struct GRAPRO_API FMyInventoryItemBase :
    public FTableRowBase
{
    GENERATED_BODY()
public:
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Base")
        EMyInventoryItemType ItemType;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Base")
        FSlateBrush ItemIcon;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Base")
        FText ItemName;
    UPROPERTY(EditDefaultsOnly, BlueprintReadOnly, Category = "Base")
        FText ItemDescription;
    /// <summary>
    /// meaning diffs 
    /// </summary>
    UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = Weapon)
        bool bConsumable;
};
USTRUCT(BlueprintType)
struct GRAPRO_API FMyItemWeapon :
    public FMyInventoryItemBase
{
    GENERATED_BODY()
public:
    UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = Weapon)
        bool bHasAct;
    UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = Weapon)
        TSubclassOf<AMyWeaponBase> WeaponActor;

    UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = Abilities)
        TSubclassOf<UGameplayAbility> GrantedAbility;
};
USTRUCT(BlueprintType)
struct GRAPRO_API FMyItemPotion :
    public FMyInventoryItemBase
{
    GENERATED_BODY()
public:
    UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "Potion")
        TSubclassOf<UGameplayEffect> GamePlayEffect;
    UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "Potion")
        int32 level;
};
 
UCLASS(BlueprintType)
class GRAPRO_API UMyItemSpec : public UObject {
    GENERATED_BODY()
protected: 
    FName RowKey; 
public: 
    UFUNCTION(BlueprintCallable)
        FName GetRowKey() { return RowKey; }

    bool operator==(const UMyItemSpec& other) const { return RowKey == other.RowKey; }
};

UCLASS(BlueprintType)
class GRAPRO_API UMyItemWeaponSpec : public UMyItemSpec {
    GENERATED_BODY()
protected:
    FMyItemWeapon item;
    UPROPERTY(EditAnywhere, BlueprintReadOnly, Category = "Potion")
        int32 level;
public:
    UFUNCTION(BlueprintCallable)
    int32 MyGetLevel() { return level; }
    UFUNCTION(BlueprintCallable)
    void MySetLevel(int32 x) { level = x; }
    UFUNCTION(BlueprintCallable)
        void MySetItem(FMyItemWeapon it, FName k);

    UFUNCTION(BlueprintCallable)
        FMyItemWeapon MyGetItem() { return item; }
};