require 'spec_helper'

describe "localrepo" do
  let(:node) { 'test.example.com' }

  let(:facts) { {
    :osfamily                  => 'RedHat',
    :operatingsystem           => 'CentOS',
    :operatingsystemmajrelease => '7',
    :architecture              => 'x86_64',
  } }

  let(:pre_condition) {
    <<-EOF
      include 'epel'
    EOF
  }

  it { is_expected.to compile.with_all_deps }

  it {
    is_expected.to contain_file("/var/yum")
      .with({
        'ensure' => 'directory',
        'recurse' => true,
      })
  }

  it {
    is_expected.to contain_file("/var/yum/mirror")
      .with({
        'ensure' => 'directory',
        'recurse' => true,
      })
  }

  it {
    is_expected.to contain_file("/var/yum/mirror/epel")
      .with({
        'ensure' => 'directory',
        'recurse' => true,
      })
  }

  it {
    is_expected.to contain_file("/var/yum/mirror/epel/7")
      .with({
        'ensure' => 'directory',
        'recurse' => true,
      })
  }

  it {
    is_expected.to contain_file("/var/yum/mirror/epel/7/local")
      .with({
        'ensure' => 'directory',
        'recurse' => true,
      })
  }

  it {
    is_expected.to contain_file("/var/yum/mirror/centos")
      .with({
        'ensure' => 'directory',
        'recurse' => true,
      })
  }

  it {
    is_expected.to contain_file("/var/yum/mirror/centos/7")
      .with({
        'ensure' => 'directory',
        'recurse' => true,
      })
  }

  it {
    is_expected.to contain_file("/var/yum/mirror/centos/7/os")
      .with({
        'ensure' => 'directory',
        'recurse' => true,
      })
  }

  it {
    is_expected.to contain_file("/var/yum/mirror/centos/7/updates")
      .with({
        'ensure' => 'directory',
        'recurse' => true,
      })
  }

  it {
    is_expected.to contain_file("/var/yum/mirror/centos/7/extras")
      .with({
        'ensure' => 'directory',
        'recurse' => true,
      })
  }

  it {
    is_expected.to contain_file("/var/yum/mirror/classroom")
      .with({
        'ensure' => 'directory',
        'recurse' => true,
      })
  }

  it {
    is_expected.to contain_file("/var/yum/mirror/classroom/7")
      .with({
        'ensure' => 'directory',
        'recurse' => true,
      })
  }

  it {
    is_expected.to contain_file("/var/yum/mirror/classroom/7/local")
      .with({
        'ensure' => 'directory',
        'recurse' => true,
      })
  }

  it {
    is_expected.to contain_localrepo__pkgsync("base_pkgs")
      .with({
        'repopath' => '/var/yum/mirror/centos/7/os/x86_64',
        'syncer' => 'yumdownloader',
        'source' => 'base',
      }).that_notifies('localrepo::repobuild[base_local]')
  }

  it {
    is_expected.to contain_localrepo__repobuild("base_local")
      .with({
        'repopath' => '/var/yum/mirror/centos/7/os/x86_64',
      }).that_requires('Class[localrepo::packages]')
  }

  it {
    is_expected.to contain_localrepo__repobuild("base_local")
      .with({
        'repopath' => '/var/yum/mirror/centos/7/os/x86_64',
      }).that_notifies('Exec[makecache]')
  }

  it {
    is_expected.to contain_localrepo__pkgsync("extras_pkgs")
      .with({
        'repopath' => '/var/yum/mirror/centos/7/extras/x86_64',
        'syncer' => 'yumdownloader',
        'source' => 'base',
      }).that_notifies('localrepo::repobuild[extras_local]')
  }

  it {
    is_expected.to contain_localrepo__repobuild("extras_local")
      .with({
        'repopath' => '/var/yum/mirror/centos/7/extras/x86_64',
      }).that_requires('Class[localrepo::packages]')
  }

  it {
    is_expected.to contain_localrepo__repobuild("extras_local")
      .with({
        'repopath' => '/var/yum/mirror/centos/7/extras/x86_64',
      }).that_notifies('Exec[makecache]')
  }

  it {
    is_expected.to contain_localrepo__pkgsync("updates_pkgs")
      .with({
        'repopath' => '/var/yum/mirror/centos/7/updates/x86_64',
        'syncer' => 'yumdownloader',
        'source' => 'base',
      }).that_notifies('localrepo::repobuild[updates_local]')
  }

  it {
    is_expected.to contain_localrepo__repobuild("updates_local")
      .with({
        'repopath' => '/var/yum/mirror/centos/7/updates/x86_64',
      }).that_requires('Class[localrepo::packages]')
  }

  it {
    is_expected.to contain_localrepo__repobuild("updates_local")
      .with({
        'repopath' => '/var/yum/mirror/centos/7/updates/x86_64',
      }).that_notifies('Exec[makecache]')
  }

  it {
    is_expected.to contain_localrepo__pkgsync("epel_pkgs")
      .with({
        'repopath' => '/var/yum/mirror/epel/7/local/x86_64',
        'syncer' => 'yumdownloader',
        'source' => 'epel',
      }).that_requires('Class[epel]')
  }

  it {
    is_expected.to contain_localrepo__pkgsync("epel_pkgs")
      .with({
        'repopath' => '/var/yum/mirror/epel/7/local/x86_64',
        'syncer' => 'yumdownloader',
        'source' => 'epel',
      }).that_notifies('localrepo::repobuild[epel_local]')
  }

  it {
    is_expected.to contain_localrepo__repobuild("epel_local")
      .with({
        'repopath' => '/var/yum/mirror/epel/7/local/x86_64',
      }).that_requires('Class[localrepo::packages]')
  }

  it {
    is_expected.to contain_localrepo__repobuild("epel_local")
      .with({
        'repopath' => '/var/yum/mirror/epel/7/local/x86_64',
      }).that_notifies('Exec[makecache]')
  }

  it {
    is_expected.to contain_localrepo__pkgsync("classroom_pkgs")
      .with({
        'repopath' => '/var/yum/mirror/classroom/7/local/x86_64',
        'syncer' => 'wget',
      }).that_notifies('localrepo::repobuild[classroom]')
  }

  it {
    is_expected.to contain_localrepo__repobuild("classroom")
      .with({
        'repopath' => '/var/yum/mirror/classroom/7/local/x86_64',
      }).that_requires('Class[localrepo::packages]')
  }

  it {
    is_expected.to contain_localrepo__repobuild("classroom")
      .with({
        'repopath' => '/var/yum/mirror/classroom/7/local/x86_64',
      }).that_notifies('Exec[makecache]')
  }

  it {
    is_expected.to contain_exec("makecache")
      .with({
        'command' => 'yum makecache',
        'path' => '/usr/bin',
        'refreshonly' => true,
        'user' => 'root',
        'group' => 'root',
      })
  }

end
