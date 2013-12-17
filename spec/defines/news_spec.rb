require 'spec_helper'

describe 'motd::news' do
  let(:facts) do 
     { :concat_basedir => '/doesnotexist' }
  end
  let(:title) {'New title'}
  

  context 'with date => "2013-12-11"' do
    let(:params) { { :date => '2013-12-11'}}
    shortdate = '2013-12-11'.gsub(/^(\d+)\-(\d+)\-(\d+)$/,'\1\2')
    it do 
      should contain_file("/etc/motd-archive/#{shortdate}").with({
       'ensure'  => 'present',
       'owner'   => 'root',
       'group'   => 'root',
       'mode'    => '0644',
      })
   end
  end

end

