name "postgresql"
description "PostgreSQL-Server"

run_list([
  "role[production]",
  "recipe[postgresql::server]",
  "recipe[postgresql::config_pgtune]",
  "recipe[aic13::deploy_database]",
])