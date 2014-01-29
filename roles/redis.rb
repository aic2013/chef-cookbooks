name "redis"
description "Installs Redis and everything necessary to run it properly"

run_list([
  "recipe[redis]",
])