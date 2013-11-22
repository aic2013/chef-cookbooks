name "vagrant"
description "Custom role for Vagrant"

run_list ([
  "recipe[aic13::vagrant]",
  "recipe[openssh]",
  "recipe[sudo]",
  "recipe[apt]",
  "recipe[ntp]",
  "recipe[postgresql::server]",
  "recipe[postgresql::config_pgtune]",
  "recipe[mongodb::10gen_repo]",
  "recipe[mongodb]",
  "recipe[java]",
  "recipe[git]",
  "recipe[neo4j-server::tarball]",
  "recipe[aic13::deploy_database]",
])

default_attributes({
  postgresql: {
    password: {
      postgres: 'insecurepassword',
      deploy: 'deploymentpassword',
    },
    enable_pgdg_apt: true,
    pg_hba: [
      {
        type: 'local',
        db: 'all',
        user: 'postgres',
        addr: nil,
        method: 'ident'
      }, {
        type: 'host',
        db: 'all',
        user: 'postgres',
        addr: 'localhost',
        method: 'md5'
      },
    ],
    config_pgtune: {
      db_type: 'desktop'
    }
  },
  openssh: {
    permit_root_login: "no",
    password_authentication: "no",
  },
  java: {
    jdk_version: '7'
  },
  authorization: {
    sudo: {
      groups: [
        :admin,
        :sudo
      ],
      passwordless: true,
    }
  }
})