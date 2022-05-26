# Data representation
[Language Mapping](https://developers.google.com/protocol-buffers/docs/proto3#scalar)

## Constraints
1. Only time series data (For attribute qualifier)
2. Limited support to predicate

## Tables
1. key (Sha256) to event key
2. function to features
3. features to functions
4. key to feature (main table)
5. entity id to event key

## Data Stores
1. entity - arango
2. features - mongo
3. time series - influx
4. Profile - mongo

## Translation Layer
1. Feature(BrainQuantity) to primitive
2. Primitives to features (BrainQuantity)

### Supported feature quantities
| BrainQuantity        | Protobuf Scaler | Assigned Type | Default Datastore   | Notes   |
| ------------------   | --------------- |------------- |------------- |------------- |
| BrainBinaryQuantity   | bool   | boolean   | Any |      |
| BrainNumericQuantity   | int,unit,sint,fixed,sfixed   | long   | Any |      |
| BrainNumericQuantity   | float, double   | double       | Any |      |
| BrainSymbolicQuantity  |  unit64       |   long     | Any |      |
| BrainSymbolicQuantity  |  string       |   String     | Any |      |
| BrainOrdinalQuantity  |  unit64       |   long     | Any |      |
| BrainOrdinalQuantity  |  string       |   String     | Any |      |
| BrainBinnedQuantity  |  unit64       |   long     | Any |      |
| BrainBinnedQuantity  |  string       |   String     | Any |      |
| BrainTemporalInstanceQuantity  |   google/protobuf/timestamp.proto    |   long     | Any |  Epoch    |
| BrainTemporalRangeQuantity  |  google/protobuf/timestamp.proto     |   long,long     | Any | array of length 2 of long |
| BrainTemporalDurationQuantity  |  google/protobuf/timestamp.proto   |   long     | Any |  in milliseconds    |
| BrainTemporalContextQuantity  |  google/protobuf/timestamp.proto   |   long     | Any |  Epoch  |
| BrainRangeQuantity  |  int,unit,sint,fixed,sfixed |   long     | Any |  array of length 2 of long  |
| BrainRangeQuantity  |  float, double  |   double     | Document DB |  array of length 2 of double |
| BrainBasketQuantity  |   unit64   |   long    | Document DB | array of non repeated long (BrainSymbolicQuantity) |
| BrainBasketQuantity  |   string   |   string    | Document DB | array of non repeated long (BrainSymbolicQuantity) |
| BrainSequenceQuantity  |   unit64   |   long    | Document DB | array of long (BrainSymbolicQuantity) |
| BrainSequenceQuantity  |   string   |   string    | Document DB | array of long (BrainSymbolicQuantity) |
| BrainBagQuantity  |   map - unit64,unit64   |   long,long    | Document DB | object similar to map |
| BrainBagQuantity  |   map - unit64,double   |   long,double    | Document DB | object similar to map |
| BrainBagQuantity  |   map - string,unit64   |   string,long    | Document DB | object similar to map |
| BrainBagQuantity  |   map - string,double   |   string,double    | Document DB | object similar to map |
| BrainDistributionQuantity  |   map - unit32,double   |   long,double    | Document DB | object similar to map, value <= 1 |
| BrainDistributionQuantity  |   map - unit64,double   |   long,double    | Document DB | object similar to map, value <= 1 |
| BrainDistributionQuantity  |   map - string,double   |   string,double    | Document DB | object similar to map, value <= 1 |
| BrainSeriesQuantity  |   int,unit,sint,fixed,sfixed   |   long    | Timeseries | array of long - Only time series supported |
| BrainSeriesQuantity   | float, double   | double       | Timeseries |  array of double - Only time series supported   |
| BrainSpatialQuantity   | double, double   | double, double  | GIS |  Native  |
| BrainSpatialQuantity   | string   | string  | GIS |  geohash  |
| BrainSpatialQuantity   | double array   | double array  | GIS |  polygon  |
| BrainMediaQuantity   | string   | string  | Bucket |  URL of object  |
| BrainMediaQuantity   | byte array   | byte array  | Bucket |  actual bytes  |

## Tables
1. key (Sha256) to event key
2. function to features 
3. features to functions
4. key to feature (main table)

## CQRS
### Sink Layer
1. Machine Readable
2. Human Readable
3. Non Optimize 

Get - 
Flow - refresh?