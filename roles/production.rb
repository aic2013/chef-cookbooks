name "production"
description "Custom role for production server"

run_list ([
  "recipe[hostname]",
  "role[vagrant]",
  "recipe[ddclient]",
  "recipe[htop]",
])

passwords = Chef::EncryptedDataBagItem.load('aic13', 'secrets')
user_secrets = Chef::DataBagItem.load('aic13', 'users')

default_attributes({
  ddclient: {
    login: passwords['production']['dyndns']['username'],
    password: passwords['production']['dyndns']['password'],
  },
  webapp: {
    ssl: {
      key: passwords['production']['webapp']['ssl']['key'],
    }
  },
  postgresql: {
    config: {
      listen_addresses: '*',
      shared_buffers: '16MB'
    },
    database: {
      host: 'db.aic13.mmuehlberger.com',
      database: 'twitterdb'
    },
    password: {
      postgres: passwords['production']['postgresql']['postgresql'],
      deploy: passwords['production']['postgresql']['deploy'],
    },
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
      }, {
        type: 'host',
        db: 'all',
        user: 'deploy',
        addr: 'all',
        method: 'md5'
      },
    ],
    config_pgtune: {
      db_type: 'mixed',
      max_connections: '10',
    }
  },
  openssh: {
    permit_root_login: "no",
    password_authentication: "no",
  },
  authorization: {
    sudo: {
      users: [ 'deploy' ],
      passwordless: true,
    },
    keys: user_secrets['ssh_keys'],
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