require 'spec_helper'
require 'shared_contexts'

describe 'single_user_rvm::dependencies' do
  # add these two lines in a single test block to enable puppet and hiera debug mode
  # Puppet::Util::Log.level = :debug
  # Puppet::Util::Log.newdestination(:console)
  context 'on supported osfamily' do
    context 'Debian' do
      let(:facts) do
        { :osfamily => 'Debian', }
      end

      it do
        is_expected.to contain_package('bash').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('curl').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('patch').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('bzip2').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('ca-certificates').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('gawk').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('g++').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('gcc').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('make').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('libc6-dev').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('patch').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('openssl').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('ca-certificates').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('libreadline-dev').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('curl').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('zlib1g').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('zlib1g-dev').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('libssl-dev').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('libyaml-dev').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('libsqlite3-dev').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('sqlite3').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('autoconf').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('libgdbm-dev').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('libncurses5-dev').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('automake').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('libtool').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('bison').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('pkg-config').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('libffi-dev').with(
          ensure: 'present',
        )
      end

    end
    context 'on RedHat' do
      let(:facts) do
        { :osfamily => 'RedHat', }
      end
      it do
        is_expected.to contain_package('bash').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('curl').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('patch').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('bzip2').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('gcc-c++').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('make').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('glibc-headers').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('glibc-devel').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('patch').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('openssl-devel').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('readline-devel').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('curl').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('zlib-devel').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('openssl-devel').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('libyaml-devel').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('sqlite-devel').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('autoconf').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('automake').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('libtool').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('bison').with(
          ensure: 'present',
        )
      end

      it do
        is_expected.to contain_package('libffi-devel').with(
          ensure: 'present',
        )
      end
    end
    context 'on unsupported osfamily' do
      let(:facts) do
        { :osfamily => 'wierdos', }
      end
      it do
        is_expected.to compile.and_raise_error(/Your osfamily (wierdos) is not supported./)
      end
    end
  end
end
