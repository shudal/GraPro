// Fill out your copyright notice in the Description page of Project Settings.


#include "MyGameInstance.h"
#include "SuqsProgression.h"  
#include "MyDialogueSystem.h"
#include "../Common/MyCommonHeader.h"
#include "SaveGame/SuqsSpudWrapper.h"
#include "SpudSubsystem.h"

UMyGameInstance::UMyGameInstance() {
	//suqs_prog = NewObject<USuqsProgression>(this,FName(TEXT("suqs_prog")));
	//suqs_prog = CreateDefaultSubobject<USuqsProgression>(TEXT("suqs_prog"));
	//UE_LOG(LogClass, Log, TEXT("suqs_prog null?%d"), suqs_prog == nullptr ? 1 : 0);
}
void UMyGameInstance::Init() { 
	Super::Init();
	suqs_prog = NewObject<USuqsProgression>(this,FName(TEXT("suqs_prog")));
	//suqs_prog = CreateDefaultSubobject<USuqsProgression>(TEXT("suqs_prog"));
 
	UE_LOG(LogClass, Log, TEXT("suqs_prog null?%d"), suqs_prog == nullptr ? 1 : 0);
	 
	QuestSpudWrapper = NewObject<USuqsSpudWrapper>();
	QuestSpudWrapper->Init(suqs_prog);

	// Tell SPUD to store the wrapper, which will store the quest data too
	auto Spud = GetSpudSubsystem(GetWorld());
	Spud->AddPersistentGlobalObjectWithName(QuestSpudWrapper, "QuestProgression");
	//auto Spud = GetSpudSubsystem(GetWorld());
	//Spud->AddPersistentGlobalObjectWithName(QuestSpudWrapper, "QuestProgression");
	//Spud->AddPersistentGlobalObjectWithName(this, "MyGameInst");


	//MyLuaIni();
}

UMyDialogueSystem* UMyGameInstance::GetMyDialogueSys() {
	auto sys= GetSubsystem<UMyDialogueSystem>();
	UE_LOG(LogJunhao, Log, TEXT("dialogue sys is null?%d"), sys == nullptr ? 1 : 0);
	return sys;
}

USpudSubsystem* UMyGameInstance::GetSpudSystem() {
	auto sys = GetSubsystem<USpudSubsystem>();
	UE_LOG(LogJunhao, Log, TEXT("spud sys is null?%d"), sys == nullptr ? 1 : 0);
	return sys;
}