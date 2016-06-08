require 'chefspec'

describe 'cernvm-fs::default' do

  context 'with version attribute' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['cvmfs']['version' ] = '1.2.3'
      end.converge(described_recipe)
    end

    it 'includes cernvm-fs::install' do
      expect(chef_run).to include_recipe('cernvm-fs::install')
    end
  end

  context 'client on Debian' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'debian',
        version: '8.0').converge(described_recipe)
    end

    it 'installs cvmfs-client' do
      expect(chef_run).to install_package('cvmfs-client')
    end
  end

  context 'client on Debian' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'debian',
        version: '8.0').converge(described_recipe)
    end

    it 'includes cernvm-fs::client' do
      expect(chef_run).to include_recipe('cernvm-fs::client')
    end
  end

  context 'server on Debian Wheezy' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'debian', version: '7.0') do |node|
        node.set['cvmfs']['server']['repos'] = [ 'test.example.com' ]
      end.converge(described_recipe)
    end

    it 'installs cvmfs-client' do
      expect(chef_run).to install_package('cvmfs')
    end

    it 'includes cernvm-fs::server' do
      expect(chef_run).to include_recipe('cernvm-fs::server')
    end
  end

end
