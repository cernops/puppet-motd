# Class: motd
class motd (
  $motd_header = $::motd::params::motd_header,
  $delimiter   = $::motd::params::delimiter
) inherits motd::params {
  $motd_archive = '/etc/motd-archive'
  $motd = '/etc/motd'

  file { $motd_archive:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  # Specify /etc/motd file.
  concat { $motd: mode => '0644', owner => 'root', group => 'root' }

  motd::header{'header':
    message => $delimiter,
    order   => '00'
  }
  concat::fragment { 'motd_header':
    target  => $motd,
    content => template('motd/motd.erb'),
    order   => '03',
  }
  motd::header{ 'motd_footer':
    message => $delimiter,
    order   => '10',
  }
}

