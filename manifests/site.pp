node master.puppet {
  include nginx
 
  nginx::resource::server { 'localhost':
  listen_port => 80,
  proxy       => 'http://192.168.4.11:80',
  }
  nginx::resource::server { '127.0.0.1':
  listen_port => 81,
  proxy       => 'http://192.168.4.12:80',
  }
}

node slave1.puppet {
  Package { ensure => 'installed' }
  $packages = [ 'httpd', 'php' ]
  package { $packages: }
  
  service { 'httpd': ensure => running, enable => true, }
  
  file { '/root/README': 
    ensure => absent, 
  }
  file { '/etc/httpd/conf.d/01-demosite-static.conf':
    notify  => Service['httpd'],
    ensure => file,
    source => 'puppet:///modules/dev_conf/01-demosite-static.conf',
    replace => true,
  } 
  file { '/var/www/01-demosite-static': 
    ensure => 'directory', 
  }
  file { '/var/www/01-demosite-static/index.html':
    ensure => file,
    source => 'puppet:///modules/dev_web/index.html',
    replace => true,
  } 
}

node slave2.puppet {
  Package { ensure => 'installed' }
  $packages = [ 'httpd', 'php' ]
  package { $packages: }
  
  service { 'httpd': 
    ensure => running, 
    enable => true, 
  }
  
  file { '/root/README': 
    ensure => absent, 
  }
  file { '/etc/httpd/conf.d/01-demosite-php.conf':
    notify  => Service['httpd'],
    ensure => file,
    source => 'puppet:///modules/dev_conf/01-demosite-php.conf',
    replace => true,
  } 
  file { '/var/www/01-demosite-php': 
    ensure => 'directory', 
  }
  file { '/var/www/01-demosite-php/index.php':
    ensure => file,
    source => 'puppet:///modules/dev_web/index.php',
    replace => true,
  }
}

node mineserver.puppet {
  include role::mineserver
}
