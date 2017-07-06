class gexec::service {
    
    service { 'xinetd':
        ensure => running,
        enable => true,
    }
}
