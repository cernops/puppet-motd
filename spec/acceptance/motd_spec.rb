require 'spec_helper_acceptance'

describe 'motd and motd::entry should work' do
    it 'should configure and work with no errors' do
      pp = <<-EOS
         include('motd')
         motd::header {'welcome': message => "Welcome to box ${::fqdn}"}
         motd::news {'It is christmas': date => '2013-12-25'}
         # Test case , should no error is a : is in message.
         motd::news{'Ternmination:': date => '2014-01-30'}
      EOS
      # Run it two times, it should be stable by then
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end
end
