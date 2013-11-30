name "queue"
description "Installs ActiveMQ and everything necessary to run it properly"

run_list([
  "recipe[activemq]",
])