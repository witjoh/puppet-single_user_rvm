# == Class: single_user_rvm::dependencies
#
# Installs and configures rvm dependencies based on operating system
#
# === Examples
#
# class { 'single_user_rvm::dependencies': }
#
#
class single_user_rvm::dependencies {
  case $::osfamily {
    'Ubuntu', 'Debian': {
      # RVM dependencies
      if ! defined(Package['bash'])            { package { 'bash':            ensure => present } }
      if ! defined(Package['curl'])            { package { 'curl':            ensure => present } }
      if ! defined(Package['patch'])           { package { 'patch':           ensure => present } }
      if ! defined(Package['bzip2'])           { package { 'bzip2':           ensure => present } }
      if ! defined(Package['ca-certificates']) { package { 'ca-certificates': ensure => present } }
      if ! defined(Package['gawk'])            { package { 'gawk':            ensure => present } }

      # Generic Ruby dependencies
      if ! defined(Package['g++'])              { package { 'g++':              ensure => present } }
      if ! defined(Package['gcc'])              { package { 'gcc':              ensure => present } }
      if ! defined(Package['make'])             { package { 'make':             ensure => present } }
      if ! defined(Package['libc6-dev'])        { package { 'libc6-dev':        ensure => present } }
      if ! defined(Package['patch'])            { package { 'patch':            ensure => present } }
      if ! defined(Package['openssl'])          { package { 'openssl':          ensure => present } }
      if ! defined(Package['ca-certificates'])  { package { 'ca-certificates':  ensure => present } }
      if ! defined(Package['libreadline6'])     { package { 'libreadline6':     ensure => present } }
      if ! defined(Package['libreadline6-dev']) { package { 'libreadline6-dev': ensure => present } }
      if ! defined(Package['curl'])             { package { 'curl':             ensure => present } }
      if ! defined(Package['zlib1g'])           { package { 'zlib1g':           ensure => present } }
      if ! defined(Package['zlib1g-dev'])       { package { 'zlib1g-dev':       ensure => present } }
      if ! defined(Package['libssl-dev'])       { package { 'libssl-dev':       ensure => present } }
      if ! defined(Package['libyaml-dev'])      { package { 'libyaml-dev':      ensure => present } }
      if ! defined(Package['libsqlite3-dev'])   { package { 'libsqlite3-dev':   ensure => present } }
      if ! defined(Package['sqlite3'])          { package { 'sqlite3':          ensure => present } }
      if ! defined(Package['autoconf'])         { package { 'autoconf':         ensure => present } }
      if ! defined(Package['libgdbm-dev'])      { package { 'libgdbm-dev':      ensure => present } }
      if ! defined(Package['libncurses5-dev'])  { package { 'libncurses5-dev':  ensure => present } }
      if ! defined(Package['automake'])         { package { 'automake':         ensure => present } }
      if ! defined(Package['libtool'])          { package { 'libtool':          ensure => present } }
      if ! defined(Package['bison'])            { package { 'bison':            ensure => present } }
      if ! defined(Package['pkg-config'])       { package { 'pkg-config':       ensure => present } }
      if ! defined(Package['libffi-dev'])       { package { 'libffi-dev':       ensure => present } }
    }
    'RedHat', 'Amazon': {
      # RVM dependencies
      if ! defined(Package['bash'])            { package { 'bash':          ensure => present } }
      if ! defined(Package['curl'])            { package { 'curl':          ensure => present } }
      if ! defined(Package['patch'])           { package { 'patch':         ensure => present } }
      if ! defined(Package['bzip2'])           { package { 'bzip2':         ensure => present } }

      # Generic Ruby dependencies
      if ! defined(Package['gcc-c++'])        { package { 'gcc-c++':        ensure => present } }
      if ! defined(Package['make'])           { package { 'make':           ensure => present } }
      if ! defined(Package['glibc-headers'])  { package { 'glibc-headers':  ensure => present } }
      if ! defined(Package['glibc-devel'])    { package { 'glibc-devel':    ensure => present } }
      if ! defined(Package['patch'])          { package { 'patch':          ensure => present } }
      if ! defined(Package['openssl-devel'])  { package { 'openssl-devel':  ensure => present } }
      if ! defined(Package['readline-devel']) { package { 'readline-devel': ensure => present } }
      if ! defined(Package['curl'])           { package { 'curl':           ensure => present } }
      if ! defined(Package['zlib-devel'])     { package { 'zlib-devel':     ensure => present } }
      if ! defined(Package['openssl-devel'])  { package { 'openssl-devel':  ensure => present } }
      if ! defined(Package['libyaml-devel'])  { package { 'libyaml-devel':  ensure => present } }
      if ! defined(Package['sqlite-devel'])   { package { 'sqlite-devel':   ensure => present } }
      if ! defined(Package['autoconf'])       { package { 'autoconf':       ensure => present } }
      if ! defined(Package['automake'])       { package { 'automake':       ensure => present } }
      if ! defined(Package['libtool'])        { package { 'libtool':        ensure => present } }
      if ! defined(Package['bison'])          { package { 'bison':          ensure => present } }
      if ! defined(Package['libffi-devel'])   { package { 'libffi-devel':   ensure => present } }
    }
    'Darwin': {
      # RVM dependencies
      if ! defined(Package['bash'])            { package { 'bash':            ensure => present } }
      if ! defined(Package['curl'])            { package { 'curl':            ensure => present } }
      if ! defined(Package['bzip2'])           { package { 'bzip2':           ensure => present } }
      if ! defined(Package['gawk'])            { package { 'gawk':            ensure => present } }

      # Generic Ruby dependencies
      if ! defined(Package['gcc'])             { package { 'gcc':              ensure => present } }
      if ! defined(Package['gpatch'])          { package { 'gpatch':           ensure => present } }
      if ! defined(Package['make'])            { package { 'make':             ensure => present } }
      if ! defined(Package['openssl'])         { package { 'openssl':          ensure => present } }
      if ! defined(Package['readline'])        { package { 'readline':         ensure => present } }
      if ! defined(Package['curl'])            { package { 'curl':             ensure => present } }
      if ! defined(Package['zlib'])            { package { 'zlib':             ensure => present } }
      if ! defined(Package['libyaml'])         { package { 'libyaml':          ensure => present } }
      if ! defined(Package['sqlite'])          { package { 'sqlite':           ensure => present } }
      if ! defined(Package['autoconf'])        { package { 'autoconf':         ensure => present } }
      if ! defined(Package['ncurses'])         { package { 'ncurses':          ensure => present } }
      if ! defined(Package['automake'])        { package { 'automake':         ensure => present } }
      if ! defined(Package['libtool'])         { package { 'libtool':          ensure => present } }
      if ! defined(Package['bison'])           { package { 'bison':            ensure => present } }
      if ! defined(Package['pkg-config'])      { package { 'pkg-config':       ensure => present } }
      if ! defined(Package['libffi'])          { package { 'libffi':           ensure => present } }
    }
    default: {
      fail("Your osfamily (${::osfamily}) is not supported. PR are welcome")
    }
  }
}
