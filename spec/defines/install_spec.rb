require 'spec_helper'
require 'shared_contexts'

describe 'single_user_rvm::install' do

  # add these two lines in a single test block to enable puppet and hiera debug mode
  # Puppet::Util::Log.level = :debug
  # Puppet::Util::Log.newdestination(:console)

  shared_examples 'install' do |overrides|

    if defined?(overrides) && overrides.is_a?(Hash)
      # we do nothing
    else
      overrides = {}
    end

    default_params { 
      user:         title,
      version:      'stable',
      rvmrc:        :undef,
      home:         :undef,
      proxy:        :undef,
      auto_upgrade: false,
    }

    let(:params) do 
      {
        default_params.merge(overrides)
      }
    end

    import_key =
    install_command =
    upgrade_command =

    if params[home] == :undef
      homedir = "/home/#{params['user']}"
    else
      homedir = params['home']
    end

    it do
      is_expected.to contain_exec('$import_key').with(
        path: '/usr/bin:/usr/sbin:/bin:/sbin',
        user: params['user'],
        onlyif: 'test `gpg --list-keys | grep 'RVM signing' | wc -l` -eq 0',
        cwd: homedir,
        environment: "HOME=#{homedir}",
      )
    end

    it do
      is_expected.to contain_exec('$install_command').with(
        path: '/usr/bin:/usr/sbin:/bin',
        creates: "#{homedir}/.rvm/bin/rvm",
        user: params['user'],
        cwd: homedir,
        environment: "HOME=#{homedir}",
        require: ['Package[curl]', 'Package[bash]', "User[#{title}]", "Exec[#{import_key}]"],
      )
    end

    it do
      is_expected.to contain_exec('$upgrade_command').with(
        path: '/usr/bin:/usr/sbin:/bin',
        user: params['user'],
        cwd: '$homedir',
        environment: 'HOME=$homedir',
        require: 'Exec[$install_command]',
      )
    end

    it do
      is_expected.to contain_exec('$upgrade_command').with(
        path: '/usr/bin:/usr/sbin:/bin',
        unless: '$version_check_command',
        user: params['user],
        cwd: '$homedir',
        environment: 'HOME=$homedir',
        require: 'Exec[$install_command]',
      )
    end

    it do
      is_expected.to contain_file('$homedir/.rvmrc').with(
        ensure: 'present',
        owner: params['user'],
        content: :undef,
      )
    end

  end # shared_examples
  let(:title) { 'a_user' }

  let(:params) do
    {
      # user: "$title",
      # version: "stable",
      # rvmrc: :undef,
      # home: :undef,
      # proxy: :undef,
      # auto_upgrade: false,

    }
  end

end
