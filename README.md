## CERNOps-motd puppet module

This is the motd module. It can be used to maintain a complex and dynamic /etc/motd file
e.g.

<pre>
   **********************************************************
   * Welcome to host.example.org running CentOS 5.3
   * blahs blah
   * 2013-12-11 - Package X was installed.
   *  Package X is really good at solving the universe's
   *  problems.
   * 2013-12-25 - It is christmas day.
   **********************************************************
</pre>

Old news is automatically rotated after 30 days and stored in 
files in an /etc/motd-archive.

### Example Usage

```puppet
# Initialize motd module.
include 'motd'

# Specify some headers to allways show.
motd::header {'welcome': entry => "Welcome to box ${::fqdn}"}
motd::header {'message' entry => "Please behave"}
   
# Specify a time stamped short notice for motd.
motd::news {'It is christmas': date => '2013-12-25'}
   
# Specify a time stamped long notice for motd.
motd::news {'package X': 
  date    => '2013-12-11',
  message => 'Package X is really good at solving the universe\'s problems.',
  require => Package['X']
}
```
In addition a default header can also be specified via hiera, see params.pp for details.


### License
Apache II License

### Contact
Steve Traylen - steve.traylen@cern.ch

### Support

Please log tickets and issues at our site https://github.com/cernops/puppet-motd


