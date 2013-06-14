require_relative 'spec_helper'

describe 'gash::default' do

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

      @chef_run.converge "gdash::default"
    end

    it "installs libyaml-perl" do
      expect(@chef_run).to install_package "libyaml-perl"
    end


    it "starts swift apache2 on boot" do
      %w{apache2}.each do |svc|
        expect(@chef_run).to set_service_to_start_on_boot svc
      end
    end

    describe "/opt/gdash/config/gdash.yaml" do

      before do
        @file = @chef_run.template "/opt/gdash/config/gdash.yaml"
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
