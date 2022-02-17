Vagrant.configure("2") do |config|

    config.vm.define "centos6" do |centos6|
        centos6.vm.box = "generic/centos6"
        centos6.vm.hostname = "centos6"
        centos6.vm.network "private_network", ip: "192.168.56.138"
    end
end