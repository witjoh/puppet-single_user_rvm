# single_user_rvm::gem
#
# Installs a gem for the specifiv rvm version for the given user
#
# [* ruby_string *]
# The ruby version string as used by rvm
# This needs to be installed using single_user_rvm::install_ruby type
#
# [* user *]
# User where the gems needs to e installed for
#
# [* ensure *]
# present/absen/vesrion of the gem to be installed
#
# [* gem *]
# Name of the gem to be installed
define single_user_rvm::gem (
  $ruby_string,
  $user,
  $ensure = present,
  $gem    = $name
) {

  single_user_rvm::bash_exec { "rvm_switch_for_${user}_${ruby_string}_${gem}":
    command   => "rvm use --default ${ruby_string}",
    user      => $user,
    logoutput => false,
    unless    => "rvm current | grep '${ruby_string}'"
  }

  if $ensure == absent {
    $uninstall_command = "gem uninstall --ignore-dependencies -x ${gem}"
    $has_version_check_command = "gem list | grep '^${gem} '"

    single_user_rvm::bash_exec { "gem-${gem}-${ruby_string}-for-${user}-ensure-${ensure}":
      provider => shell,
      command  => $uninstall_command,
      user     => $user,
      require  => Single_user_rvm::Bash_exec["rvm_switch_for_${user}_${ruby_string}_${gem}"],
      onlyif  => $has_version_check_command
    }
  } else {
    if $ensure == present {
      $command = "gem install ${gem}"
      $check_command = "gem list --local -i ${gem} | grep true"

      single_user_rvm::bash_exec { "install-gem-${gem}-${ruby_string}-for-${user}-ensure-${ensure}":
        provider => shell,
        command  => $command,
        user     => $user,
        require  => Single_user_rvm::Bash_exec["rvm_switch_for_${user}_${ruby_string}_${gem}"],
        unless   => $check_command
      }
    } else {
      # we cannot use 'gem list --no-installed ${gem}' here, because e.g. jekyll will match jekyll-sass, too!
      $has_wrong_version_check_command = "gem list --local | grep '^${gem} ' | grep -v '${ensure}'"
      $uninstall_old_version_and_install_new_version_command = "gem uninstall --ignore-dependencies -x ${gem} 2>/dev/null && gem install ${gem}:${ensure}"

      # we cannot use 'gem list --installed ${gem}' here, because e.g. jekyll will match jekyll-sass, too!
      $has_no_version_check_command = "gem list | grep '^${gem} '"
      $install_first_version_command = "gem install ${gem} -v ${ensure}"

      single_user_rvm::bash_exec { "reinstall-gem-${gem}-${ruby_string}-for-${user}-ensure-${ensure}":
        provider  => shell,
        command   => $uninstall_old_version_and_install_new_version_command,
        user      => $user,
        logoutput => true,
        require   => Single_user_rvm::Bash_exec["rvm_switch_for_${user}_${ruby_string}_${gem}"],
        onlyif    => $has_wrong_version_check_command
      }

      single_user_rvm::bash_exec { "install-gem-${gem}-${ruby_string}-for-${user}-ensure-${ensure}":
        provider  => shell,
        command   => $install_first_version_command,
        user      => $user,
        logoutput => true,
        require   => Single_user_rvm::Bash_exec["rvm_switch_for_${user}_${ruby_string}_${gem}"],
        unless    => $has_no_version_check_command
      }
    }
  }
}
