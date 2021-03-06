Configures Redis for Apps

Tested on Ubuntu 12.04

# Recipes

## default

Configures Redis for apps.

## yaml

Generates a redis.yml file compatible with the redis gem.

# Example Data Bag Items

## Apps

```json
{
  "id": "www",
  "owner": "www",
  "group": "www",
  "deploy_to": "/srv/www",
  "server_roles": "www"
  "redis_master_role": ["redis_master"],
  "redis_slave_role": ["redis_slave"],
  "ingredients": {
    "pillowfight": ["redis.yml"]
  }
}
```

# License and Authors

* Chris Griego (<cgriego@getaroom.com>)

Copyright 2012, getaroom

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
