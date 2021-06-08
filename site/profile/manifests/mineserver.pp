class profile::mineserver {
  include wget
  
  Package { ensure => 'installed' }
  $packages = [ 'screen', ]
  package { $packages: }
  
  file { '/opt/minecraft': ensure => 'directory', }
  
  
  wget::retrieve { 'https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar':
    destination => '/opt/minecraft',
    timeout     => 0,
    verbose     => false,
  }
}
