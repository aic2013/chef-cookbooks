name "applications"
description "Role for application server"

run_list([
  "recipe[java]",
  "recipe[screen]",
  "recipe[aic13::production]",
  "recipe[aic13::tweet_producer]",
  "recipe[aic13::tweet_analyzer]",
  "recipe[aic13::follower_builder]",
  "recipe[aic13::follower_fetcher]",
])