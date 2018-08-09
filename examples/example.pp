# this code will install rvm, and two rubies (2.1.10 and 2.4.4).
# In each ruby env, the gem 'bundler' will be installed
#

$user = 'someuser'
$home = '/home/someuser'

user { $user:
  ensure => present,
}


single_user_rvm::install { $user:
  home => $home,
}

single_user_rvm::install_ruby { 'ruby-2.1.10':
  user => $user,
  home => $home,
}

single_user_rvm::install_ruby { 'ruby-2.4.4':
  user => $user,
  home => $home,
}

single_user_rvm::gem { 'bundler-ruby-2.1.10':
  ruby_string => 'ruby-2.1.10',
  user        => 'vagrant',
  gem         => 'bundler',
}

single_user_rvm::gem { 'bundler-ruby-2.4.4':
  ruby_string => 'ruby-2.4.4',
  user        => 'vagrant',
  gem         => 'bundler',
}

