class profile::mineserver {
  Package { ensure => 'installed' }
  $packages = [ 'screen', ]
  package { $packages: }
  
  file { '/opt/minecraft': ensure => 'directory', }
  
  file { '/opt/minecraft/server.jar':
    ensure => file,
    source => 'https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar',
    replace => false,
  }
  
  file {'/opt/minecraft/eula.txt':
    ensure => file,
    content => 'eula=true'
  }
  
  file { '/etc/systemd/system/mineserver.service':
    ensure => file,
    source => '/vagrant/mineserver.service',
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  ~> service {'mineserver':
  ensure => 'running',
  }
#  service { 'mineserver': ensure => running, enable => true, }
#  service { 'httpd': ensure => running, enable => true, }
 # wget::retrieve { "download jar":
 #   source      => 'http://zala.by/sites/default/files/ZALA_3.1.1_setup.exe',
 #   destination => '/opt/minecraft',
 #   timeout     => 5,
 #   verbose     => true,
 # }
 # include wget
}
