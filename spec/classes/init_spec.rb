require 'spec_helper'

describe 'motd' do
  let(:facts) do 
     {
       :concat_basedir          => '/doesnotexist',
       :operatingsystem         => 'CentOS',
       :operatingsystemrelease  => '6.5',
     }
  end
  
  it do
    should compile()
  end

  it do 
    should contain_concat("/etc/motd").with({
     'ensure'  => 'present',
     'owner'   => 'root',
     'group'   => 'root',
     'mode'    => '0644',
    })
  end

  it do
    should contain_file('/etc/issue').with({
      :ensure   => 'file',
      :owner    => 'root',
      :group    => 'root',
      :mode     => '0644',
      :content  => 'CentOS release 6.5
Kernel \r on an \m

'
    })
  end

  it do
    should contain_file('/etc/issue.net').with({
      :ensure => 'file',
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0644',
      :content  => 'CentOS release 6.5
Kernel \r on an \m

'
    })
  end

  context 'when issue_content is a long string' do
    let(:params) {{ :issue_content => "This system is available to authorized users only. User activities are subject to monitoring." }}

    it do
      should contain_file('/etc/issue').with_content('This system is available to authorized users only. User activities are subject to
monitoring.

')
    end
  end

  context 'when center_issue_content => true' do
    let(:params) {{ :center_issue_content => true }}

    it do
      should contain_file('/etc/issue')
    end
  end

end

