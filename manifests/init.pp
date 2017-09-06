class gexec {

    include gexec::install
    include gexec::config
    include gexec::service

    Class['gexec::install'] ->
    Class['gexec::config'] ->
    Class['gexec::service']

}
