describe_recipe "apps-redis::yaml" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "/srv/www/shared/config/redis.yml" do
    let(:app_user) { user "www" }
    let(:app_group) { group "www" }
    let(:yml) { file "/srv/www/shared/config/redis.yml" }
    let(:stat) { File.stat(yml.path) }

    let :host do
      nodes = Chef::Search::Query.new.search(:node, "role:server OR role:client").first + [node]
      nodes.sort_by(&:name).reverse.map { |node| node['cloud']['local_ipv4'] }.uniq.first
    end

    it "exists" do
      yml.must_exist
    end

    it "is owned by the app user" do
      assert_equal app_user.uid, stat.uid
      assert_equal app_group.gid, stat.gid
    end

    it "is mode 660" do
      assert_equal "660".oct, (stat.mode & 007777)
    end

    it "contains information about the redis host" do
      expected_yaml = { "production" => { "host" => host }}
      actual_yaml = YAML.load_file(yml.path)
      assert_equal expected_yaml, actual_yaml
    end
  end

  describe "an application not hosted on this server" do
    it "does not create a redis.yml file" do
      file("/srv/princess/shared/config/redis.yml").wont_exist
    end
  end

  describe "an application hosted on this server but not using redis" do
    it "does not create a redis.yml file" do
      file("/srv/toad/shared/config/redis.yml").wont_exist
    end
  end
end
