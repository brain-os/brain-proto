# AI/ML Design

###### tags: `ml`

> This note define design and implementation aspect of ML functions integration with Brain OS

## AIX Integration
Dependencies
1. ML Flow Docker Container in *Azure Container Registry*
2. Model Specification
    1. Request structure (array index mapping)
    2. Response structure (array index mapping)

![](https://i.imgur.com/2F8d8hD.png)

## Input Events
### Multivariate Input Event - Option 1
```protobuf=
message BrainMultivariateEventSchema {
  map<uint32, BrainModelDataSchema> indexed_value = 1;
}
message BrainModelDataSchema {
  oneof feature_is_one_of {
    jio.brain.proto.base.BrainToken collection = 1; // crop id - in case of entity or low, medium, high for collection
    jio.brain.proto.base.BrainToken attribute = 2; // age of customer
    jio.brain.proto.base.BrainToken feature = 3; // daily sales, monthly purchase
    jio.brain.proto.base.BrainToken context = 4; // morning vs evening
    BrainPayloadType payload_type = 4; // morning vs evening
  }
}
message BrainMultivariateEvent {
  map<uint32, BrainModelDataValue> indexed_value = 1;
}

message BrainModelDataValue {
  oneof value {
    uint64 id = 1; // entity id or collection item
    jio.brain.proto.quantity.BrainQuantity quantity = 2;
    BrainPayload payload = 3;
  }
}
message BrainPayload {
   oneof payload_is_one_of {
    string uri = 3; // can be url or path on hard disk of processed image
    Bytes bytes = 4;
    string base64 = 5; // base64 image
  }
}
enum BrainPayloadType {
  BRAIN_PAYLOAD_TYPE_IMAGE = 0;
  BRAIN_PAYLOAD_TYPE_VIDEO = 1;
  BRAIN_PAYLOAD_TYPE_AUDIO = 2;
  BRAIN_PAYLOAD_TYPE_TEXT = 3;
}
```
### Multivariate Input Event - Option 2
```protobuf=
message BrainFeatureSchema {
  jio.brain.proto.base.BrainToken token = 1;
  jio.brain.proto.quantity.BrainQuantitySchema quantity = 2;
  jio.brain.proto.base.BrainToken unit = 3;
  jio.brain.proto.base.BrainTimeWindowType time_window = 4;
}

message BrainMultivariateEventSchema {
  jio.brain.proto.event.BrainEventKeySchema key = 1;
  map<uint32, jio.brain.proto.feature.BrainFeatureSchema> feature_set = 2; // key = index in array, value = feature schema
}

message BrainMultivariateEvent {
  jio.brain.proto.event.BrainEventKey key = 1;
  map<uint32, jio.brain.proto.quantity.BrainAtomicQuantity> feature_set = 1; // key = index in array, value = Atomic Quantity
}
```
### Image Input Event
```protobuf=
message BrainImageEventSchema {
  jio.brain.proto.event.BrainEventKeySchema key = 1;
  BrainImagePayloadType payload_type = 2;
  map<string, string> meta_data = 3; // type =  (x-ray, ct-scan, mri, spectral) , sub type = (knee, shoulder, etc)
}
message BrainImageEvent {
  jio.brain.proto.event.BrainEventKey key = 1;
  string source_uri = 2; // can be url or path on hard disk of original image
  BrainPayload payload = 3;
}
```
## Output Events
### Classification Function
```protobuf=
message BrainClassificationEventSchema {
  jio.brain.proto.event.BrainEventKeySchema key = 1;
  jio.brain.proto.quantity.BrainSymbolicQuantitySchema symbolic = 2;
}

message BrainClassificationEvent {
  jio.brain.proto.event.BrainEventKey key = 1;
  map<uint64, double> classification = 2; // key is class (symbol or entity) and value is probability (between 0 and 1)
}
```

### Regression Event
```protobuf=
message BrainRegressionEventSchema {
  jio.brain.proto.event.BrainEventKeySchema key = 1;
  jio.brain.proto.quantity.BrainNumericQuantitySchema numeric = 2;
}

message BrainRegressionEvent {
  jio.brain.proto.event.BrainEventKey key = 1;
  BrainNumericQuantity value = 2; 
}
```
### Image Classification
```protobuf=
message BrainImageClassificationEventSchema {
  jio.brain.proto.event.BrainEventKeySchema key = 1;
  jio.brain.proto.quantity.BrainSymbolicQuantitySchema symbolic = 2;
  BrainImagePayloadType payload_type = 3;
  map<string, string> meta_data = 4; // type =  (x-ray, ct-scan, mri, spectral) , sub type = (knee, shoulder, etc)
}

enum BrainImagePayloadType {
  BRAIN_IMAGE_PAYLOAD_TYPE_URI = 0;
  BRAIN_IMAGE_PAYLOAD_TYPE_BYTES = 1;
  BRAIN_IMAGE_PAYLOAD_TYPE_BASE64 = 2;
}

message BrainImageClassificationEvent {
  jio.brain.proto.event.BrainEventKey key = 1;
  map<uint64, double> classification = 2; // key is class (symbol or entity) and value is probability (between 0 and 1)
  string source_uri = 3; // can be url or path on hard disk of original image
  oneof payload_is_one_of {
    string uri = 4; // can be url or path on hard disk of processed image
    Bytes bytes = 5;
    string base64 = 6; // base64 image
  }
}
message Bytes {
  repeated bytes value = 1;
  string content_type = 2;
}
```
### Process Configuration
```protobuf=
message BrainProcessSchema {
  jio.brain.proto.base.BrainToken token = 1;
  string input_topic = 2;
  jio.brain.proto.event.BrainEventSchema input_event_schema = 3;
  map<string, jio.brain.proto.event.BrainEventSchema> output_event_schema = 4; // key = output_topic, value = event key in dictionary
  jio.brain.proto.base.BrainProcessType brain_process_type = 5;
  oneof config {
    BrainEnrichProcessSchema enrich = 6;
    BrainFilterProcessSchema filter = 7;
    BrainPivotProcessSchema pivot = 8;
    BrainReduceProcessSchema reduce = 9;
    BrainIngestProcessSchema ingest = 10;
    BrainQuantizeProcessSchema quantize = 11;
    BrainComputeProcessSchema compute = 12;
    BrainFunctionProcessSchema function = 13; 
    BrainRepositoryProcessSchema repository = 14;
  }
}
message BrainFunctionProcessSchema {
  jio.brain.proto.base.BrainToken function_token = 1;
  BrainModelSpecification model_specification = 3;
  string output_event_schema = 4;
  string output_topic = 5;
}
message BrainModelSpecification {
  map<uint32, BrainModelDataSchema> model_input_spec = 1; // key = index of array, value = entity id, attribute, feature or property
  map<uint32, BrainModelDataSchema> model_output_spec = 2; // key = index of array, value = entity id, attribute, feature or property
}
```
## Agriculture Use Case
1. Classifier as router vs execution framework
2. Process Configuration
3. Reuse pre processors for Image

### Review Event
```protobuf=
message BrainEventKey {
  BrainEntityStore entity_store = 1;
  BrainQuantityStore context_store = 2;
}
message BrainEntityStore {
  // Key = mid(/m/<vertical>/<domain>/entity/<entity-type>)
  // Value = A Set of entities of key type
  // entities[<entity-type>].elements[<entity-id>] = true
  map<uint32, jio.brain.proto.types.BrainEntitySet> entities = 1;
}
message BrainQuantityStore {
  // key = machine_id for whatever role it is playing
  // Note: This is NOT quantity type but the role_type
  // e.g. context, property,
  // e.g. attribute, attribute_qualifier,
  // e.g. predicate, predicate_qualifier
  map<uint32, jio.brain.proto.quantity.BrainQuantity> value = 1;
}
message BrainEventKeySchema {
  BrainEntityStoreSchema entity = 1;
  // key = mid(/m/<vertical>/<domain>/<event>/<context>)
  map<string, BrainEventContextSchema> context = 2;
}
message BrainEntityStoreSchema {
  // key = mid(/m/<vertical>/<domain>/entity/<entity-type>)
  map<string, jio.brain.proto.entity.BrainEntitySchema> entity = 1;
}
message BrainEventContextSchema {
  jio.brain.proto.base.BrainToken token = 1;
  jio.brain.proto.quantity.BrainQuantitySchema quantity = 2;
  // BrainToken unit = 3;
}
```
## AIX Dependency

## Model Repository - Reuse of existing AIX infra
Reuse current way of building model where docker container is output.

## Configuration
Two configurations needed
1. Model Configuration
2. Process Configuration
3. Event Configuration

### Model Configuration
```protobuf=
message BrainModelConfiguration {
  uint32 version = 1;
  BrainMlFrameworkType framework = 2;
  BrainModelFileFormatType model_file_format = 3;
}

enum BrainMlFrameworkType {
  BRAIN_ML_FRAMEWORK_TENSOR_FLOW = 0;
  BRAIN_ML_FRAMEWORK_PYTORCH = 1;
  BRAIN_ML_FRAMEWORK_KERAS = 2;
  BRAIN_ML_FRAMEWORK_WEKA = 3;
}

enum BrainModelFileFormatType {
  BRAIN_MODEL_FILE_FORMAT_PB = 0;
  BRAIN_MODEL_FILE_FORMAT_H5 = 1;
  BRAIN_MODEL_FILE_FORMAT_PKL = 2;
  BRAIN_MODEL_FILE_FORMAT_PMML = 3;
}
```

### Process Configuration
```protobuf=
message BrainProcessSchema {
  jio.brain.proto.base.BrainToken token = 1;
  string input_topic = 2;
  jio.brain.proto.event.BrainEventSchema input_event_schema = 3;
  map<string, jio.brain.proto.event.BrainEventSchema> output_event_schema = 4; // key = output_topic, value = event key in dictionary
  jio.brain.proto.base.BrainProcessType brain_process_type = 5;
  oneof config {
    BrainEnrichProcessSchema enrich = 6;
    BrainFilterProcessSchema filter = 7;
    BrainPivotProcessSchema pivot = 8;
    BrainReduceProcessSchema reduce = 9;
    BrainIngestProcessSchema ingest = 10;
    BrainQuantizeProcessSchema quantize = 11;
    BrainComputeProcessSchema compute = 12;
    BrainImageFunctionProcessSchema function = 13; 
    BrainRepositoryProcessSchema repository = 14;
  }
}
message BrainImageFunctionProcessSchema {
  jio.brain.proto.base.BrainToken function_token = 1;
  jio.brain.proto.base.BrainFunctionType function_type = 2;
  BrainModelSpecification model_specification = 3;
  string output_event_schema = 4;
  string output_topic = 5;
  jio.brain.proto.base.BrainToken model_token = 6;
  jio.brain.proto.ml.BrainImagePreProcessorSet pre_processors = 7;
}
enum BrainFunctionType {
  FUNCTION_TYPE_INTERPRETATION = 0;
  FUNCTION_TYPE_DEEP_LEARNING = 1;
  FUNCTION_TYPE_MACHINE_LEARNING = 2;
  FUNCTION_TYPE_RULE_ENGINE = 3;
  FUNCTION_TYPE_OPTIMIZATION = 4;
}
message BrainModelSpecification {
  map<uint32, BrainModelDataSchema> model_input_spec = 1; // key = index of array, value = entity id, attribute, feature or property
  map<uint32, BrainModelDataSchema> model_output_spec = 2; // key = index of array, value = entity id, attribute, feature or property
}
```
### Event Configuration
```protobuf=
message BrainMultivariateEvent {
  map<uint32, BrainModelDataValue> feature_set = 1;
}

message BrainMultivariateEventSchema {
  map<uint32, BrainModelDataSchema> feature_set = 1;
}
message BrainModelDataSchema {
  oneof feature_is_one_of {
    jio.brain.proto.base.BrainToken collection = 1; // crop id - in case of entity or low, medium, high for collection
    jio.brain.proto.base.BrainToken attribute = 2; // age of customer
    jio.brain.proto.base.BrainToken feature = 3; // daily sales, monthly purchase
    jio.brain.proto.base.BrainToken property = 4; // image data
    jio.brain.proto.base.BrainToken context = 5; // morning vs evening
    jio.brain.proto.base.BrainToken content = 6; // image, video, audio
  }
}
message BrainModelDataValue {
  oneof value {
    uint64 id = 1; // entity id or collection item
    jio.brain.proto.quantity.BrainQuantity quantity = 2;
    jio.brain.proto.content.BrainContent content = 3; // image data
  }
}
```
### Brain Content
https://docs.aws.amazon.com/sagemaker/latest/dg/cdf-training.html
```protobuf=
message BrainContentSchema {
  BrainContentType content_type = 1;
  oneof content {
    BrainImageContentSchema image = 2;
    BrainVideoContentSchema video = 3;
    BrainAudioContentSchema audio = 4;
    BrainTextContentSchema text = 5;
  }
}
message BrainImageContentSchema {
  BrainContentValueType value_type = 2;
  map<string, string> meta_data = 3; // type =  (x-ray, ct-scan, mri, spectral) , sub type = (knee, shoulder, etc)
}
enum BrainContentType {
  BRAIN_CONTENT_IMAGE_TYPE = 0;
  BRAIN_CONTENT_VIDEO_TYPE = 1;
  BRAIN_CONTENT_AUDIO_TYPE = 2;
  BRAIN_CONTENT_TEXT_TYPE = 3;
}
enum BrainContentValueType {
  BRAIN_CONTENT_URL_TYPE = 0;
  BRAIN_CONTENT_FLOAT32_TENSOR_TYPE = 1;
  BRAIN_CONTENT_FLOAT64_TENSOR_TYPE = 2;
  BRAIN_CONTENT_I32_TENSOR_TYPE = 3;
  BRAIN_CONTENT_BYTES_TYPE = 4;
  BRAIN_CONTENT_STRING_TYPE = 5;
}
message BrainContent {
  string source_uri = 1;
  oneof payload_is_one_of {
    string uri = 2; // can be url or path on hard disk
    Float32Tensor float32_tensor = 3;
    Float64Tensor float64_tensor = 4;
    Int32Tensor int32_tensor = 5;
    Bytes bytes = 6;
    string string_value = 7; // base64 image
  }
}
// A sparse or dense rank-R tensor that stores data as doubles (float64).
message Float32Tensor   {
  // Each value in the vector. If keys is empty, this is treated as a
  // dense vector.
  repeated float values = 1 [packed = true];

  // If key is not empty, the vector is treated as sparse, with
  // each key specifying the location of the value in the sparse vector.
  repeated uint64 keys = 2 [packed = true];

  // An optional shape that allows the vector to represent a matrix.
  // For example, if shape = [ 10, 20 ], floor(keys[i] / 20) gives the row,
  // and keys[i] % 20 gives the column.
  // This also supports n-dimensonal tensors.
  // Note: If the tensor is sparse, you must specify this value.
  repeated uint64 shape = 3 [packed = true];
}

// A sparse or dense rank-R tensor that stores data as doubles (float64).
message Float64Tensor {
  // Each value in the vector. If keys is empty, this is treated as a
  // dense vector.
  repeated double values = 1 [packed = true];

  // If this is not empty, the vector is treated as sparse, with
  // each key specifying the location of the value in the sparse vector.
  repeated uint64 keys = 2 [packed = true];

  // An optional shape that allows the vector to represent a matrix.
  // For example, if shape = [ 10, 20 ], floor(keys[i] / 10) gives the row,
  // and keys[i] % 20 gives the column.
  // This also supports n-dimensonal tensors.
  // Note: If the tensor is sparse, you must specify this value.
  repeated uint64 shape = 3 [packed = true];
}

// A sparse or dense rank-R tensor that stores data as 32-bit ints (int32).
message Int32Tensor {
  // Each value in the vector. If keys is empty, this is treated as a
  // dense vector.
  repeated int32 values = 1 [packed = true];

  // If this is not empty, the vector is treated as sparse with
  // each key specifying the location of the value in the sparse vector.
  repeated uint64 keys = 2 [packed = true];

  // An optional shape that allows the vector to represent a matrix.
  // For Exmple, if shape = [ 10, 20 ], floor(keys[i] / 10) gives the row,
  // and keys[i] % 20 gives the column.
  // This also supports n-dimensonal tensors.
  // Note: If the tensor is sparse, you must specify this value.
  repeated uint64 shape = 3 [packed = true];
}

// Support for storing binary data for parsing in other ways (such as JPEG/etc).
// This is an example of another type of value and may not immediately be supported.
message Bytes {
  repeated bytes value = 1;

  // If the content type of the data is known, stores it.
  // This allows for the possibility of using decoders for common formats
  // in the future.
  optional string content_type = 2;
}
```
### Pre Processor
```protobuf=
message BrainImagePreProcessorSet {
  repeated BrainImagePreProcessor pre_processor_set = 1;
}

message BrainImagePreProcessor {
  oneof pre_processor {
    BrainImageResizer resizer = 1;
    BrainImageColorConversion color_conversion = 2;
    BrainImageCropping cropping = 3;
    BrainImageAdjustment adjustment = 4;
    BrainImageTranspose transpose = 5;
  }
}

message BrainImageResizer {
  uint32 height = 1;
  uint32 width = 2;
  uint32 padding = 3;
}

message BrainImageColorConversion {
  BrainImageColorConversionType source = 1;
  BrainImageColorConversionType target = 2;
}

enum BrainImageColorConversionType {
  BRAIN_IMAGE_COLOR_TYPE_RGB = 0;
  BRAIN_IMAGE_COLOR_TYPE_GRAY_SCALE = 1;
  BRAIN_IMAGE_COLOR_TYPE_HSV = 2;
  BRAIN_IMAGE_COLOR_TYPE_YIQ = 3;
  BRAIN_IMAGE_COLOR_TYPE_YUV = 3;
}

message BrainImageCropping {
  uint32 x_coordinate = 1;
  uint32 y_coordinate = 2;
  uint32 height = 3;
  uint32 width = 4;
}

message BrainImageAdjustment {

}
message BrainImageTranspose {

}
```
## Side Car Container in :brain:Brain OS
https://www.containiq.com/post/kubernetes-sidecar-container
https://www.techtarget.com/searchapparchitecture/tip/The-reasons-to-use-or-not-use-sidecars-in-Kubernetes
### Image Functions
![](https://i.imgur.com/lvvt69s.png)

### Other ML Functions (Rules and Others)


## :memo: Kubernetes Enviornment
### :car: Side Car Containers
Most time there is one container per pod. Side car container is use case where there can be more than one containers per pod.

Multi container pods are following use cases.

- [ ] Applications Designed to Share Storage or Networks
- [ ] Main Application and Logging Application
- [ ] Application in two different languages
- [ ] Keeping Application Configuration Up to Date

### Examples
### Istio
![](https://i.imgur.com/Jyr8zTH.png)

#### Combining encryptic vs unencrypted traffic
![](https://i.imgur.com/UtfRvmj.png)


