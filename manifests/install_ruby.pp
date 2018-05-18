# == Define: single_user_rvm::install_ruby
#
# Installs an RVM Ruby.
#
# Stolen documentation from `rvm help install` (as it's not available somewhere else):
#
# ### Binary rubies
#
# By default RVM will try to download binary ruby package instead of compiling.
# If such package is not available normal compilation will be performed.
# Using binary builds can significantly decrease ruby installation time.
#
# There are two options controlling binary rubies installation:
#
# - `--binary` - force binary installation, do not try to compile ruby.
# - `--disable-binary` - do not try binary ruby, always compile.
#
# More details about managing binary rubies can be found in `rvm help mount`.
#
# ### Movable rubies
#
# It is possible to build a ruby that can be moved to other locations, renamed
# or even moved to other machine - as long as the system matches.
#
# This option works only for ruby **1.9.3**, ruby **1.9.2** supports this only
# on systems without `/usr/lib64`.
#
# More details about managing binary builds can be found in `rvm help mount`.
#
# ## Verification
#
# `--verify-downloads {0,1,2}` specifies verification level:
#
# - `0` - only verified allowed,
# - `1` - allow missing checksum,
# - `2` - allow failed checksum.
#
# Please see the documentation for further information:
#
# - https://rvm.io/rubies/installing/
# - https://rvm.io/rubies/named/
#
# === Parameters
#
# Document parameters here
#
# [*ruby_string*]
#   Ruby version to install, be sure to use the full Ruby string as failing to do so will break the mechanism that
#   detects if the required ruby is already installed. Defaults to the value of the title string.
#
# [*user*]
#   The user for which this Ruby will be installed. Defaults to 'rvm'.
#
# [*verify_downloads*]
#   Set to a value that will be added to the --verify-downloads flag. If empty the whole flag will not be added. More
#   info on the flag function in doc above. Defaults to undef.
#
# [*force_binary*]
#   Set to true enable the --binary flag. More info on the flag function in doc above. Defaults to false.
#
# [*disable_binary*]
#   Set to true enable the --disable-binary flag. More info on the flag function in doc above. Defaults to false.
#
# [*movable*]
#   Set to true enable the --movable flag. More info on the flag function in doc above. Defaults to false.
#
# [*home*]
#   Set to home directory of user. Defaults to /home/${user}.
#
# [*proxy*]
#   Set to use a HTTP proxy.  For example: '10.10.10.17:8080'.  Defaults to no proxy.
#
# === Examples
#
# Install Ruby 2.0.0 p247 for user 'dude':
#
#   single_user_rvm::install_ruby { 'ruby-2.0.0-p247':
#     user => 'dude',
#   }
#
# Install Ruby 2.1.2 for user 'dude', via a HTTP proxy:
#
#   single_user_rvm::install_ruby { 'ruby-2.1.2':
#     user => 'dude',
#     proxy => 'proxy.localnet:8080'
#   }
#
define single_user_rvm::install_ruby (
  $ruby_string      = $title,
  $user             = 'rvm',
  $verify_downloads = undef,
  $force_binary     = false,
  $disable_binary   = false,
  $movable          = false,
  $home             = undef,
  $proxy            = undef,
) {

  if $home {
    $homedir = $home
  } else {
    $homedir = "/home/${user}"
  }

  if $force_binary {
    $binary_opt = '--binary'
  } else {
    $binary_opt = ''
  }

  if $disable_binary {
    $disable_binary_opt = '--disable-binary'
  } else {
    $disable_binary_opt = ''
  }

  if $movable {
    $movable_opt = '--movable'
  } else {
    $movable_opt = ''
  }

  if $verify_downloads {
    $verify_downloads_opt = "--verify-downloads ${verify_downloads}"
  } else {
    $verify_downloads_opt = ''
  }

  if $proxy {
    $proxy_opt = "--proxy ${proxy}"
  } else {
    $proxy_opt = ''
  }

  $command = "${homedir}/.rvm/bin/rvm ${proxy_opt} install ${ruby_string} ${binary_opt} ${disable_binary_opt} ${movable_opt} ${verify_downloads_opt}"

  exec { $command:
    path        => '/usr/bin:/usr/sbin:/bin',
    creates     => "${homedir}/.rvm/rubies/${ruby_string}/bin/ruby",
    timeout     => 3600, # takes too long... lets give it some time
    require     => Single_user_rvm::Install[$user],
    cwd         => $homedir,
    environment => "HOME=${homedir}",
  }
}
