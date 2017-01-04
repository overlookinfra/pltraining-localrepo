require 'spec_helper'

describe 'localrepo::pkgsync', :type => :define do
  let(:title) { 'base_pkgs' }
  let(:facts) { { :osfamily => 'RedHat', } }

  context 'rsync' == 'rsync' do
    let(:params) { {
      :pkglist  => '$name',
      :name     => 'curl',
      :server   => 'mirrors.cat.pdx.edu',
      :source   => '/var/yum/mirror/centos/7/os/x86_64',
      :syncer   => 'rsync',
      :syncops  => 'default',
      :repopath => '/var/yum/mirror/centos/7/os/x86_64',
    } }

    it { is_expected.to compile }
    it { is_expected.to contain_file('/tmp/curllist')
      .that_notifies('Exec[get_curl]') }
    it { is_expected.to contain_file("/var/yum/mirror/centos/7/os/x86_64")
      .with({ 'ensure' => 'directory', })
    }
    it { is_expected.to contain_file("/var/yum/mirror/centos/7/os/x86_64/RPMS")
      .with({ 'ensure' => 'directory', })
    }
    it { is_expected.to contain_exec("get_curl")
      .with({ 'command' => 'rsync -rltDvzPH --delete --delete-after --include-from=/tmp/curllist  --exclude=* mirrors.cat.pdx.edu/var/yum/mirror/centos/7/os/x86_64 /var/yum/mirror/centos/7/os/x86_64/RPMS' })
    }

  end

  context 'yumdownloader' == 'yumdownloader' do
    let(:params) { {
      :pkglist  => '$name',
      :name     => 'curl',
      :server   => 'mirrors.cat.pdx.edu',
      :source   => '/var/yum/mirror/centos/7/os/x86_64',
      :syncer   => 'yumdownloader',
      :syncops  => 'default',
      :repopath => '/var/yum/mirror/centos/7/os/x86_64',
    } }
    it { is_expected.to contain_exec("get_curl")
      .with({ 'command' => 'yumdownloader --destdir=/var/yum/mirror/centos/7/os/x86_64/RPMS --enablerepo=/var/yum/mirror/centos/7/os/x86_64 --resolve `cat /tmp/curllist`' })
    }
  end

  context 'wget' == 'wget' do
    let(:params) { {
      :pkglist  => '$name',
      :name     => 'curl',
      :server   => 'mirrors.cat.pdx.edu',
      :source   => '/var/yum/mirror/centos/7/os/x86_64',
      :syncer   => 'wget',
      :syncops  => 'default',
      :repopath => '/var/yum/mirror/centos/7/os/x86_64',
    } }
    it { is_expected.to contain_exec("get_curl")
      .with({ 'command' => 'wget  -i /tmp/curllist -P /var/yum/mirror/centos/7/os/x86_64/RPMS' })
    }
  end

end
