class ldapinstall {
  
  package { 'openldap-servers': 
    ensure =>'latest'
  }

  package { 'openldap-clients': 
    ensure =>'latest'
  }

  
  file { '/etc/openldap/ldap-init.ldif':
    content => template('ldapinstall/ldap-init.ldif.erb'),
    owner   => ldap,
    group   => ldap,
    mode    => '0644',
    require => Package['openldap-clients'],
  }

  file { '/etc/openldap/slapd.conf':
    content => template('ldapinstall/slapd.conf.erb'),
    owner   => ldap,
    group   => ldap,
    mode    => '0644',
    require => Package['openldap-clients'],
  }

  #exec { 'ldap_initial':
  #  command   => '',
  #  provider  => shell,
  #  subscribe => Package['mysql-server'],
  #}
 
  service { 'slapd':
    ensure  => 'running',
    require => Package['mysql-server'],
  }

   
  package { 'phpldapadmin': 
    ensure =>'latest',
    require => Package['mysql-server'],
  }

  service { 'httpd':
    ensure  => 'running',
    require => Package['phpldapadmin'],
  }
  
 

}
