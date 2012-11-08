class graphite(
	$storage_schemas = undef,
	$enable_udp      = 'False',
	$auth_file	 = undef,
	$vhost_alias	 = undef,
	$time_zone	 = 'Europe/Berlin'
) {

	class { 'graphite::install':
		notify => Class['graphite::config'],
	}

	class { 'graphite::config':
		storage_schemas => $storage_schemas,
		enable_udp	=> $enable_udp,
		auth_file	=> $auth_file,
		vhost_alias	=> $vhost_alias,
		require         => Class['graphite::install'],
		time_zone	=> $time_zone
	}

      	# Allow the end user to establish relationships to the "main" class
      	# and preserve the relationship to the implementation classes through
      	# a transitive relationship to the composite class.
      	anchor { 'graphite::begin': before => Class['graphite::install'] }
      	anchor { 'graphite::end': require => Class['graphite::config'] }
}
