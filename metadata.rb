name             "apps-redis"
maintainer       "getaroom"
maintainer_email "devteam@roomvaluesteam.com"
license          "MIT"
description      "Configures Redis for Apps"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "1.0.0"

depends "apps"

supports "debian"
supports "ubuntu"

recipe "apps-redis", "Configures Redis for apps."
recipe "apps-redis::yaml", "Generates a redis.yml file compatible with the redis gem."
