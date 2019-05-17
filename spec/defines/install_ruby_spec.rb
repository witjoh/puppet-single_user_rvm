require 'spec_helper'
require 'shared_contexts'

describe 'single_user_rvm::install_ruby' do
  # add these two lines in a single test block to enable puppet and hiera debug mode
  # Puppet::Util::Log.level = :debug
  # Puppet::Util::Log.newdestination(:console)

  shared_examples 'install_ruby' do | command, overrides |

    # one need to provide the expected command always, 
    # overiding the  parameters is optional

    if defined?(overrides) && overrides.is_a?(Hash)
      # we do nothing
    else
      overrides = {}
    end
      
    default_params = {
      'ruby_string'      => :title,
      'user'             => 'rvm',
      'verify_downloads' => :undef,
      'force_binary'     => false,
      'disable_binary'   => false,
      'movable'          => false,
      'home'             => :undef,
      'proxy'            => :undef,
    }

    let(:params) do
      default_params.merge(overrides)
    end

    it do
      is_expected.to contain_exec(command).with(
        path: '/usr/bin:/usr/sbin:/bin',
        creates: "/home/#{params['user']}/.rvm/rubies/$title/bin/ruby",
        timeout: '3600',
        require: 'Single_user_rvm::install[rvm]',
        cwd: "/home/#{params['user']}",
        environment: "HOME=/home/#{params['user']}",
      )
    end
  end # shared_examples

  let(:title) { 'ruby-2.0.0' }

  context 'with default parameters' do
    it_behaves_like 'install_ruby', "/home/rvm/.rvm/bin/rvm install #{title}"
  end
 
  context 'with custom parameters' do
    my_params = {
      'user'             => 'myuser',
      'verify_downloads' => 1,
      'force_binary'     => true,
      'disable_binary'   => true,
      'movable'          => true,
      'home'             => '/another/home',
      'proxy'            => 'someproxy.ex:8080',
    }
    command = "/another/home/.rvm/bin/rvm --proxy http://someproxy.ex:8080 install #{title} --binary --disable_binary  --movable --verify_download 1"
    it_behaves_like 'install_ruby', command, my_params
  end

  context 'validation' do
    ['fault', 5, true].each do | wrong |
      context "verify_downloads is #{wrong}" do
        let(:params) do
          {
            'verify_downloads' => wrong,
          }
        end
        it do
          is_expected.to compile.and_raise_error(/verify_downloads can only be 0,1 or 2/)
        end
      end
    end
    ['string', 5].each do | wrong |
      context "force_binary is #{wrong}" do
        let(:params) do
          {
            'force_binary' => wrong,
          }
        end
        it do
          is_expected.to compile.and_raise_error(/force_binary must be true or false/)
        end
      end
    end
    ['string', 5].each do | wrong |
      context "disable_binary is #{wrong}" do
        let(:params) do
          {
            'disable_binary' => wrong,
          }
        end
        it do
          is_expected.to compile.and_raise_error(/disable_binary must be true or false/)
        end
      end
    end
    ['string', 5].each do | wrong |
      context "movable is #{worng}" do
        let(:params) do
          {
            'movable' => wrong,
          }
        end
        it do
          is_expected.to compile.and_raise_error(/movable must be true or false/)
        end
      end
    end
    [ 5, 'home/wrong', true ].each do | wrong |
      context "home is #{wrong}" do
        let(:params) do
          {
            'home' => wrong,
          }
        end
        it do
          is_expected.to compile.and_raise_error(/home must be absolute path/)
        end
      end
    end
    ['string', 5, 'something:someport'].each do | wrong |
      context 'proxy is #{wrong}' do
        let(:params) do
          {
            'home' => wrong,
          }
        end
        it do
          is_expected.to compile.and_raise_error(/proxy must be serveraddress:port/)
        end
      end
    end
  end
end
