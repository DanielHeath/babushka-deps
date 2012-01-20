dep 'system', :locale_name do
  requires 'set.locale'.with(locale_name), 'hostname', 'secured ssh logins', 'lax host key checking', 'admins can sudo', 'tmp cleaning grace period', 'core software'
  requires 'bad certificates removed' if Babushka::Base.host.linux?
  setup {
    unmeetable! "This dep has to be run as root." unless shell('whoami') == 'root'
  }
end

dep 'user setup', :username, :key do
  username.default(shell('whoami'))
  requires [
    'dot files'.with(username),
    'passwordless ssh logins'.with(username, key),
    'public key',
    'zsh'.with(username)
  ]
end

dep 'rails app', :domain, :domain_aliases, :username, :path, :listen_host, :listen_port, :env, :nginx_prefix, :data_required do
  requires 'rack app'.with(domain, domain_aliases, username, path, listen_host, listen_port, env, nginx_prefix, data_required)
  requires 'db'.with(username, path, env, data_required, 'yes')
end

dep 'rack app', :domain, :domain_aliases, :username, :path, :listen_host, :listen_port, :env, :nginx_prefix, :data_required do
  username.default!(shell('whoami'))
  path.default('~/current')
  env.default(ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'production')

  requires 'webapp'.with('unicorn', domain, domain_aliases, username, path, listen_host, listen_port, nginx_prefix)
  requires 'web repo'.with(path)
  requires 'app bundled'.with(path, env)
  requires 'rack.logrotate'
end

dep 'proxied app' do
  requires 'webapp'.with(:type => 'proxy')
end

dep 'webapp', :type, :domain, :domain_aliases, :username, :path, :listen_host, :listen_port, :nginx_prefix do
  username.default!(domain)
  requires 'user exists'.with(username, '/srv/http')
  requires 'vhost enabled.nginx'.with(type, domain, domain_aliases, path, listen_host, listen_port, nginx_prefix)
  requires 'running.nginx'
end

dep 'core software' do
  requires {
    on :linux, 'vim.managed', 'curl.managed', 'htop.managed', 'iotop.managed', 'jnettop.managed', 'tmux.managed', 'nmap.managed', 'tree.managed', 'pv.managed'
    on :osx, 'curl.managed', 'htop.managed', 'jnettop.managed', 'nmap.managed', 'tree.managed', 'pv.managed'
  }
end
