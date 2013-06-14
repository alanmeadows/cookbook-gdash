require_relative 'spec_helper'

describe 'gash::web' do

  #-------------------
  # UBUNTU
  #-------------------

  describe "ubuntu" do

    before do
      gdash_stubs
      @chef_run = ::ChefSpec::ChefRunner.new ::UBUNTU_OPTS
      @node = @chef_run.node

      # set owner
      @node.set["gdash"]["owner"] = "www-data"
      @node.set["gdash"]["group"] = "www-data"

      # mock out an interface on the storage node
      @node.set["network"] = MOCK_NODE_NETWORK_DATA['network']

      @node.set["gdash"]["http_auth_method"] = "cas"

      @chef_run.converge "gdash::web"
    end

    it "includes cas recipe" do
      expect(@chef_run).to include_recipe "apache2::mod_auth_cas"
    end

    describe "/etc/apache2/sites-available/gdash" do

      before do
        @file = @chef_run.template "/etc/apache2/sites-available/gdash"
      end

      it "has proper owner" do
        expect(@file).to be_owned_by "www-data", "www-data"
      end

      it "template contents" do
        pending "TODO: implement"
      end

    end

  end

end
