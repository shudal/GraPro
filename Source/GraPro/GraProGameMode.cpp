// Copyright Epic Games, Inc. All Rights Reserved.

#include "GraProGameMode.h"
#include "GraProCharacter.h"
#include "UObject/ConstructorHelpers.h"

AGraProGameMode::AGraProGameMode()
{
	// set default pawn class to our Blueprinted character
	static ConstructorHelpers::FClassFinder<APawn> PlayerPawnBPClass(TEXT("/Game/ThirdPersonCPP/Blueprints/ThirdPersonCharacter"));
	if (PlayerPawnBPClass.Class != NULL)
	{
		DefaultPawnClass = PlayerPawnBPClass.Class;
	}
}
