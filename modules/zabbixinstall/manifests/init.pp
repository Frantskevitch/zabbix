class zabbixinstall {
  
  package { 'php': 
    ensure =>'latest'
  }

  package { 'mysql': 
    ensure =>'latest'
  }

  package { 'mysql-server': 
    ensure =>'latest',
    require => Package['mysql'],
  }

  file { '/etc/my.cnf':
    content => template('zabbixinstall/my.cnf.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['mysql-server'],
  }

  exec { 'mqsql_initial':
    command   => '/usr/bin/mysql_install_db --user=mysql',
    provider  => shell,
    subscribe => Package['mysql-server'],
  }
 
  service { 'mysqld':
    ensure  => 'running',
    require => Package['mysql-server'],
  }

  yumrepo { 'zabbix':
    ensure => 'present',
    baseurl => 'http://repo.zabbix.com/zabbix/2.2/rhel/6/$basearch/',
    descr => 'Zabbix Official Repository - $basearch',
    enabled => '1',
    gpgcheck => '1',
    gpgkey => 'http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX',
  }
  
  package { 'zabbix': 
    ensure =>'latest',
    require => Package['mysql-server'],
  }
  
  package { 'zabbix-server': 
    ensure =>'latest',
    require => Package['zabbix'],
  }

  package { 'zabbix-server-mysql': 
    ensure =>'latest',
    require => Package['zabbix-server'],
  }

  package { 'zabbix-web-mysql': 
    ensure =>'latest',
    require => Package['zabbix-server-mysql'],
  }
  
  package { 'zabbix-agent': 
    ensure =>'latest',
    require => Package['zabbix-server-mysql'],
  }


}
