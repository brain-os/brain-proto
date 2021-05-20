# Example
## Entities
### Element (name : "/chemistry/entity/element")
1. Attributes
   1. Element Name
      1. **name** :  "/chemistry/attribute/element/element_name"
      1. **quantity** :  "/chemistry/quantity/symbolic/element_name"
   1. Atomic Number
      1. **name** :  "/chemistry/attribute/element/atomic_number"
      1. **quantity** :  "/chemistry/quantity/numeric/atomic_number"
   1. Atomic Mass
      1. **name** :  "/chemistry/attribute/element/atomic_mass"
      1. **quantity** :  "/chemistry/quantity/numeric/atomic_mass"
### ChemicalCompound (name : "/chemistry/entity/chemical_compound")
1. Attributes
   1. Formula Name
      1. **name** :  "/chemistry/attribute/chemical_compound/formula"
      1. **quantity** :  "/chemistry/quantity/symbolic/formula"
   1. Molar mass
      1. **name** :  "/chemistry/attribute/chemical_compound/molar_mass"
      1. **quantity** :  "/common/quantity/numeric/mass"
   1. Liquid State Temperature Range
      1. **name** :  "/chemistry/attribute/chemical_compound/liquid_temp_range"
      1. **quantity** :  "/common/quantity/range/liquid_temp_range"

## Predicates 
### Made Up Of (name : chemical_compound/made_up_of/element)
1. Predicate Qualifiers
      1. **name** :  "/chemistry/predicate_qualifier/made_up_of/element_atom_count"
      1. **quantity** :  "/common/quantity/count"



# Quantities
## Atomic Mass (name : /chemistry/quantity/numeric/atomic_mass)
Sample data for **Nitrogen** element.
### BrainQuantity  
_123456_ below is index of **amu** units in some dictionary
#### In Document
```json
{
   "meta" : {
      "vertical" : "chemistry",
      "name" : "atomic_mass",
      "unit" : "amu",
      "type" : "numeric"
   },
   "unit" : 123456,
   "numeric" : {
      "double_value" : 14
   }
}
```
#### Suggestion
```json
{
   "numeric" : {
      "double_value" : 14
   }
}
```
### BrainQuantityConfig
#### In Document
```json
{
   "name" : "atomic_mass",
   "type" : "/chemistry/quantity/numeric/atomic_mass",
   "unit" : ["amu", "dalton"],
   "numeric" : {
      "minimum" : {
         "double_value" : 1
      },
      "maximum" : {
         "double_value" : 294
      },
      "include_minimum" : true,
      "include_maximum" : true
   }
}
```
#### Suggestion
```json
{
   "identity" : {
      "meta" : {
         "vertical" : "chemistry",
         "type" : "quantity",
         "name" : "atomic_mass",
         "key_string" : "/chemistry/quantity/numeric/atomic_mass"
      }
   },
   "unit" : ["amu", "dalton"],
   "assigned_unit" : "amu",
   "numeric" : {
      "minimum" : {
         "double_value" : 1
      },
      "maximum" : {
         "double_value" : 294
      },
      "include_minimum" : true,
      "include_maximum" : true
   }
}
```
### BrainQuantitySchema
#### In Document
below meta is different than that in **identity**
```json
{
   "meta" : {
      "vertical" : "chemistry",
      "name" : "atomic_mass",
      "unit" : "amu",
      "type" : "/chemistry/quantity/numeric/atomic_mass"
   },
   "unit" : {
      "item2index" : {
         "amu" : 5678,
         "dalton" : 98765
      },
      "index2item" : {
         "5678" : "amu",
         "98765" : "dalton"
      }
   },
   "numeric" : {
      "type" : "BRAIN_NUMERIC_DOUBLE",
      "minimum" : {
         "double_value" : 1
      },
      "maximum" : {
         "double_value" : 294
      },
      "include_minimum" : true,
      "include_maximum" : true
   }
}
```
#### Suggestion
```json
{
   "identity" : {
      "meta" : {
         "vertical" : "chemistry",
         "type" : "quantity",
         "name" : "atomic_mass",
         "key_string" : "/chemistry/quantity/numeric/atomic_mass"
      }
   },
   "assigned_unit" : "amu",
   "unit" : {
      "item2index" : {
         "amu" : 5678,
         "dalton" : 98765
      },
      "index2item" : {
         "5678" : "amu",
         "98765" : "dalton"
      }
   },
   "numeric" : {
      "type" : "BRAIN_NUMERIC_DOUBLE",
      "minimum" : {
         "double_value" : 1
      },
      "maximum" : {
         "double_value" : 294
      },
      "include_minimum" : true,
      "include_maximum" : true
   }
}
```
## Liquid State Temperature Range (name : /chemistry/attribute/chemical_compound/liquid_temp_range)
Sample data for **Water** element.
### BrainQuantity
_123456_ below is index of **degree celsius** units in some dictionary
#### In Document
```json
{
   "meta" : {
      "vertical" : "chemistry",
      "name" : "liquid_temp_range",
      "unit" : "celsius",
      "type" : "range"
   },
   "unit" : 123456,
   "range" : {
      "minimum" : {
         "numeric" : {
            "double_value" : 0
         }
      },
      "maximum" : {
         "numeric" : {
            "double_value" : 100
         }
      }
   },
   "include_minimum" : true,
   "include_maximum" : true
}
```
#### Suggestion
```json
{
   "range" : {
      "minimum" : {
         "numeric" : {
            "double_value" : 0
         }
      },
      "maximum" : {
         "numeric" : {
            "double_value" : 100
         }
      },
      "include_minimum" : true,
      "include_maximum" : true
   }
}
```
### BrainQuantityConfig
#### In Document
NOTE: There is no special proto for this.
The system knows a quantity is a range quantity by “type:” (example below)
These quantities are useful in specifying conditions/qualifiers.

OR is it going to be **/common/quantity/temperature**
```json
{
   "identity" : {
      "meta" : {
         "vertical" : "common",
         "type" : "quantity",
         "name" : "temperature",
         "key_string" : "/common/quantity/numeric/temperature"
      }
   },
   "unit" : {
      "item2index" : {
         "celsius" : 5678,
         "kelvin" : 98765,
         "fahrenheit" : 1234
      },
      "index2item" : {
         "5678" : "celsius",
         "98765" : "kelvin",
         "1234" : "fahrenheit"
      }
   },
   "numeric" : {
      "type" : "BRAIN_NUMERIC_DOUBLE",
      "minimum" : {
         "double_value" : -273
      },
      "maximum" : {
         "double_value" : 100000
      },
      "include_minimum" : true,
      "include_maximum" : true
   }
}
```
#### Suggestion
```json
{
   "identity" : {
      "meta" : {
         "vertical" : "chemistry",
         "type" : "quantity",
         "name" : "atomic_mass",
         "key_string" : "/chemistry/quantity/range/temperature"
      }
   },
   "unit" : ["celsius", "kelvin", "fahrenheit"],
   "assigned_unit" : "celsius",
   "range" : {
      "minimum" : {
         "numeric" : {
            "double_value" : -273
         }
      },
      "maximum" : {
         "numeric" : {
            "double_value" : 100000
         }
      },
      "include_minimum" : true,
      "include_maximum" : true
   }
}
```

```
1. verticle : common, telecom, retail (drop down)
1. units need to be moved from here
1. collections - days_of_week
1. commons/meta/coleection/temporal/week_of_day
1. is_ordinal
1. is_modulo
```

1. Collection and subset