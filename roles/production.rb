name "production"
description "Custom role for production server"

run_list (
  "role[vagrant]",
  "recipe[aic13::production]",
)

secret = File.read(Pathname.new(File.expand_path(File.dirname(__FILE__)))) +
  "../chef/encrypted_data_bag_secret"
passwords = Chef::EncryptedDataBagItem.load('aic13', 'secrets', secret)

default_attributes(

  postgresql: {
    password: {
      postgres: passwords['production']['postgresql'],
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
)