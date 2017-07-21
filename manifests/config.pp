class gexec::config {

    # Do the config after the installation process
    require gexec::install

    file {'/root/gang_exec':
        ensure => directory,
        mode => '0755',
        owner => 'root',
        group => 'root',
    }

    file {'/root/gang_exec/gang_run.sh':
        ensure => present,
        mode => '0700',
        owner => 'root',
        group => 'root',
        source => 'puppet:///grid_files/gexec/gang_run.sh',
        require => File['/root/gang_exec'],
    }

    file {'/etc/auth_pub.pem':
        ensure => present,
        source => 'puppet:///grid_files/gexec/auth_pub.pem',
    }

    file_line {'gexec service xinetd.d':
        ensure => present,
        path => '/etc/services',
        line => 'gexec        2875/tcp',
        notify => Service['xinetd'],
    }

}
