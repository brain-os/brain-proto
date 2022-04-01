# Model Protos
This directory contains protos that allow creation of a Model and adding versions of the same. 

# Integration
The Image below shows how AIX will be invoked through BrainOS
![Here](https://github.com/brain-os/brain-proto/blob/model-storage/jio/brain/proto/model/Aix%20Function%20Invocation.svg) 

# Important Protos
The following are the important entities that make up the model management services. 

1. **Model** - *[Start here](https://github.com/brain-os/brain-proto/edit/model-storage/jio/brain/proto/model/model.proto) for exploring different entities and their services*
2. **API Definition**  - *Think of this as the problem that the model is a solution to. For example Object Detection in Image etc etc*
3. **Model Author** - *Think of this as a user of the system currently with minimal information*
4. **Input Transformation** - *Think of this as mapping of API parameters to the format that the model expects*
5. **Output Transformation** - *Think of this as mapping of Model's Output to API's output parameters*
6. **Preprocessor** - *Think of this as a chain of pre-built functions that allow intercepting and modifying input of the model just before invocation*

Different Messages and services that allow managing the above entities are organized in different proto files. 

Some of the above need persisted files which are stored in [Article Store](https://github.com/brain-os/brain-proto/edit/model-storage/jio/brain/proto/stores/article_store.md)

## Models
Models are organized into the following

1.  ModelGroup
2.  ModelVariant
3.  Model Version

The Important attributes of these messages are depicted in the hierarchy below. 
```
//
//
//       +-------------------------->   HttpVariant
//      /  (oneof)
//     /                                                     1:N
// ModelGroup ---------------------->   ModelVariant --------------------------> ModelVersion
//     |                                      |                                     |
//     +--  Contributed by a Model Author     |                                     +---- Change Note
//     |                                      +--- Input Transformation             |
//     +--  Implements a specific API         |                                     +---- Persistent File ID 
//                                            +--- Output Transformation 
//                                            |
//                                            +--- Model Information 
//                                            |
//                                            +--- PreProcessor
//                                            |
//                                            +--- Config Param Values
//                                            |
//                                            +--- Pricing

```


## API Definition

```
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
```
