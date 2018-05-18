require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

UNSUPPORTED_PLATFORMS = [ 'Windows', 'Solaris', 'AIX' ]

unless ENV['RS_PROVISION'] == 'no' or ENV['BEAKER_provision'] == 'no'
  # This will install the latest available package on el and deb based
  # systems fail on windows and osx, and install via gem on other *nixes
  foss_opts = { :default_action => 'gem_install' }

  if default.is_pe?; then install_pe; else install_puppet( foss_opts ); end

  hosts.each do |host|
    on host, "mkdir -p #{host['distmoduledir']}"
    on host, puppet('config', 'set', 'stringify_facts', 'false')
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  fixture_modules = File.join(proj_root, 'spec', 'fixtures', 'modules')

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    hosts.each do |host|
      # Install this module and hieradata

      copy_hiera_data_to(host, "#{proj_root}/spec/fixtures/hieradata/")
      copy_module_to(host, :source => proj_root, :module_name => '')

      # transfer the fixtures to the host (needs bundle exec rake prep_spec run)
      scp_to(host ,fixture_modules, "#{host['distmoduledir']}/..", { :ignore => ''})

    end
  end
end
