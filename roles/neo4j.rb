name "neo4j"
description "Neo4J Database Server"

run_list([
  "recipe[java]",
  "recipe[neo4j-server::tarball]",
])