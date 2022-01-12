
#include "MyInventoryItem.h"

void UMyItemWeaponSpec::MySetItem(FMyItemWeapon it, FName k) {
	item = it; 
	RowKey = k; 

	level = 1; 
}