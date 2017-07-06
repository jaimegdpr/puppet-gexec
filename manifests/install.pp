class gexec::install {

    require ciemat_utils

    if $::osfamily == 'RedHat' and $::operatingsystemmajrelease == '7' {

        package { ['xinetd',
                   'glibc.i686',
                   'nss-softokn-freebl.i686']:
            ensure => installed,
            provider => yum,
            install_options => ['--enablerepo=Cent*'],
            before => Package[ ['openssl096b'], ['daemonize'] ],
        }

    }

    $gexec_dependencies = ['openssl096b-0.9.6b-22.46.i386.rpm',
                           'daemonize-1.7.3-1.el6.x86_64.rpm',
                           'gexec-0.3.4-1.noarch.rpm']

    $gexec_dependencies.each | String $gexec_dependency | {

        $package_name = regsubst($gexec_dependency,'^(\w+).*.rpm$', '\1')

        file {"/root/packages/${gexec_dependency}":
            ensure => present,
            source => "puppet:///grid_files/packages/${gexec_dependency}",
            before => Package["${package_name}"],
        }

        package {"${package_name}":
            ensure => present,
            provider => rpm, 
            source => "/root/packages/${gexec_dependency}",
        }
    }

}
