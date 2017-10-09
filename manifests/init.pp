class squid (

  String[1]       $squid_conf,

  Pattern[/squid.conf/] $config    = $squid::params::config,

  String[1]       $config_group   = $squid::params::config_group,
  String[1]       $config_user    = $squid::params::config_user,
  String[1]       $daemon_group   = $squid::params::daemon_group,
  String[1]       $daemon_user    = $squid::params::daemon_user,
  Boolean         $enable_service = $squid::params::enable_service,
  Enum['running', 'stopped']
                  $ensure_service = $squid::params::ensure_service,
  Pattern[/squid/] $package_name   = $squid::params::package_name,
  Pattern[/squid/] $service_name   = $squid::params::service_name,

) inherits squid::params {

  contain squid::install
  contain squid::config
  contain squid::service

  Class['squid::install']
  -> Class['squid::config']
  ~> Class['squid::service']
}
