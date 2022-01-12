// Fill out your copyright notice in the Description page of Project Settings.


#include "MyBaseCharacter.h"
#include "AbilitySystemComponent.h"

// Sets default values
AMyBaseCharacter::AMyBaseCharacter()
{
 	// Set this character to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;
	AbilitySystemComponent = CreateDefaultSubobject<UAbilitySystemComponent>(TEXT("AbilitySystemComponent"));
	AbilitySystemComponent->SetIsReplicated(true);
}

void AMyBaseCharacter::PossessedBy(AController* NewController) {
	Super::PossessedBy(NewController);
	verify(AbilitySystemComponent != nullptr);
	AbilitySystemComponent->InitAbilityActorInfo(this, this);
}
FGameplayAbilitySpecHandle AMyBaseCharacter::MyGiveAbility(const FGameplayAbilitySpec& AbilitySpec)
{
	auto ans=GetAbilitySystemComponent()->GiveAbility(AbilitySpec);
	return ans;
}
void AMyBaseCharacter::PreInitializeComponents()
{
	Super::PreInitializeComponents();
	PreInitializeComponentsForLua();
}
// Called when the game starts or when spawned
void AMyBaseCharacter::BeginPlay()
{
	Super::BeginPlay();
	
}

// Called every frame
void AMyBaseCharacter::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);

}

// Called to bind functionality to input
void AMyBaseCharacter::SetupPlayerInputComponent(UInputComponent* PlayerInputComponent)
{
	Super::SetupPlayerInputComponent(PlayerInputComponent);

}

