# Primitive translation

>> Data from entity and feature are represented as BrainQuantity. During storage or while calculation, primitive types are required. Translation layer transform data from BrainQuantity to primitive and vice versa 

This translation will require during
1. BrainQuantity storage into DB
2. BrainQuantity read from DB
3. ML Bridge - calling ml functions require features (brain quantity) 
4. ML Bridge - results of ml functions are primitives, and they will be used BrainQuantity
5. Rule bridge - calling rule engine
6. Rule bridge - result of rule engine

[Language Mapping](https://developers.google.com/protocol-buffers/docs/proto3#scalar)

## Constraints
1. Only time series data (For attribute qualifier)
2. Limited support to predicate qualifier

## Tables in feature lake
1. key (Sha256) to event key
2. function to features (updates in config of model should update this table)
3. features to functions (updates in config of model should update this table)
4. key to feature (main table)
5. entity id to event key (change in attribute of 1 entity will result in all dependent models)

## Data Stores
1. features - mongo
2. time series - influx
3. Profile and other data structures - mongo

## Translation Layer
1. Feature(BrainQuantity) to primitive
2. Primitives to features (BrainQuantity)

### Supported quantities
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

## CQRS
### Sink Layer
1. Machine Readable
2. Human Readable
3. Non Optimize 

Get - 
Flow - refresh?