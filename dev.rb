packages = ["ghc",
"android-ndk",
"android-sdk",
"automake",
"chicken",
"chromedriver",
"ctags",
"go",
"heroku-toolbelt",
"html2pdf",
"html2text",
"htmltopdf",
"inkscape",
"irssi",
"libxml2",
"memcached",
"mercurial",
"mysql",
"samba",
"smb",
"smbpasswd",
"terminal-notifier",
"tmux",
"varnish",
"wget",
"ffmpeg",
"wkhtmltopdf",
"wireshark",
"libxslt",
"yuicompressor"]

packages.each do |pkg|
	dep "#{pkg}.brew"
end

dep 'dev osx packages' do
	packages.each do |pkg|
		requires "#{pkg}.brew"
	end
end

# Pow: 
#  mkdir -p ~/Library/Application\ Support/Pow/Hosts
#  ln -s ~/Library/Application\ Support/Pow/Hosts ~/.pow
#
#  sudo pow --install-system
#  pow --install-local
#
#  sudo launchctl load -w /Library/LaunchDaemons/cx.pow.firewall.plist
#  launchctl load -w ~/Library/LaunchAgents/cx.pow.powd.plist
#

# Android: run `android` on the command line