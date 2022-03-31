# Message Hierarchy

## Models
Models are organized into the following

1.  ModelGroup
2.  ModelVariant
3.  Model Version

The Important attributes of these messages are depicted in the hierarchy below. 
```
                     1:1                                     1:N
 ModelGroup   ------------------->   ModelVariant --------------------------> ModelVersion
     |                                      |                                     |
     +--  Contributed by a Model Author     |                                     +---- Change Note
     |                                      +--- Input Transformation             |
     +--  Implements a specific API         |                                     +---- Persistent File ID 
                                            +--- Output Transformation 
                                            |
                                            +--- Model Information 
                                            |
                                            +--- PreProcessor
                                            |
                                            +--- Config Param Values
                                            |
                                            +--- Pricing

```


## API Definition


//                       1:1                                          1:1
// ApiDefintion   ------------------->   ApiDefinitionDetails --------------------------> ApiDefinitionMetadata
//     |                                      |                                               |
//     +--  api_id                            | 1:N                                           +---- name/description/tags/domain/dataTypes/apiType
//     |                                      +------ Api Input Fields                        
//     +--  enabled/disabled                  | 1:N                                           
//     |                                      +------ Api Output Fields
//     +-- created/modifiedAt                 |
//                                            +------ HealthCheckTests
//                                            |
//                                            +------ BenchmarkingTests
//                                            |
//                                            +------ Code Snippets
//
