## Discussion

1. Unique index (int32) for all building blocks
    1. events
    1. entities
    1. predicates
    1. properties
    1. contexts
    1. symbol, ordinal, bin in quantities
1. This should be auto assigned during **creation** and always be part of configs
1. In case of deletion - deleted indexes cannot be reused
1. Indexes will have mapping at dictionary level
1. Define index ranges for different building blocks
1. Once created it is immutable for that specific event/entity/predicate/property/context
1. It will simplify schemas for events, entities and predicates
   1. It will help in readability of logs
   1. It will simplify BrainIndex significantly 
   1. BrainIndex is brittle on addition/deletion of values
   
```protobuf
syntax = "proto3";
message BrainQuantityConfigDictionary {
    string vertical = 1; 
    repeated BrainDictionaryConfig dictionary = 2;
    repeated BrainQuantityConfig quantity = 3;
}
message BrainDictionaryConfig {
   oneof dictionary_config_is_one_of {
      string entity = 1; // all ids of village
      string name = 2; // referring to BrainList defined at dictionary level
      BrainList list = 3;  // Locally defined or cached from global from name above or list of entities
   }
}
message BrainList {
  string name = 1;
   oneof brain_list {
      BrainItemList item_list = 2;
      BrainIndexList index_list = 3;
      BrainEntityList entity_list = 4;
   }
}
message BrainItemList {
   repeated string item = 1;
}
message BrainIndexList {
   repeated uint32 index = 2;
}
message BrainEntityList {
   repeated string entity = 3;
}
message BrainQuantityConfig {
   string name = 1;
   string unit = 2;
   string type = 3;
   // one of 
   // BrainSymbolicQuantityConfig
   // numeric, 
   // symbolic ....
}
message BrainSymbolicQuantityConfig {
   BrainDictionaryConfig dictionary = 1;
}
```