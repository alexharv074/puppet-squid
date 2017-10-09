require 'spec_helper'

describe 'squid' do

  squid_conf = <<~EOF
    http_port 3128
    acl localnet src 192.168.1.0/24
    http_access allow localnet
    http_access deny all
  EOF

  on_supported_os.each do |os, facts|

    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with a simple squid.conf' do

        let(:params) do
          {
            squid_conf: squid_conf,
          }
        end

        it 'write out a compiled catalog' do
          is_expected.to compile.with_all_deps
          File.write(
            "catalogs/#{os}.json",
            PSON.pretty_generate(catalogue)
          )
        end

        it { is_expected.to contain_class('squid') }
        it { is_expected.to contain_class('squid::install') }
        it { is_expected.to contain_class('squid::config') }
        it { is_expected.to contain_class('squid::service') }

        case facts[:operatingsystem]

        when 'Debian'
          context 'when on Debian' do
            it { is_expected.to contain_package('squid3').with_ensure('present') }
            it { is_expected.to contain_service('squid3').with_ensure('running') }
            it { is_expected.to contain_file('/etc/squid3/squid.conf').with_group('root') }
            it { is_expected.to contain_file('/etc/squid3/squid.conf').with_owner('root') }

            it 'squid.conf should contain content' do
              is_expected.to contain_file('/etc/squid3/squid.conf').with_content(squid_conf)
            end
          end

        when 'Ubuntu'

          case facts[:operatingsystemrelease]

          when '14.04'
            context 'when on Ubuntu 14.04' do
              it { is_expected.to contain_package('squid3').with_ensure('present') }
              it { is_expected.to contain_service('squid3').with_ensure('running') }
              it { is_expected.to contain_file('/etc/squid3/squid.conf').with_group('root') }
              it { is_expected.to contain_file('/etc/squid3/squid.conf').with_owner('root') }
            end

          when '16.04'
            context 'when on Ubuntu 16.04' do
              it { is_expected.to contain_package('squid').with_ensure('present') }
              it { is_expected.to contain_service('squid').with_ensure('running') }
              it { is_expected.to contain_file('/etc/squid/squid.conf').with_group('root') }
              it { is_expected.to contain_file('/etc/squid/squid.conf').with_owner('root') }
            end
          end

        when 'FreeBSD'
          context 'when on FreeBSD' do
            it { is_expected.to contain_package('squid').with_ensure('present') }
            it { is_expected.to contain_service('squid').with_ensure('running') }
            it { is_expected.to contain_file('/usr/local/etc/squid/squid.conf').with_group('squid') }
            it { is_expected.to contain_file('/usr/local/etc/squid/squid.conf').with_owner('root') }
          end

        else
          context 'when on any other supported OS' do
            it { is_expected.to contain_package('squid').with_ensure('present') }
            it { is_expected.to contain_service('squid').with_ensure('running') }
            it { is_expected.to contain_file('/etc/squid/squid.conf').with_group('squid') }
            it { is_expected.to contain_file('/etc/squid/squid.conf').with_owner('root') }
          end
        end
      end
    end
  end
end
