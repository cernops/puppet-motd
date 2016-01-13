require 'spec_helper'

describe 'motd::news' do

  strftime      = ''
  current_date  = '2013-12-20'
  default_date  = '2013-12-11'

  # REF: https://github.com/rodjek/rspec-puppet/issues/102#issuecomment-35568335
  before(:each) do
    Puppet::Parser::Functions.newfunction(:strftime, :type => :rvalue) {
      |args| strftime.call(args[0])
    }
    strftime.stubs(:call).returns(current_date)
  end

  let(:facts) {{ :concat_basedir         => '/doesnotexist',
                 :operatingsystemmajrelease => '22' }}
  let(:title) {'New title'}

  let(:shortdate) { default_date.gsub(/^(\d+)\-(\d+)\-(\d+)$/,'\1\2') }

  context 'with date => "2013-12-11"' do
    let(:params) { { :date => '2013-12-11'}}

    it do 
      should contain_concat("/etc/motd-archive/#{shortdate}").with({
       'ensure'  => 'present',
       'owner'   => 'root',
       'group'   => 'root',
       'mode'    => '0644',
      })
    end
  end

  context 'with newstitle => "Foo"' do
    let(:params) {{ :newstitle => "Foo", :date => '2013-12-11' }}

    it do
      should contain_concat__fragment('motd_frag_New title').with_content("* 2013-12-11 - Foo\n")
    end
  end

  context 'when message over line_length' do
    let(:params) do
      {
        :date => '2013-12-11',
        :message => "Some very long message that requires being wrapped to a new line of text.",
      }
    end

    it do
      should contain_concat__fragment('motd_frag_New title').with_content("* 2013-12-11 - New title
*   Some very long message that requires being wrapped to a new line
*   of text.
")
    end
  end

  context 'when motd::news_line_length => 100 with long message' do
    let(:pre_condition) { "class { 'motd': news_line_length => 100 }" }
    let(:params) do
      {
        :date => '2013-12-11',
        :message => "Some very long message that requires being wrapped to a new line of text.",
      }
    end

    it do
      should contain_concat__fragment('motd_frag_New title').with_content("* 2013-12-11 - New title
*   Some very long message that requires being wrapped to a new line of text.
")
    end
  end

  context 'when message is an array' do
    let(:params) do
      {
        :date => '2013-12-11',
        :message => [ "Line 1", "Line 2", "Line 3" ],
      }
    end

    it do
      should contain_concat__fragment('motd_frag_New title').with_content("* 2013-12-11 - New title
*   Line 1
*   Line 2
*   Line 3
")
    end
  end

  context 'with major matching os' do
    let(:params) {{ :newstitle => "Foo", :date => '2013-12-11', :major => ['15','22'] }}

    it do
      should contain_concat__fragment('motd_frag_New title').with_content("* 2013-12-11 - Foo\n")
    end
  end

  context 'with major not matching os' do
    let(:params) {{ :newstitle => "Foo", :date => '2013-12-11', :major => ['15','18'] }}

    it do
      should_not contain_concat__fragment('motd_frag_New title')
    end
  end



end

