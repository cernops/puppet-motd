##2016-01-15  2.0.0 release
- Restores v0 behaviour and /etc/issue.net and /etc/issue
  are not maintained unless new variable enable_issue 
  is set to true.
- A new parameter major to motd::news allows news items
  to displayed if the array value contains an entry
  of $::operatingsystemmajrelease.

##2015-05-21  1.0.0 release
- Now manages /etc/issue.net and /etc/issue also.
- Fix to work with puppetlabs-concat >= 2.0.0
- Add beaker acceptance testing.
- Allow news line width to be specified.

##2014-05-26  0.1.3 release
- Correct example in README.md

##2014-02-20  0.1.2 release
- Correct syntax for requirements in Modulefile.

##2013-12-17  0.1.1 release

