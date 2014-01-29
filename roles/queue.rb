name "queue"
description "Installs RabbitMQ and everything necessary to run it properly"

run_list([
  "recipe[rabbitmq]",
  "recipe[rabbitmq::mgmt_console]",
  "recipe[aic13::rabbitmq]"
])