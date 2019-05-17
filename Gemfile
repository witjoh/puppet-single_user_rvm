source "https://rubygems.org"

group :test do
    gem "rake"
    gem "puppet", ENV['PUPPET_GEM_VERSION'] || '~> 3.8.3'
    gem "rspec-puppet"
    gem "puppetlabs_spec_helper"
    gem 'rspec-puppet-utils'
    gem "metadata-json-lint"
    gem 'puppet-syntax'
    gem 'puppet-lint'

    gem "semantic_puppet"
    gem "yaml-lint-ng"

    gem "rspec-puppet-facts"
    gem "rspec_junit_formatter"

    gem "puppet-lint-absolute_classname-check"
    gem "puppet-lint-leading_zero-check"
    gem "puppet-lint-trailing_comma-check"
    gem "puppet-lint-version_comparison-check"
    gem "puppet-lint-classes_and_types_beginning_with_digits-check"
    gem "puppet-lint-unquoted_string-check"    

end

# to disable installing the 50+ gems this group contains run : bundle install --without integration
group :integration do
    gem "beaker"
    gem "beaker-rspec"
    gem "beaker-puppet_install_helper"
    gem "beaker-module_install_helper"
    gem "vagrant-wrapper"
    gem 'serverspec'
end

group :development do
    gem "travis"
    gem "travis-lint"
    gem "puppet-blacksmith"
    gem 'puppet-debugger'
# This gem causes bundler install erorrs
#    gem "guard-rake"
end
