require 'spec_helper'

describe "localrepo::packages" do
  let(:node) { 'test.example.com' }

  let(:facts) { {
    :osfamily                  => 'RedHat',
    :operatingsystem           => 'CentOS',
    :operatingsystemmajrelease => '7',
    :architecture              => 'x86_64',
  } }

  it { is_expected.to compile.with_all_deps }

  it {
    is_expected.to contain_package("createrepo")
      .with({
        'ensure' => 'present',
      })
  }

  it {
    is_expected.to contain_package("yum-utils")
      .with({
        'ensure' => 'present',
      })
  }

end
