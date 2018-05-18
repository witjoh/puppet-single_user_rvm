require 'spec_helper_acceptance'

describe 'single_user_rvm::install single_user_rvm::install' do
  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
      single_user_rvm::install{'some_value':
        # user: "$title",
        # version: "stable",
        # rvmrc: :undef,
        # home: :undef,
        # proxy: :undef,
        # auto_upgrade: false,

      }
      EOS

    # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

  end
end
