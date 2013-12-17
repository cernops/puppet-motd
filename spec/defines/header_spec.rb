require 'spec_helper'

describe 'motd::header' do
  let(:facts) do 
     { :concat_basedir => '/doesnotexist' }
  end
  let(:title) {'New heading'}
  
  it do 
    should contain_concat__fragment('motd_frag_New heading')
  end  
end
