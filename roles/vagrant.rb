name "vagrant"
description "Custom role for Vagrant"

run_list ([
  "recipe[aic13::deploy_user]",
  "recipe[openssh]",
  "recipe[sudo]",
  "recipe[apt]",
  "recipe[ntp]",
  "recipe[git]",
])

default_attributes({
  postgresql: {
    password: {
      postgres: 'insecurepassword',
      deploy: 'deploymentpassword',
    },
    database: {
      host: 'localhost',
      database: 'twitterdb_development',
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
  neo4j: {
    server: {
      version: '2.0.0-RC1'
    }
  },
  authorization: {
    sudo: {
      groups: [
        :admin,
        :sudo
      ],
      passwordless: true,
    },
    keys: []
  }
})