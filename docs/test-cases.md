## Symbolic
### Builder
SymbolicQuantityBuilder
Return : BrainQuantity

Given 
Schema : BRAIN_TYPE_SYMBOL_KEY (BrainQuantity set string)
Index : IndexService

set(String) - simple set
set (int) - index lookup
set (long) - index lookup + cast
setIndex (int) - index lookup

Given
Schema : BRAIN_TYPE_SYMBOL_I32 (BrainQuantity set i32)
Index : IndexService

set (String) - index lookup
set (int) - simple set
set (long) - simple set
setIndex (int) - simple set 

Given
Schema : BRAIN_TYPE_SYMBOL_I64 (BrainQuantity set i64)
Index : IndexService

set (String) - index lookup
set (int) - simple set + cast
set (long) - simple set
setIndex (int) - simple set + cast

Given
Schema : BRAIN_TYPE_SYMBOL_IDX (BrainQuantity set idx)
Index : IndexService

set (String) - simple set
set (int) - index lookup
set (long) - index lookup + cast
setIndex (int) - index lookup

### SymbolicQuantityService
String getKey(Schema, BrainQuantity)
Given
Schema : BRAIN_TYPE_SYMBOL_I64 (BrainQuantity set i64)
BrainQuantity should have long
Lookup in IndexService and return Key

... same as above
int getI32(Schema, BrainQuantity)
long getI64(Schema, BrainQuantity)
int getIndex(Schema, BrainQuantity)
