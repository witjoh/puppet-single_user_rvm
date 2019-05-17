# == Class: single_user_rvm::dependencies
#
# Install packages required for a proper RVM installation.
#
# These should preferably be broken down to subclasses for each os, arch and/or ruby and be respectively required.
# However I don't really care for that currently :) In case of weird configurations I would preferably specify those
# dependencies somewhere else since it would be a far fetched exception for me. Feel free to contribute to it though!
#
# Current package lists taken from https://github.com/wayneeseguin/rvm/blob/master/scripts/functions/requirements/ubuntu
#
# Not needed for public use, it will be required before installing RVM on it's own
#
class single_user_rvm::dependencies_osx inherits single_user_rvm {

  # RVM dependencies
  if ! defined(Package['bash'])            { package { 'bash':            ensure => present } }
  if ! defined(Package['curl'])            { package { 'curl':            ensure => present } }
  if ! defined(Package['bzip2'])           { package { 'bzip2':           ensure => present } }
  if ! defined(Package['gawk'])            { package { 'gawk':            ensure => present } }

  # Generic Ruby dependencies
  if ! defined(Package['gcc'])              { package { 'gcc':              ensure => present } }
  if ! defined(Package['make'])             { package { 'make':             ensure => present } }
  if ! defined(Package['openssl'])          { package { 'openssl':          ensure => present } }
  if ! defined(Package['readline'])         { package { 'readline':         ensure => present } }
  if ! defined(Package['curl'])             { package { 'curl':             ensure => present } }
  if ! defined(Package['zlib'])             { package { 'zlib':             ensure => present } }
  if ! defined(Package['libyaml'])          { package { 'libyaml':          ensure => present } }
  if ! defined(Package['sqlite'])           { package { 'sqlite':           ensure => present } }
  if ! defined(Package['autoconf'])         { package { 'autoconf':         ensure => present } }
  if ! defined(Package['ncurses'])          { package { 'ncurses':          ensure => present } }
  if ! defined(Package['automake'])         { package { 'automake':         ensure => present } }
  if ! defined(Package['libtool'])          { package { 'libtool':          ensure => present } }
  if ! defined(Package['bison'])            { package { 'bison':            ensure => present } }
  if ! defined(Package['pkg-config'])       { package { 'pkg-config':       ensure => present } }
  if ! defined(Package['libffi'])           { package { 'libffi':           ensure => present } }

}
