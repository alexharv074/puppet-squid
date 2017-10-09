class squid (
  $squid_conf,
  $config         = $squid::params::config,
  $config_group   = $squid::params::config_group,
  $config_user    = $squid::params::config_user,
  $daemon_group   = $squid::params::daemon_group,
  $daemon_user    = $squid::params::daemon_user,
  $enable_service = $squid::params::enable_service,
  $ensure_service = $squid::params::ensure_service,
  $package_name   = $squid::params::package_name,
  $service_name   = $squid::params::service_name,
) inherits squid::params {

  contain squid::install
  contain squid::config
  contain squid::service

  Class['squid::install']
  -> Class['squid::config']
  ~> Class['squid::service']
}
