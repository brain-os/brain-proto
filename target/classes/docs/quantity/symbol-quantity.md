# Symbolic

## Items as Collection

### Items as BrainCollectionConfig
* **id** below for identity is uint32 whereas for items it is uint64
* **order** will be ignored in below example
```json
{
  "identity": {
    "meta_id" : {
      "id": 123456,
      "key": {
        "vertical": "common",
        "type": "collection",
        "name": "colors",
        "key": "/meta/common/collection/colors"
      }
    }
  },
  "item_list": {
    "name" : "/meta/common/collection/colors",
    "is_ordinal" : false,
    "is_cyclic" : false,
    "item" : [
      {
        "item_id" : {
          "id": 23456,
          "key": {
            "vertical": "common",
            "type": "collection_item",
            "name": "red",
            "key": "/item/common/collection_item/colors/red"
          }
        }
      },
      {
        "item_id" : {
          "id": 34567,
          "key": {
            "vertical": "common",
            "type": "collection_item",
            "name": "blue",
            "key": "/item/common/collection_item/colors/blue"
          }
        }
      },
      {
        "item_id" : {
          "id": 45678,
          "key": {
            "vertical": "common",
            "type": "collection_item",
            "name": "green",
            "key": "/item/common/collection_item/colors/green"
          }
        }
      }
    ]
  }
}
```

### Item BrainCollectionSchema 
```json
{
  "item" : {
    "item_map" : {
      "item2index": {
        "/item/common/collection_item/colors/red": 23456,
        "/item/common/collection_item/colors/blue": 34567,
        "/item/common/collection_item/colors/green": 45678
      },
      "index2item": {
        "23456": "/item/common/collection_item/colors/red",
        "34567": "/item/common/collection_item/colors/blue",
        "45678": "/item/common/collection_item/colors/green"
      }
    },
    "sort_order" : {},
    "is_modulo" : false
  }
}
```
## Symbolic Quantity for Item 

### BrainQuantity as Item
Representation for item blue

```json
{
  "symbolic" : {
    "token": {
      "index": 34567
    }
  }
}
```

### BrainQuantityConfig for BrainSymbolicQuantityConfig

```json
{
  "identity": {
    "id": 43210,
    "key": {
      "vertical": "common",
      "type": "quantity",
      "name": "colors",
      "key": "/meta/common/quantity/symbolic/primary_colors"
    }
  },
  "unit_list" : {
    "name" : "NA",
    "item" : ["NA"]
  },
  "unit" : "NA",
  "symbolic": {
    "collection": "/meta/common/collection/colors"
  }
}
```

#### BrainQuantitySchema for BrainSymbolicQuantitySchema
583749 below refer to NA
```json
{
  "identity": {
    "id": 43210,
    "key": {
      "vertical": "common",
      "type": "quantity",
      "name": "colors",
      "key": "/meta/common/quantity/symbolic/primary_colors"
    }
  },
  "unit" : 583749,
  "symbolic": {
    "collection": {
      "item": {
        "item_map": {
          "item2index": {
            "/item/common/collection_item/colors/red": 23456,
            "/item/common/collection_item/colors/blue": 34567,
            "/item/common/collection_item/colors/green": 45678
          },
          "index2item": {
            "23456": "/item/common/collection_item/colors/red",
            "34567": "/item/common/collection_item/colors/blue",
            "45678": "/item/common/collection_item/colors/green"
          }
        }
      }
    }
  }
}
```

## Entity as Collection

### Entity as BrainCollectionConfig

```json
{
  "identity": {
    "id": 234567,
    "key": {
      "vertical": "common",
      "type": "collection",
      "name": "city",
      "key": "/meta/common/collection/city"
    },
    "entity_type": "/common/entity/city"
  }
}
```

### Entity attribute condition as BrainCollectionConfig 

```json
{
  "identity": {
    "id": 472829,
    "key": {
      "vertical": "common",
      "type": "collection",
      "name": "city",
      "key": "/meta/common/collection/metro_city"
    },
    "condition": {
      "entity_type": "/common/entity/city",
      "condition": "/common/attribute/city/population > 50000000"
    }
  }
}
```

### Entity predicate condition as BrainCollectionConfig

```json
{
  "identity": {
    "id": 946582,
    "key": {
      "vertical": "common",
      "type": "collection",
      "name": "city",
      "key": "/meta/common/collection/maharashtra_cities"
    },
    "condition": {
      "entity_type": "/common/entity/city",
      "condition": "/common/predicate/city/in_state/state = 'Maharashtra'"
    }
  }
}
```
## Symbolic Quantity for Entity
### BrainQuantity as Entity 

for entity city e.g. mumbai has machine id of _453628_

```json
{
  "symbolic" : {
    "token": {
      "index": 453628
    }
  }
}
```
### BrainSymbolicQuantityConfig for Entity
```json
{
  "identity": {
    "id": 43210,
    "key": {
      "vertical": "common",
      "type": "quantity",
      "name": "maharashtra_cities",
      "key": "/meta/common/quantity/symbolic/maharashtra_cities"
    }
  },
  "unit_list" : {
    "name" : "NA",
    "item" : ["NA"]
  },
  "unit" : "NA",
  "symbolic": {
    "collection": "/meta/common/collection/maharashtra_cities"
  }
}
```
### BrainSymbolicQuantitySchema for Entity
583749 below refer to NA
```json
{
  "identity": {
    "id": 43210,
    "key": {
      "vertical": "common",
      "type": "quantity",
      "name": "maharashtra_cities",
      "key": "/meta/common/quantity/symbolic/maharashtra_cities"
    }
  },
  "unit" : 583749,
  "symbolic": {
    "collection": {
      "entity": {
        "collection" : "/meta/common/collection/maharashtra_cities"
      }
    }
  }
}
```