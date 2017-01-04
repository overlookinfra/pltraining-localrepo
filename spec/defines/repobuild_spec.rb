require 'spec_helper'

describe 'localrepo::repobuild', :type => :define do
  let(:title) { 'base_pkgs' }

  let(:facts) { {
    :osfamily                  => 'RedHat',
    :operatingsystem           => 'CentOS',
    :operatingsystemmajrelease => '7',
    :architecture              => 'x86_64',
  } }

  let(:params) { {
    :repopath => '/var/yum/mirror/centos/7/os/x86_64',
    :repoer   => 'createrepo',
    :repoops  => '-C -p',
    :name     => 'curl',
  } }

  it { is_expected.to compile }
  it { is_expected.to contain_exec("curl_build")
      .with({
        'command' => 'createrepo -C -p /var/yum/mirror/centos/7/os/x86_64',
        'user' => 'root',
        'group' => 'root',
        'path' => '/usr/bin:/bin',
        'refreshonly' => true,
      })
  }

  it { is_expected.to contain_yumrepo("curl")
      .with({
        'descr' => 'Locally stored packages for curl',
        'enabled' => '1',
        'baseurl' => 'file:///var/yum/mirror/centos/7/os/x86_64',
        'gpgcheck' => '0',
        'priority' => '10',
      }).that_requires('Exec[curl_build]')
  }

end
