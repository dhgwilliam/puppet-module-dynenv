dynenv - to manage dynamic puppet environments with git
---

ideated and documented in a 
[Puppet Labs blog post](http://puppetlabs.com/blog/git-workflow-and-puppet-environments/)
and using a fork of the [puppet-sync](https://github.com/pdxcat/puppet-sync) script
from PSU's Computer Action Team (with a minor modification that requires
a pull request before I can switch it back to upstream, someone remind me to do this)

*NB: there are other people out there hacking on Dynamic Environments,
so when their blogs are back up we should add a link to the relevant
post*

Sample Usage
---

        class { 'usa-perf-dynenv':
          # this user need not exist on the destination boxes
          dynenv::user { 'dhgwilliam':
            key_type => 'ssh-rsa',
            key => 'AAAA(.*)=',
          }
          
          class { 'dynenv':
            sync_user => 'puppet-sync',
            puppetmaster_fqdn => 'puppet.perf.usacompany.com',
            githost_fqdn => 'usa-pup-git-01.perf.usacompany.com',
            git_repo => '/var/lib/git/modules',
            env_dir => '/etc/puppetlabs/puppet/environments',
          }
        }
        
        node 'usa-pup-git-01' {
          include usa-perf-dynenv
        }
        
        node 'puppet.perf' {
          include usa-perf-dynenv
        }
        

Caveats/Warnings/Issues
---

this module assumes that githost and puppetmaster are on separate boxes.
That said, I suspect it would work just fine if puppetmaster_fqdn and
githost_fqdn were the same, although I have not tested this.

the module explicitly does not manage the modules repo for you, so when
creating a new git_host, you must either copy an existing repo or create
a bare one with `git init .`

You must manually alter the puppetmaster's puppet.conf to actually enable the
dynamic environments, this only lays out the filesystem foundation.

git is currently only installed on RedHat boxes, and this requires
installing EPEL. other OSes could very easily be added.

I'd imagine there are some other assumptions contained herein that are
undocumented.
