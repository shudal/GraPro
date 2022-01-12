// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Character.h"
#include "AbilitySystemInterface.h"
#include "GameplayAbilitySpec.h"
#include "MyBaseCharacter.generated.h"


class UAbilitySystemComponent;
UCLASS()
class GRAPRO_API AMyBaseCharacter : public ACharacter, public IAbilitySystemInterface
{
	GENERATED_BODY()

public:
	// Sets default values for this character's properties
	AMyBaseCharacter();

protected:
	UAbilitySystemComponent* AbilitySystemComponent;
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;

public:	
	// Called every frame
	virtual void Tick(float DeltaTime) override;

	// Called to bind functionality to input
	virtual void SetupPlayerInputComponent(class UInputComponent* PlayerInputComponent) override;

	virtual void PossessedBy(AController* NewController) override;

	UAbilitySystemComponent* GetAbilitySystemComponent() const { return AbilitySystemComponent; }

	UFUNCTION(BlueprintCallable)
	FGameplayAbilitySpecHandle MyGiveAbility(const FGameplayAbilitySpec& AbilitySpec);

	virtual void PreInitializeComponents() override;

	UFUNCTION(BlueprintImplementableEvent)
	void PreInitializeComponentsForLua();
};
