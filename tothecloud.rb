dep 'tothecloud' do
	requires  'user setup',
            'system',
            'owncloud.setup',
            # 'wave.setup',
            'discourse.setup'
end

dep 'owncloud.setup' do
  requires 'owncloud.gitrepo'
end

dep 'owncloud.managed' do
  requires 'owncloud.aptsrc.config'
  # TODO requires apt-get install apache2 php5 php5-gd php-xml-parser php5-intl php5-sqlite php5-mysql smbclient curl libcurl3 php5-curl
  installs 'owncloud' 
end

dep 'owncloud.aptsrc.config', :template => "config_file" do
  requires 'owncloud.aptkey'
  src 'owncloud/owncloud.list'
  dest '/etc/apt/sources.list.d/owncloud.list'
  sudo true
  after do
    sudo 'apt-get update'
  end
end

dep 'owncloud.aptkey' do
  meet {
    Dir.chdir(File.dirname(__FILE__))
    sudo('apt-key add owncloud/Release.key')
  }
  met? {
    sudo('apt-key list | grep ownCloud')
  }
end

