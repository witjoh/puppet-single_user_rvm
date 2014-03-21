# == Class: rvm::dependencies::centos
#
# Installs and configures dependencies on CentOS
#
# === Examples
#
# class { 'rvm::dependencies::centos': }
#
class single_user_rvm::dependencies::centos inherits single_user_rvm{

  if ! defined(Package['curl']) { package { 'curl': ensure => present } }
  if ! defined(Package['git']) { package { 'git': ensure => present } }
  if ! defined(Package['wget']) { package { 'wget': ensure => present } }
  # RVM dependencies
  if ! defined(Package['bash'])            { package { 'bash':            ensure => present } }
  if ! defined(Package['curl'])            { package { 'curl':            ensure => present } }
  if ! defined(Package['patch'])           { package { 'patch':           ensure => present } }
  if ! defined(Package['bzip2'])           { package { 'bzip2':           ensure => present } }
  if ! defined(Package['ca-certificates']) { package { 'ca-certificates': ensure => present } }
  if ! defined(Package['gawk'])            { package { 'gawk':            ensure => present } }

  if ! defined(Package['which']) { package { 'which': ensure => present } }
  if ! defined(Package['gcc']) { package { 'gcc': ensure => present } }
  if ! defined(Package['gcc-c++']) { package { 'gcc-c++': ensure => present } }
  if ! defined(Package['make']) { package { 'make': ensure => present } }
  if ! defined(Package['libxml2']) { package { 'libxml2': ensure => present } }
  if ! defined(Package['libxml2-devel']) { package { 'libxml2-devel': ensure => present } }
  if ! defined(Package['libxslt']) { package { 'libxslt': ensure => present } }
  if ! defined(Package['libxslt-devel']) { package { 'libxslt-devel': ensure => present } }
  if ! defined(Package['readline']) { package { 'readline': ensure => present } }
  if ! defined(Package['readline-devel']) { package { 'readline-devel': ensure => present } }
  if ! defined(Package['zlib']) { package { 'zlib': ensure => present } }
  if ! defined(Package['zlib-devel']) { package { 'zlib-devel': ensure => present } }
#  if ! defined(Package['libyaml-devel']) { package { 'libyaml-devel': ensure => present } }
  if ! defined(Package['libffi-devel']) { package { 'libffi-devel': ensure => present } }
  if ! defined(Package['openssl-devel']) { package { 'openssl-devel': ensure => present } }
  if ! defined(Package['autoconf']) { package { 'autoconf': ensure => present } }
  if ! defined(Package['automake']) { package { 'automake': ensure => present } }
  if ! defined(Package['libtool']) { package { 'libtool': ensure => present } }
  if ! defined(Package['bison']) { package { 'bison': ensure => present } }
  if ! defined(Package['glibc']) { package { 'glibc': ensure => present } }
  if ! defined(Package['java-1.7.0-openjdk']) { package { 'java-1.7.0-openjdk': ensure => present } }
}
