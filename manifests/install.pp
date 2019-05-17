# == Define: single_user_rvm::install
#
# Installs RVM.
#
# More info on installation: https://rvm.io/rvm/install
#
# === Parameters
#
# Document parameters here
#
# [*user*]
#   The user for which RVM will be installed. Defaults to the value of the title string.
#   IMPORTANT:  The user is not managed by this module, but should exist on the system.
#
# [*version*]
#   Version of RVM to install. This version *will* be enforced. That is, the current RVM version will be tested against
#   this and if different it will be changed to the one specified. However this does not mean that setting the version
#   to one that changes (like stable or latest) will pull the latest of that version and apply it. To enable that kind
#   of behaviour use the auto_upgrade parameter. Defaults to 'stable'.
#
#   More info on versions: https://rvm.io/rvm/upgrading.
#
# [*rvmrc*]
#   Content for the global .rvmrc file placed in the user's homedir. If empty, .rvmrc will no be touched.
#   Defaults to false.
#
# [*home*]
#   Set to home directory of user. Defaults to /home/${user}.
#
# [*auto_upgrade*]
#   Set to true to enable automatically upgrading RVM. That essentially means that `rvm get $version` will be run on
#   every puppet run. This essentially breaks the puppet "idempotent" feature but that may be desireable as there's no
#   other way to ensure you always have the latest stable or latest master version for example. This setting probably
#   makes no sense combined with a static version (like 1.22.0 for example) as there will never be something new to
#   fetch. Defaults to false.
#
# [*proxy*]
#   Set if you require a HTTP proxy to install RVM.  For example `proxy.localnet:8080`.
#
# === Examples
#
# Plain simple installation for user 'dude'
#
#   single_user_rvm::install { 'dude': }
#
# Install version 'head' for user dude
#
#   single_user_rvm::install { 'dude':
#     version => 'head',
#   }
#
# Ensure always having the latest and greatest RVM.
#
#   single_user_rvm::install { 'dude':
#     version      => 'latest',
#     auto_upgrade => true,
#   }
#
# Set .rvmrc configuration (example auto-trusts all rvmrc's in the system).
#
#   single_user_rvm::install { 'dude':
#     rvmrc => 'rvm_trust_rvmrcs_flag=1',
#   }
#
# Use a custom home directory.
#
#   single_user_rvm::install { 'dude':
#     home  => '/path/to/special/home',
#   }
#
# Use a title different than the user name.
#
#   single_user_rvm::install { 'some other title':
#     user  => 'dude',
#     rvmrc => 'rvm_trust_rvmrcs_flag=1',
#     home  => '/path/to/special/home',
#   }
#
# Use an HTTP proxy to install rvm.
#
#   single_user_rvm::install { 'dude':
#     proxy => "proxy.localnet:8080"
#   }
#
define single_user_rvm::install (
  $user         = $title,
  $version      = 'stable',
  $rvmrc        = undef,
  $home         = undef,
  $proxy        = undef,
  $auto_upgrade = false,
) {

  if $home {
    $homedir = $home
  } else {
    $homedir = "/home/${user}"
  }

  require ::single_user_rvm::dependencies

  if $proxy
  {
    $proxy_opt = "export https_proxy=\"http://${proxy}\" &&"
  } else {
    $proxy_opt = ''
  }

  if $::osfamily == 'Darwin' {
    $import_key = strip("${proxy_opt} curl -sSL https://rvm.io/mpapis.asc | gpg --import -")
  } else {
    $import_key = strip("${proxy_opt} curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -")
  }
  $install_command = strip("${proxy_opt} curl -L https://get.rvm.io | bash -s ${version}")

  exec { $import_key:
    path        => '/usr/bin:/usr/sbin:/bin:/sbin',
    user        => $user,
    onlyif      => "test `gpg --list-keys | grep 'RVM signing' | wc -l` -eq 0",
    cwd         => $homedir,
    environment => "HOME=${homedir}",
  }
  exec { $install_command:
    path        => '/usr/bin:/usr/sbin:/bin',
    creates     => "${homedir}/.rvm/bin/rvm",
    user        => $user,
    cwd         => $homedir,
    environment => "HOME=${homedir}",
    require     => [ Package['curl'], Package['bash'], User[$user], Exec[$import_key] ],
  }

  $rvm_executable = "${homedir}/.rvm/bin/rvm"
  $upgrade_command = strip("${proxy_opt} ${rvm_executable} get ${version}")

  if $auto_upgrade {

    exec { $upgrade_command:
      path        => '/usr/bin:/usr/sbin:/bin',
      user        => $user,
      cwd         => $homedir,
      environment => "HOME=${homedir}",
      require     => Exec[$install_command],
    }

  } else {

    if $version == 'head' {
      $version_check = ' (master) '
    } elsif $version =~ /^\d+\.\d+\.\d+/ {
      $version_check = " ${version} (version) "
    } else {
      $version_check = " (${version}) "
    }

    $version_check_command = "${rvm_executable} version | grep \"${version_check}\""

    exec { $upgrade_command:
      path        => '/usr/bin:/usr/sbin:/bin',
      unless      => $version_check_command,
      user        => $user,
      cwd         => $homedir,
      environment => "HOME=${homedir}",
      require     => Exec[$install_command],
    }
  }

  if $rvmrc {
    file { "${homedir}/.rvmrc":
      ensure  => present,
      owner   => $user,
      content => $rvmrc,
    }
  }
}
