node slave1.puppet {
  Package { ensure => 'installed' }
  $packages = [ 'httpd', 'php' ]
  package { $packages: }
  
  service { 'httpd': ensure => running, enable => true, }
  
  file { '/root/README': ensure => absent, }
  file { '/etc/httpd/conf.d/01-demosite-static.conf':
    notify  => Service['httpd'],
    ensure => file,
    source => '/vagrant/web/apache_conf/01-demosite-static.conf',
    replace => true,
      } 
  file { '/var/www/01-demosite-static': ensure => 'directory', }
  file { '/var/www/01-demosite-static/index.html':
    ensure => file,
    source => '/vagrant/web/01-demosite-static/index.html',
    replace => true,
      } 
}

node slave2.puppet {
  Package { ensure => 'installed' }
  $packages = [ 'httpd', 'php' ]
  package { $packages: }
  
  service { 'httpd': ensure => running, enable => true, }
  
  file { '/root/README': ensure => absent, }
  file { '/etc/httpd/conf.d/01-demosite-php.conf':
    ensure => file,
	notify  => Service['httpd'],
    source => '/vagrant/web/apache_conf/01-demosite-php.conf',
    replace => true,
      } 
  file { '/var/www/01-demosite-php': ensure => 'directory', }
  file { '/var/www/01-demosite-php/index.php':
    ensure => file,
    source => '/vagrant/web/01-demosite-php/index.php',
    replace => true,
      }
}
