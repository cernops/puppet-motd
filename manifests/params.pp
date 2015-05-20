# Classs: motd::params
class motd::params {

  # Specify an array of entries to appear at the top the /etc/motd file allways.
  $default_header = [
    "Welcome to ${::fqdn}, ${::operatingsystem}, ${::operatingsystemrelease}",
    'Archive of news is available in /etc/motd-archive'
  ]

  $motd_header    = hiera('motd_header',$default_header)

  # The delimeter between the sections of the /etc/motd file can be specified.
  $default_delimiter = '********************************************************************'
  $delimiter      = hiera('motd_delimiter',$default_delimiter)

  # Default values for /etc/issue and /etc/issue.net
  $default_issue_content  = [
    "${::operatingsystem} release ${::operatingsystemrelease}",
    'Kernel \r on an \m',
  ]

  $issue_content = hiera('motd_issue_content', $default_issue_content)
}
