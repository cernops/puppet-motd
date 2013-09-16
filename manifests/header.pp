# == Define: motd::news
#
# Adds and entry to the heading /etc/motd file which will
# persist for ever.
#
# === Parameters
# 
# [*message*]
#  If not defined the title of the instance will be used. The message
#  defines to appear allways in the /etc/motd file.
# 
# === Examples
#    motd::header{"Welcome to ${::fqdn}"}
define motd::header ($message = $title,$order = '05') {

  concat::fragment { "motd_frag_$name":
    target  => "/etc/motd",
    content => "* ${message}\n",
    order   => $order
  }
}

