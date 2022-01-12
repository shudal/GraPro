// Fill out your copyright notice in the Description page of Project Settings.


#include "MyWeaponBase.h"
#include "Components/SkeletalMeshComponent.h"

// Sets default values
AMyWeaponBase::AMyWeaponBase()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;
	SKM_Weapon = CreateDefaultSubobject<USkeletalMeshComponent>("skm_weapon");
	SetRootComponent(SKM_Weapon);
}

// Called when the game starts or when spawned
void AMyWeaponBase::BeginPlay()
{
	Super::BeginPlay();
	
}

// Called every frame
void AMyWeaponBase::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);

}

