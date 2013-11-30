name "applications"
description "Role for application server"

run_list([
  "recipe[java]",
  "recipe[aic13::production]",
  "recipe[aic13::twitter_monitor]",
  "recipe[aic13::twitter_extractor]",
])