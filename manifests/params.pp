# Class: squid::params
#
# This class manages Squid parameters

class squid::params {

  $ensure_service = 'running'
  $enable_service = true

  case $::operatingsystem {

    /^(Debian|Ubuntu)$/: {

      case $::operatingsystemrelease {

        /^(8.*|14\.04)$/: {
          $package_name = 'squid3'
          $service_name = 'squid3'
          $config       = '/etc/squid3/squid.conf'
          $config_user  = 'root'
          $config_group = 'root'
          $daemon_user  = 'proxy'
          $daemon_group = 'proxy'
        }
        /^(9.*)$/: {
          $package_name = 'squid3'
          $service_name = 'squid'
          $config       = '/etc/squid/squid.conf'
          $config_user  = 'root'
          $config_group = 'root'
          $daemon_user  = 'proxy'
          $daemon_group = 'proxy'
        }
        /^16\.04$/: {
          $package_name = 'squid'
          $service_name = 'squid'
          $config       = '/etc/squid/squid.conf'
          $config_user  = 'root'
          $config_group = 'root'
          $daemon_user  = 'proxy'
          $daemon_group = 'proxy'
        }
        default: {
          $package_name = 'squid'
          $service_name = 'squid'
          $config       = '/etc/squid/squid.conf'
          $config_user  = 'root'
          $config_group = 'squid'
          $daemon_user  = 'squid'
          $daemon_group = 'squid'
        }
      }
    }
    'FreeBSD': {
      $package_name = 'squid'
      $service_name = 'squid'
      $config       = '/usr/local/etc/squid/squid.conf'
      $config_user  = 'root'
      $config_group = 'squid'
      $daemon_user  = 'squid'
      $daemon_group = 'squid'
    }
    default: {
      $package_name = 'squid'
      $service_name = 'squid'
      $config       = '/etc/squid/squid.conf'
      $config_user  = 'root'
      $config_group = 'squid'
      $daemon_user  = 'squid'
      $daemon_group = 'squid'
    }
  }
}
