class profile::mineserver {
  Package { ensure => 'installed' }
  $packages = [ 'screen', ]
  package { $packages: }
  
  file { '/opt/minecraft': ensure => 'directory', }
  
  wget::retrieve { "download jar":
    source      => 'http://zala.by/sites/default/files/ZALA_3.1.1_setup.exe',
    destination => '/opt/minecraft',
    timeout     => 0,
    verbose     => true,
  }
  include wget
}
