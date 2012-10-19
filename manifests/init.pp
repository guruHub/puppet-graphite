class graphite(
	storage_schemas = undef
) {

	class { 'graphite::install':
		notify => Class['graphite::config'],
	}

	class { 'graphite::config':
		require         => Class['graphite::install']
	}

	if $storage_schemas {
		Class['grapite::config'] { 
			storage_schemas => $storage_schemas
		}
	}

      # Allow the end user to establish relationships to the "main" class
      # and preserve the relationship to the implementation classes through
      # a transitive relationship to the composite class.
      anchor { 'graphite::begin': before => Class['graphite::install'] }
      anchor { 'graphite::end': require => Class['graphite::config'] }
}
