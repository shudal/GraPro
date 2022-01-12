#include "MyDiaSentSpec.h"


UMyDiaSentSpec::UMyDiaSentSpec(const FMyDialogueSentence& sent) {
	this->def_sent = sent;
}
void UMyDiaSentSpec::SetDefSent(const FMyDialogueSentence& sent) {
	this->def_sent = sent;
}