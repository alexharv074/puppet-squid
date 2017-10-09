class squid::service {

  service { $squid::service_name:
    ensure => $squid::ensure_service,
    enable => $squid::enable_service,
  }

}
