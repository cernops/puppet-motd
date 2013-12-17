require 'spec_helper'

describe 'motd' do
  let(:facts) do 
     { :concat_basedir => '/doesnotexist' }
  end
  

  it do 
    should contain_concat("/etc/motd").with({
     'ensure'  => 'present',
     'owner'   => 'root',
     'group'   => 'root',
     'mode'    => '0644',
    })
  end

end

