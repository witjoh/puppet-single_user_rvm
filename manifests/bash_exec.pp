define single_user_rvm::bash_exec (
  $user,
  $command     = $name,
  $creates     = undef,
  $cwd         = undef,
  $environment = undef,
  $group       = undef,
  $logoutput   = undef,
  $onlyif      = undef,
  $path        = undef,
  $provider    = "posix",
  $refresh     = undef,
  $refreshonly = undef,
  $returns     = undef,
  $timeout     = undef,
  $tries       = undef,
  $try_sleep   = undef,
  $umask       = undef,
  $unless      = undef
) {
  if $cwd == undef {
    $command_prefix = ""
  } else {
    $command_prefix = "cd ${cwd} && "
  }

  $escaped_command = join(["/bin/su -l ${user} -c ", shellquote(join(['/bin/bash --login -c ', shellquote(join([$command_prefix, $command], ""))], ""))], "")

  if $unless == undef {
    $escaped_unless = undef
  } else {
    $escaped_unless = join(["/bin/su -l ${user} -c ", shellquote(join(['/bin/bash --login -c ', shellquote(join([$command_prefix, $unless], ""))], ""))], "")
  }

  if $onlyif == undef {
    $escaped_onlyif = undef
  } else {
    $escaped_onlyif = join(["/bin/su -l ${user} -c ", shellquote(join(['/bin/bash --login -c ', shellquote(join([$command_prefix, $onlyif], ""))], ""))], "")
  }

  exec { $name:
    command     => $escaped_command,
    creates     => $creates,
    cwd         => $cwd,
    environment => $environment,
    group       => $group,
    logoutput   => $logoutput,
    onlyif      => $escaped_onlyif,
    path        => $path,
    provider    => $provider,
    refresh     => $refresh,
    refreshonly => $refreshonly,
    returns     => $returns,
    timeout     => $timeout,
    tries       => $tries,
    try_sleep   => $try_sleep,
    umask       => $umask,
    unless      => $escaped_unless
  }
}
