# Ordinal Quantity

## Items as Collection

### items as BrainCollectionConfig
* **id** below for identity is uint32 whereas for items it is uint64
* **order** is important below
```json
{
  "identity": {
    "meta_id" : {
      "id": 123456,
      "key": {
        "vertical": "retail",
        "type": "collection",
        "name": "shirt_sizes",
        "key": "/meta/retail/collection/shirt_sizes"
      }
    }
  },
  "item_list": {
    "name" : "/meta/retail/collection/shirt_sizes",
    "is_ordinal" : true,
    "is_cyclic" : false,
    "item" : [
      {
        "item_id" : {
          "id": 23456,
          "key": {
            "vertical": "retail",
            "type": "collection_item",
            "name": "small",
            "key": "/item/retail/collection_item/shirt_sizes/small"
          }
        }
      },
      {
        "item_id" : {
          "id": 34567,
          "key": {
            "vertical": "retail",
            "type": "collection_item",
            "name": "medium",
            "key": "/item/retail/collection_item/shirt_sizes/medium"
          }
        }
      },
      {
        "item_id" : {
          "id": 45678,
          "key": {
            "vertical": "retail",
            "type": "collection_item",
            "name": "large",
            "key": "/item/retail/collection_item/shirt_sizes/large"
          }
        }
      }
    ]
  }
}
```