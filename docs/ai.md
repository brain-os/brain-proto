# Machine Learning, Deep Learning and Rule Functions
> All functions will be stored in schema service. In case of rule they will be added by remote engine (grpc call), in case of ML they will be added using brain work bench ???

## Deployment
1. Rule engine will be deployed as separate service with URL and port (Rest or GRPC)
2. For ML there are two possibilities
   1. In process (Docker container in k8s) - will it be part of auto deployment from UI?
      1. Init - model is loaded from model repository based on function id
      2. Brain event - quantities are converted to primitive types
      3. Model is invoked
      4. Results are wrapped into brain quantity and added to output Brain event
   2. Remote invocation (Remote web service)
      1. Brain event - quantities are converted to primitive types
      2. Remote API is called
      3. Response is wrapped into brain quantity and added to output Brain event
## Open questions
1. How to model output of inference functions and role of feature lake
2. How to model output of interpretation functions and role of feature lake. How to respond to real time queries within context of BrainOS? e.g. Krishi App - Input and Output. Thinking beyond feature lake and delta service
3. Pre processing and post processing of images and video
4. How to implement Meta API - Output of 1 model go as input of other e.g. (Can we use delta service infrastructure)
   1. Rules
   2. ddhp model 
   3. alexa (speech to text => NLP(POS, entity recogniser) => answer => text to speech )
5. How to respond to real time queries within context of BrainOS? e.g. Krishi App - Input and Output. Thinking beyond feature lake and delta service
6. Ensemble methods (stacking, boosting, bagging)

## Input Event
Image or Media will be bound to topics
```protobuf
message BrainEventValue {
  BrainEntityStore entity_store = 1; // camera id, farmer id
  BrainQuantityStore property_store = 2; // media quantity, timestamp of image
  BrainAttributeStore attribute_store = 3;
  BrainEntityPredicateStore predicate_store = 4;
}
message BrainQuantity {
  oneof quantity_is_one_of {
    BrainAtomicQuantity atomic = 1;
    BrainCompoundQuantity compound = 2;
    BrainTemporalQuantity temporal = 3;
    BrainSpatialQuantity spatial = 4;
    BrainMediaQuantity media = 5;
  }
}
message BrainMediaQuantity {
  oneof media_is_one_of {
    BrainTextQuantity text = 1;
    BrainDocumentQuantity document = 2;
    BrainVideoQuantity video = 3;
    BrainAudioQuantity audio = 4;
    BrainImageQuantity image = 5;
  }
}
message BrainTextQuantity {
  string encoding = 1;
  BrainLanguageType language = 2; // en, hn, sp
  BrainTextType text_type = 3; // tweet, review comment, chat
  string text = 4; // actual content
}
message BrainPayload {
  oneof payload_is_one_of {
    bytes payload = 1;
    string url = 2;
  }
}
message BrainDocumentQuantity {
  BrainDocumentType document_type = 1; // word, excel, docs
  BrainPayload payload = 2; // url or bytes
}
message BrainVideoQuantity {
  BrainVideoFormat video_format = 1; // mpeg4, mov
  BrainPayload payload = 2; // url or bytes
}
message BrainAudioQuantity {
  BrainAudioFormat audio_format = 1; // mp3, wav
  BrainPayload payload = 2; // url or bytes
}
message BrainImageQuantity {
  BrainImageFormat format = 1; // png, jpeg
  BrainPayload payload = 2; // url or bytes
}
message BrainMediaQuantitySchema {
  oneof media_is_one_of {
    BrainTextQuantitySchema text = 1;
    BrainDocumentQuantitySchema document = 2;
    BrainVideoQuantitySchema video = 3;
    BrainAudioQuantitySchema audio = 4;
    BrainImageQuantitySchema image = 5;
  }
}
message BrainTextQuantitySchema {
  BrainTextType default_text_type = 1; // tweet/chat/email
  BrainLanguageType default_language = 2; // english/hindi
  BrainTextEncoding default_encoding = 3; // utf16, utf8, ascii
}
message BrainDocumentQuantitySchema {
  BrainDocumentType default_document_type = 1; // invoice/aadhaar/pan
  BrainDocumentFormat default_document_format = 2; // pdf/word/excel
  BrainPayloadType default_payload_type = 3;
}
message BrainVideoQuantitySchema {
  BrainVideoFormat default_video_format = 1; //mpeg,mov
  BrainPayloadType default_payload_type = 2;
}
message BrainAudioQuantitySchema {
  BrainAudioFormat default_audio_format = 1; // wav,mp3
  BrainPayloadType payload_type = 2;
}
message BrainImageQuantitySchema {
  BrainImageFormat image_format = 1;
  BrainPayloadType payload_type = 2;
}
```