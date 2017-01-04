require 'spec_helper'

describe 'localrepo::pkgsync' do

  let(:title) { 'test.puppetlabs.vm' }

  let(:facts) { {
    :osfamily                  => 'RedHat',
    :operatingsystem           => 'CentOS',
    :operatingsystemmajrelease => '7',
    :architecture              => 'x86_64',
  } }

  it {
    is_expected.to contain_file("/tmp/curl") }
      #.with({
      #  'content' => 'curl',
      #}).that_notifies('Exec[get_curl]')
  #}

  it {
    is_expected.to contain_file("/var/yum/x86_64/") }
      #.with({
      #  'ensure' => 'directory',
      #})
  #}

  it {
    is_expected.to contain_file("/var/yum/x86_64/RPMS/") }
      #.with({
      #  'ensure' => 'directory',
      #})
  #}

  it {
    is_expected.to contain_exec("get_curl") }
      #.with({
      #  'command' => "rsync -rltDvzph --delete --delete-after --include-from=/tmp/curl  --exclude=* mirrors.cat.pdx.edu /var/yum/x86_64/RPMS",
      #  'onlyif' => "rsync -rltDvzph --delete --delete-after -n --include-from=/tmp/curl  --exclude=* mirrors.cat.pdx.edu /var/yum/x86_64/RPMS | grep '.rpm'",
      #})
  #}

end
