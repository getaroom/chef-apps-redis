#
# Cookbook Name:: apps-redis
# Recipe:: yaml
#
# Copyright 2012, getaroom
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

search :apps do |app|
  if (app['server_roles'] & node.run_list.roles).any?
    if app.fetch("ingredients", {}).any? { |role, ingredients| node.run_list.roles.include?(role) && ingredients.include?("redis.yml") }
      roles_clause = app['redis_master_role'].map { |role| "role:#{role}" }.join(" OR ")

      nodes = search(:node, "(#{roles_clause}) AND chef_environment:#{node.chef_environment}")
      nodes << node if (app['redis_master_role'] & node.run_list.roles).any? # node not indexed on first chef run

      host = nodes.sort_by { |node| node.name }.reverse.map do |redis_node|
        redis_node.attribute?("cloud") ? redis_node['cloud']['local_ipv4'] : redis_node['ipaddress']
      end.uniq.first

      file "#{app['deploy_to']}/shared/config/redis.yml" do
        owner app['owner']
        group app['group']
        mode "660"
        content({ node['framework_environment'] => { "host" => host }}.to_yaml)
      end
    end
  end
end
