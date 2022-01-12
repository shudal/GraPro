#include "SuqsSpudWrapper.h"

void USuqsSpudWrapper::Init(USuqsProgression* InProgression)
{
	Progression = InProgression;
}

void USuqsSpudWrapper::SpudStoreCustomData_Implementation(const USpudState* State, USpudStateCustomData* CustomData)
{
	if (Progression)
	{
		Progression->Serialize(*CustomData->GetUnderlyingArchive());
	}

}

void USuqsSpudWrapper::SpudRestoreCustomData_Implementation(USpudState* State, USpudStateCustomData* CustomData)
{
	if (Progression)
	{
		Progression->Serialize(*CustomData->GetUnderlyingArchive());
	}
}