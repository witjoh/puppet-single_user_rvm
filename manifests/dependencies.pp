# == Class: single_user_rvm::dependencies
#
# Installs and configures rvm dependencies based on operating system
#
# === Examples
#
# class { 'single_user_rvm::dependencies': }
#
class single_user_rvm::dependencies {
  case $::operatingsystem {
    'CentOS','RedHat','Fedora':  { require single_user_rvm::dependencies::centos }
    'Ubuntu','Debian':  { require single_user_rvm::dependencies::ubuntu }
    default: {}
  }
}
