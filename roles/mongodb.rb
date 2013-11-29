name "mongodb"
description "Mongo Database Server"

run_list([
  "recipe[mongodb::10gen_repo]",
  "recipe[mongodb]",
])