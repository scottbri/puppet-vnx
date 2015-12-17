transport {'vnx5400':
  username => 'sysadmin',
  password => 'sysadmin',
  server   => '192.168.1.31',
  cli_path => '"C:\Program Files (x86)\EMC\Navisphere CLI\naviseccli.exe"'
}

vnx_storagepool {"puppet-pool":
  transport => Transport['vnx5400'],
  #disks => ['0_0_9', '0_0_10', '0_0_11', '0_0_12', '0_0_13', '1_1_9', '1_1_10', '1_1_11', '1_1_12', '1_1_13'],
  disks => ['0_0_5', '0_0_6', '0_0_7', '0_0_8', '0_0_9', '1_0_0', '1_0_1', '1_0_2', '1_0_3', '1_0_4'],
  raid_type => 'r_5',
  auto_tiering => 'scheduled',
  ensure_fastcache => 'true',
  ensure => present
}

vnx_lun {"sds01":
  transport => Transport['vnx5400'],
  require => Vnx_storagepool['puppet-pool'],
  pool_name => 'puppet-pool',
  type => 'thin',
  capacity => '10',
  size_qual => 'gb',
  initial_tier => 'highest_available',
  tiering_policy => 'auto_tier',
  auto_assign => 'true',
  ensure => present
}

vnx_lun {"sds02":
  transport => Transport['vnx5400'],
  require => Vnx_storagepool['puppet-pool'],
  pool_name => 'puppet-pool',
  type => 'thin',
  capacity => '10',
  size_qual => 'gb',
  initial_tier => 'highest_available',
  tiering_policy => 'auto_tier',
  auto_assign => 'true',
  ensure => present
}
