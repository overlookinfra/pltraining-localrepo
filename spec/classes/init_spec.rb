require 'spec_helper'

describe "localrepo" do
  let(:node) { 'test.example.com' }

  let(:facts) { {
    :osfamily                  => 'RedHat',
    :operatingsystem           => 'CentOS',
    :operatingsystemmajrelease => '7',
    :architecture              => 'x86_64',
  } }

  let(:pre_condition) do
    <<-EOF
      include 'epel'
    EOF
  end

  it { is_expected.to compile.with_all_deps }
end
