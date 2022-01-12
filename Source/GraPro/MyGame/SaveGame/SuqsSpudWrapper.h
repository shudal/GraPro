#pragma once
#include "CoreMinimal.h"

#include "ISpudObject.h"
#include "SuqsProgression.h"
#include "UObject/Object.h"
#include "SuqsSpudWrapper.generated.h"

UCLASS()
class GRAPRO_API USuqsSpudWrapper :
    public UObject, public ISpudObjectCallback
{
    GENERATED_BODY()
protected:
		UPROPERTY()
			USuqsProgression* Progression;
public:

	/// Initialise this wrappe with the progression object it will be tracking.
	void Init(USuqsProgression* InProgression);

	virtual void SpudStoreCustomData_Implementation(const USpudState* State, USpudStateCustomData* CustomData) override;
	virtual void SpudRestoreCustomData_Implementation(USpudState* State, USpudStateCustomData* CustomData) override;
};

