require 'spec_helper_acceptance'

describe 'single_user_rvm::install_ruby single_user_rvm::install_ruby' do
  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
      single_user_rvm::install_ruby{'some_value':
        # ruby_string: "$title",
        # user: "rvm",
        # verify_downloads: :undef,
        # force_binary: :undef,
        # disable_binary: :undef,
        # movable: :undef,
        # home: :undef,
        # proxy: :undef,

      }
      EOS

    # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

  end
end
