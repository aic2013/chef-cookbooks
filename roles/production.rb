name "production"
description "Custom role for production server"

run_list ([
  "role[vagrant]",
  "recipe[aic13::production]",
  "recipe[aic13::twitter_monitor]",
  "recipe[aic13::twitter_extractor]",
])

passwords = Chef::EncryptedDataBagItem.load('aic13', 'secrets')

default_attributes({
  postgresql: {
    password: {
      postgres: passwords['production']['postgresql']['postgresql'],
      deploy: passwords['production']['postgresql']['deploy'],
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
      db_type: 'mixed'
    }
  },
  openssh: {
    permit_root_login: "no",
    password_authentication: "no",
  },
  authorization: {
    users: [ 'deploy' ],
    passwordless: true,
  },
  twitter: {
    oauth: {
      consumer_key: passwords['production']['twitter']['consumer_key'],
      consumer_secret: passwords['production']['twitter']['consumer_secret'],
      access_token: passwords['production']['twitter']['access_token'],
      access_token_secret: passwords['production']['twitter']['access_token_secret'],
    }
  },
})