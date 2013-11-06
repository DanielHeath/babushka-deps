
dep 'core software' do
  requires {
    on :linux, 'sudo.bin', 'lsof.bin', 'vim.bin', 'curl.bin', 'traceroute.bin', 'htop.bin', 'iotop.bin', 'jnettop.bin', 'tmux.bin', 'nmap.bin', 'tree.bin', 'pv.bin'
    on :osx, 'sudo.bin', 'lsof.bin', 'vim.bin', 'curl.bin', 'traceroute.bin', 'tmux.bin', 'nmap.bin', 'tree.bin', 'pv.bin'
  }
end
