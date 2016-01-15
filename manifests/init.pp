# Class: motd
class motd (
  $motd_header          = $::motd::params::motd_header,
  $delimiter            = $::motd::params::delimiter,
  $enable_issue         = false,
  $issue_content        = $::motd::params::issue_content,
  $issue_line_length    = 80,
  $center_issue_content = false,
  $news_line_length     = 62,
) inherits motd::params {

  validate_bool($enable_issue)
  validate_bool($center_issue_content)

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

  if $enable_issue {
    file { '/etc/issue':
      ensure  => 'file',
      content => template('motd/issue.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
    file { '/etc/issue.net':
      ensure  => 'file',
      content => template('motd/issue.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  }
}

