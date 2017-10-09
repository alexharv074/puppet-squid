class squid::config {

  file { $squid::config:
    ensure  => file,
    mode    => '0644',
    owner   => $squid::config_user,
    group   => $squid::config_group,
    content => $squid::squid_conf,
  }

}
