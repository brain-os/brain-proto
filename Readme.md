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