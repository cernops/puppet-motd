# Class: motd
# This class distributes a ``/etc/motd`` to show users all 
# the news related with a  certain node in Puppet. 
# 
# It also maintains an archive on mail in /etc/motd-archive
# It inherits configuration from params.pp
class motd (
   $motd_header = $::motd::params::motd_header,
   $delimiter   = $::motd::params::delimiter
) inherits motd::params {
  $motd_archive = "/etc/motd-archive"
  $motd = "/etc/motd"

  file { $motd_archive:
    owner  => "root",
    group  => "root",
    mode   => '0755',
    ensure => directory,
  }

  # Specify /etc/motd file.
  concat { $motd: mode => '0444' }

  motd::header{'header':
     message => $delimiter,
     order    => '00'
  }
  concat::fragment { "motd_header":
    target  => $motd,
    content => template("motd/motd.erb"),
    order   => '03',
  }
  motd::header{ "motd_footer":
    message => $delimiter,
    order   => '10',
  }
}

