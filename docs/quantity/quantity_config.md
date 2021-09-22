## UI
Name : Text box
Type : Combo box ("numeric", "symbolic", "binned", "ordinal", "date", "boolean")
Unit : Combo box (NOT_APPLICABLE, LENGTH_CM, LENGTH_METER, LENGTH_KM, WEIGHT_MG, WEIGHT_GRAMS, WEIGHT_KG, TEMPERATURE_CELSIUS, 
TEMPERATURE_FAHRENHEIT, TIME_MILLISECOND, TIME_SECOND, DECIBLE)
Parameters : (UI changes depending upon above selection)
### Type = "numeric"
Parameters :
Sub Type : Combo box ("uint32", "uint64", "sint32", "sint64", "float", "double")
#### json
```json
{
  "name" : "rsrp",
  "unit" : "decibel",
  "type" : "numeric",
  "parameters" : {
    "sub_type" : "sint32"
  }
}
```
### Type = "symbolic"
Parameters :
Values : Text Box (Similar to Tags)
#### json
```json
{
  "name" : "tower_type",
  "unit" : "not_applicable",
  "type" : "symbolic",
  "parameters" : {
    "dictionary" : "a,b,c,d"
  }
}
```
### Type = "ordinal"
Parameters :
Values : Text Box (Similar to Tags)
#### json
```json
{
  "name" : "rating",
  "unit" : "stars",
  "type" : "ordinal",
  "parameters" : {
    "dictionary" : "very_bad,bad,average,good,excellent"
  }
}
```
### Type = "binned"
Parameters :
Bin Boundaries : Text Box (Similar to Tags)
Bin Names : Text Box (Similar to Tags)
Minimum : Combo box (Open, Closed)
Maximum : Combo box (Open, Closed)

Values need to be valid above, in terms of number of bin boundaries (including minimum and maximum) and names
#### json
```json
{
  "name" : "rsrp_bin",
  "unit" : "decibel",
  "type" : "binned",
  "parameters" : {
    "bin_boundaries" : "10,20,30",
    "bin_names" : "bad,fair,good,excellent",
    "minimum" : "open",
    "maximum" : "closed"
  }
}
```