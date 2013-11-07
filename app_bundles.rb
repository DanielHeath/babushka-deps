dep 'Sublime Text.app' do
  source 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.1.dmg'
  version '>= 2.0.1'
end

dep 'Dropbox.app' do
  source 'http://cdn.dropbox.com/Dropbox%201.2.49.dmg'
end

dep 'SizeUp.app' do
  source 'http://irradiatedsoftware.com/download/SizeUp.zip'
end

dep 'Google Chrome.app' do
  source 'https://dl-ssl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg'
end

dep 'Skype.app' do
  source 'http://download.skype.com/macosx/Skype_2.8.0.851.dmg'
end

dep 'Firefox.app' do
  source 'http://download.mozilla.org/?product=firefox-3.6.10&os=osx&lang=en-US'
end

dep 'Microsoft Office', :template => 'installer' do
  source 'http://ci.local/Office Installer.zip'
  prefix '/Applications/Microsoft Office 2011'
  provides %w[Excel Word PowerPoint Outlook].map {|i| "Microsoft #{i}.app" }
end

dep 'Adium.app' do
  source 'http://aarnet.dl.sourceforge.net/project/adium/Adium_1.5.8.dmg'
  version '>= 1.5.8'
end