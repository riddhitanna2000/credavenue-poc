connection: "ecommerce"

# include all the views
include: "/views/**/*.view"

datagroup: orders_datagroup {
  sql_trigger: SELECT max(id) FROM order_items ;;
  max_cache_age: "1 hours"
  label: "ETL ID added"
  description: "Triggered when new ID is added to ETL log"
}

#datagroup: ecommerce_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
 # max_cache_age: "1 hour"
#}

persist_with: orders_datagroup

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  join: order_items {
    type: left_outer
    sql_on: ${users.id} = ${order_items.user_id} ;;
    relationship: one_to_many
  }

}

explore: products {

}

explore: order_items {



  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${order_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}
