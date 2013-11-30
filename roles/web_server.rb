name "web_server"
description "Role for the node.js web server"

run_list([
  "recipe[nodejs]",
  "recipe[nginx::source]",
  "recipe[monit]",
  "recipe[aic13::webapp]",
])

default_attributes({
  nodejs: {
    version: '0.10.22',
    npm: '1.3.14'
  },
  nginx: {
    gzip: 'on',
    gzip_comp_level: '6',
    gzip_vary: 'on',
    gzip_min_length: '1000',
    gzip_proxied: 'any',
    gzip_types: [
      'text/plain',
      'text/css',
      'application/json',
      'application/x-javascript',
      'text/xml',
      'application/xml',
      'application/xml+rss',
      'text/javascript',
    ],
    gzip_buffers: '16 8k',
    keepalive_timeout: '65'
  }

  # include       mime.types;
  # default_type  application/octet-stream;
  # sendfile        on;
  # keepalive_timeout  65;
})