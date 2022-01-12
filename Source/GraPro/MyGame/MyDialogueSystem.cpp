// Fill out your copyright notice in the Description page of Project Settings.


#include "MyDialogueSystem.h" 
#include "../MyDialogueSystem/MyDialogueSentence.h"
#include "../Common/MyCommonHeader.h" 
#include "MyGameInstance.h"
#include "Kismet/GameplayStatics.h"
#include "SuqsProgression.h" 

void UMyDialogueSystem::Initialize(FSubsystemCollectionBase& Collection) {
	Super::Initialize(Collection);
	UE_LOG(LogJunhao, Log, TEXT("my dialogue subststem ini"));
	
	MyLuaIni(); 
}
USuqsProgression* UMyDialogueSystem::GetSuqsProg() {
	if (suqs_prog == nullptr) {
		auto ga_inst = Cast<UMyGameInstance>(UGameplayStatics::GetGameInstance(this));
		suqs_prog = ga_inst->GetSuqsProg();
		verify(suqs_prog != nullptr);
	}
	return suqs_prog;
}
void UMyDialogueSystem::Deinitialize() {
	Super::Deinitialize();
}

void UMyDialogueSystem::MyInitSpeakerWithDataTables(TArray<UDataTable*> Tables) {
	DT_Speaker = Tables;
	for (auto& t : DT_Speaker) {
		TMap<FName, bool> exist;
		t->ForeachRow<FMyDialogueSpeaker>("", [&,this](const FName& Key, const FMyDialogueSpeaker& sp) {
			//auto sp = sp2;
			//sp.Identifier = Key;
			
			/*
			if (exist.Contains(sp.Identifier)) {
				UE_LOG(LogJunhao, Error, TEXT("dialogue speaker identifier duplicate,identifier:%s"), *sp.Identifier.ToString());
			}
			exist.Add(sp.Identifier, true);
			*/
			speakers.Emplace(sp);
		});
	}
}
void UMyDialogueSystem::MyInitWithDataTables(TArray<UDataTable*> Tables) {
	DialogueDataTables = Tables;
	for (auto& t : DialogueDataTables) {
		t->ForeachRow<FMyDialogueSentence>("", [this](const FName& Key, const FMyDialogueSentence& sent) {
			UE_LOG(LogJunhao, VeryVerbose, TEXT("key:%s"),*Key.ToString());
			auto obj_sent = NewObject<UMyDiaSentSpec>(this);
			obj_sent->SetDefSent(sent);


			bool bSetSpeaker = false;
			auto dia_speaker=sent.RowHandleSpeaker.GetRow<FMyDialogueSpeaker>("");
			if (dia_speaker != nullptr) { 
				obj_sent->SetDefSpeaker(*dia_speaker);
				bSetSpeaker = true;
			}
			/*
			for (auto sp : speakers) {
				if (sp.Identifier.IsEqual(sent.SpeakerIdentifier)) {
					bSetSpeaker = true;
					obj_sent->SetDefSpeaker(sp);
				}
			} 
			if (bSetSpeaker == false) {
				UE_LOG(LogJunhao, Error, TEXT("can not find speaker(id:%s) for dialogue(id:%s)"), *dia_speaker->Identifier.ToString(),*sent.Identifier.ToString());
			}
			*/

			{

				TMap<FName, bool> exist;
				if (sent.Options.Num() > 0) {
					for (auto& opt : sent.Options) {
						if (opt.Identifier.IsNone() == true) continue;
						if (exist.Contains(opt.Identifier)) {
							UE_LOG(LogJunhao, Error, TEXT("option identifier(%s) duplicate in dialogue(id:%s)"), *opt.Identifier.ToString(), *Key.ToString());
						}
						exist.Add(opt.Identifier, true);
					}
				}
			}

			Sentences.Add(obj_sent); 
			obj_sent->SetIdxInSpecArr(Sentences.Num() - 1);
			if (sent.bStartingSentence) {
				/* 
				if (SentName2Idx.Contains(sent.Identifier)) {
					UE_LOG(LogJunhao, Error, TEXT("dialogue starting sentences already exit,identifier:%s"), *sent.Identifier.ToString());
				}
				*/
				SentName2Idx.Emplace(Key, Sentences.Num() - 1);
			}
		});
	}
}
FString UMyDialogueSystem::GetModuleName_Implementation() const {
	return "System.MyDialogueSystem_C";
}

bool UMyDialogueSystem::ExistIdInSpeaker(FName id) {
	bool ans = false;
	for (auto t : DT_Speaker) {
		ans =ans || t->FindRowUnchecked(id) != nullptr;
	}
	/* 
	for (auto sp : speakers) {
		if (sp.Identifier == id) {
			ans = true;
		}
	}
	*/
	return ans;
}
/*
bool UMyDialogueSystem::ExistIdInSentences(FName id) {
	bool ans = false;

	// only starting sentences
	if (SentName2Idx.Contains(id)) {
		ans = true;
	} 
	return ans;
}
*/
// not care bLimit,when id exist,must valid
bool  UMyDialogueSystem::IsDiaActValid(FMyDiaAct dia_act, const FName& Key) {
	bool ans = true;
	/*
	if (!ExistIdInSpeaker(dia_act.IdChar)) {
		UE_LOG(LogJunhao, Error, TEXT("can not find speaker(id:%s) for dialogue activator(row key:%s)"), *dia_act.IdChar.ToString(), *Key.ToString());
		ans = false;
	}
	if (!ExistIdInSpeaker(dia_act.IdNPC)) {
		UE_LOG(LogJunhao, Error, TEXT("can not find speaker(id:%s) for dialogue activator(row key:%s)"), *dia_act.IdNPC.ToString(), *Key.ToString());
		ans = false;
	}
	*/
	/*
	if (!ExistIdInSentences(dia_act.IdSent)) {
		UE_LOG(LogJunhao, Error, TEXT("can not find sentence(id:%s) for dialogue activator(row key:%s)"), *dia_act.RowHandleSent.GetRow<FMyDialogueSen>ToString(), *Key.ToString());
		ans = false;
	}
	*/
	
	for (auto c : dia_act.CondArrQuestAnd.Conds) {
		// id quest need be valid once writed even if bLimitQuest is false
		if (c.IdQuest.IsNone() == false) {
			auto que = GetSuqsProg()->GetQuest(c.IdQuest);
			if (que == nullptr) {
				UE_LOG(LogJunhao, Error, TEXT("can not find quest(id:%s) for dialogue activator(row key:%s)"), *c.IdQuest.ToString(), *Key.ToString());
				ans = false;
			}
			else {
				// assumes always limit when not none
				if (c.IdObj.IsNone() == false) {
					auto obj = que->GetObjective(c.IdObj);
					if (obj == nullptr) {
						UE_LOG(LogJunhao, Error, TEXT("can not find objectivve(id:%s) for dialogue activator(row key:%s)"), *c.IdObj.ToString(), *Key.ToString());
						ans = false;
					}
				}
				if (c.IdTask.IsNone() == false) {
					auto task = que->GetTask(c.IdTask);
					if (task == nullptr) {
						UE_LOG(LogJunhao, Error, TEXT("can not find task(id:%s) for dialogue activator(row key:%s)"), *c.IdTask.ToString(), *Key.ToString());
						ans = false;
					}
				}
			}
		}
	}
	return ans;
}
void UMyDialogueSystem::MyInitDialogueActivatorWithDataTables(TArray<UDataTable*> Tables) {
	DT_DiaActivator = Tables;
	for (auto& t : DT_DiaActivator) {
		t->ForeachRow<FMyDiaAct>("", [this](const FName& Key, const FMyDiaAct& dia_act2) {
			auto dia_act = dia_act2;

			//auto pdia_spk_char=dia_act.RowHandleSpakerChar.GetRow<FMyDialogueSpeaker>("");
			//verify(pdia_spk_char != nullptr);
			//dia_act.IdChar = dia_act.RowHandleSpakerChar.RowName;

			//auto pdia_spk_npc = dia_act.RowHandleSpakerNPC.GetRow<FMyDialogueSpeaker>("");
			//verify(pdia_spk_npc != nullptr);
			//dia_act.IdNPC = dia_act.RowHandleSpakerChar.RowName;
			IsDiaActValid(dia_act, Key);
			
			dia_acts.Emplace(dia_act);
		});
	}
}