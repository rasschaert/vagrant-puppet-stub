#Vagrant 1.6 stub for use with puppet 3.6
Vagrant currently does not fully support the changes introduced in recent versions of Puppet. This repo hopes to provide a sane template for using the current best practices Puppet in Vagrant, such as:

- using [directory environments](https://docs.puppetlabs.com/puppet/3.5/reference/release_notes.html#directory-environments)
- using a [directory as a main manifest](https://docs.puppetlabs.com/puppet/latest/reference/dirs_manifest.html#with-puppet-apply), instead of a single file

It also adds an easy way to specify the desired Puppet environments to the Vagrant Puppet provisioner.

In order to use directories as main manifest (using a single file is now deprecated), a [small patch](https://github.com/mitchellh/vagrant/pull/4169/files) to Vagrant's `plugins/provisioners/puppet/config/puppet.rb` file is required. This patch has been accepted upstream and will probably be part of the release following 1.6.3.

##Puppet environments
The Vagrant Puppet provisioner does at this time not provide any mechanism to specify the desired Puppet environment and uses `production` every time.

The Vagrantfile provided here reads out the `VAGRANT_PUPPET_ENV` environment variable to figure out which Puppet environment to apply. If no such variable has been set, `development` is the default.

###Default environment (development)
```
vagrant-puppet git:master ❯❯❯ vagrant provision
==> web: Running provisioner: puppet...
==> web: Running Puppet with ...
==> web: Warning: Setting manifestdir is deprecated. See http://links.puppetlabs.com/env-settings-deprecations
==> web:    (at /usr/lib/ruby/site_ruby/1.8/puppet/settings.rb:1095:in `issue_deprecations')
==> web: Notice: Compiled catalog for web.vagrant.local in environment development in 0.05 seconds
==> web: Notice: hello from the web node in development
==> web: Notice: /Stage[main]/Main/Node[web]/Notify[hello from the web node in development]/message: defined 'message' as 'hello from the web node in development'
==> web: Notice: environment development active!
==> web: Notice: /Stage[main]/Mock/Notify[environment development active!]/message: defined 'message' as 'environment development active!'
==> web: Notice: this is development, so go crazy
==> web: Notice: /Stage[main]/Mock/Notify[this is development, so go crazy]/message: defined 'message' as 'this is development, so go crazy'
==> web: Notice: Finished catalog run in 0.03 seconds
/t/vagrant-puppet git:master ❯❯❯
```

###Production environment
```
vagrant-puppet git:master ❯❯❯ VAGRANT_PUPPET_ENV=production vagrant provision
==> web: Running provisioner: puppet...
==> web: Running Puppet with ...
==> web: Warning: Setting manifestdir is deprecated. See http://links.puppetlabs.com/env-settings-deprecations
==> web:    (at /usr/lib/ruby/site_ruby/1.8/puppet/settings.rb:1095:in `issue_deprecations')
==> web: Notice: Compiled catalog for web.vagrant.local in environment production in 0.05 seconds
==> web: Notice: hello from the web node in development
==> web: Notice: /Stage[main]/Main/Node[web]/Notify[hello from the web node in development]/message: defined 'message' as 'hello from the web node in development'
==> web: Notice: this is production, be careful!
==> web: Notice: /Stage[main]/Mock/Notify[this is production, be careful!]/message: defined 'message' as 'this is production, be careful!'
==> web: Notice: environment production active!
==> web: Notice: /Stage[main]/Mock/Notify[environment production active!]/message: defined 'message' as 'environment production active!'
==> web: Notice: Finished catalog run in 0.03 seconds
vagrant-puppet git:master ❯❯❯
```

##Structure
```
vagrant-puppet git:master ❯❯❯ tree                                                                                                                                                                                                       ✚
.
├── hiera
│   ├── common.yaml
│   └── environments
│       ├── development.yaml
│       └── production.yaml
├── puppet
│   ├── environments
│   │   ├── development
│   │   │   └── manifests
│   │   │       └── web.pp
│   │   └── production
│   │       └── manifests
│   │           └── web.pp
│   ├── hiera.yaml
│   └── modules
│       └── mock
│           └── manifests
│               └── init.pp
├── README.md
└── Vagrantfile

11 directories, 9 files
```

The directory layout is structured so that you may add a complete Puppet and Hiera git repository as a git submodules. The `puppet` and `hiera` directories provided are just an example of how both repos could be structured.

As a result of this philosophy, the Hiera configuration file, hiera.yaml, does not include a hardcoded datadir location. Pointing the datadir to `/vagrant/hiera` would make the hiera.yaml file useless outside Vagrant. Instead, an explicit folder sync is set up between `/vagrant/hiera` and the default datadir location, `/var/lib/hiera`.
