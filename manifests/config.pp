#Class for the main configuration file, aka squid.conf
class eb2_squid::config (


#This values are take from HOST's YAML files
$squid3_main_conf                            = hiera('squid3::main::conf'),
#END


#This value is from common.yaml files
$file_file                                   =hiera(file::file),
#END

#This values are from module YAML file, because they are general rules.
$icp_port                                    =hiera('squid3::icp_port'),
$snmp_port                                   =hiera('squid3::snmp_port'),
$cache_mgr                                   =hiera('squid3::cache_mgr'),
$cachemgr_passwd        =hiera('squid3::cachemgr_passwd'),
$forwarded_for        =hiera('squid3::forwarded_for'),
$half_closed_clients    =hiera('squid3::half_closed_clients'),
$balance_on_multiple_ip   =hiera('squid3::balance_on_multiple_ip'),
$cache_mem     =hiera('squid3::cache_mem'),
$persistent_connection_after_error    =hiera('squid3::persistent_connection_after_error'),
$maximum_object_size   =hiera('squid3::maximum_object_size'),
$extension_methods   =hiera('squid3::extension_methods'),
$ignore_expect_100     =hiera('squid3::ignore_expect_100'),
$max_filedescriptors    =hiera('squid3::max_filedescriptors'),
$request_header_max_size     =hiera('squid3::request_header_max_size'),
$reply_header_max_size       =hiera('squid3::reply_header_max_size'),
$forward_max_tries            =hiera('squid3::forward_max_tries'),
$cache_access_log         =hiera('squid3::cache_access_log'),
$cache_log                  =hiera('squid3::cache_log'),
$cache_store_log      =hiera('squid3::cache_store_log'),
$cache_dir        =hiera('squid3::cache_dir'),
$error_directory    =hiera('squid3::error_directory'),
$read_timeout    =hiera('squid3::read_timeout'),
$connect_timeout     =hiera('squid3::connect_timeout'),
$peer_connect_timeout    =hiera('squid3::peer_connect_timeout'),
$request_timeout      =hiera('squid3::request_timeout'),
$dns_timeout         =hiera('squid3::dns_timeout'),
$dead_peer_timeout     =hiera('squid3::dead_peer_timeout'),
$pconn_timeout       =hiera('squid3::pconn_timeout'),
$negative_ttl        =hiera('squid3::negative_ttl'),
$positive_dns_ttl       =hiera('squid3::positive_dns_ttl'),
$negative_dns_ttl        =hiera('squid3::negative_dns_ttl'),
$shutdown_lifetime     =hiera('squid3::shutdown_lifetime'),
$tcp_outgoing_address     =hiera('squid3::tcp_outgoing_address'),
$snmp_incoming_address    =hiera('squid3::snmp_incoming_address'),
$http_port   =hiera('squid3::http_port'),

#END

#Values from module YAML
$acl_dir    =hiera('squid3::acl_dir'),
$institute_dir      =hiera('squid3::institute_dir'),
$global_dir    =hiera('squid3::global_dir'),
$generic_acl_conf    =hiera('squid3::generic_acl_conf'),
$refresh_conf     =hiera('squid3::refresh_pattern'),
$server_ip       =hiera('squid3::localnet'),
#This value is for testing purposes
$my_network      =hiera('squid3::test::my_network'),





){

file { $squid3_main_conf:
  ensure  => $file_file,
  content => template('eb2_squid/main_conf.erb'),
  require => Class['eb2_squid::install'],
  notify => Class['eb2_squid::service'],
}


#Create ACL folder in /etc/squid/
file { $acl_dir:
        ensure => directory,
        #owner => 'root',
        #group => 'root',
        purge => true,
        recurse => true,
        #mode => 0755,
        require => Class["eb2_squid::install"],
    }

#END

#Create institutes folder in ACL folder
file { $institute_dir:
        ensure => directory,
        purge => true,
        recurse => true,
        require => Class["eb2_squid::install"],
    }
#END









file { $generic_acl_conf:
  ensure  => $file_file,
  content => template('eb2_squid/generic_acl.erb'),
  require => Class['eb2_squid::install'],
  notify => Class['eb2_squid::service'],
}

#END



#Global dir
file { $global_dir:
        ensure => directory,
        purge => true,
        recurse => true,
        source => ["puppet:///eb2_squid/"],
        require => Class["eb2_squid::install"],
    }






#file { $refresh_conf:
#  ensure  => $file_file,
#  content => template('eb2_squid/refresh.erb'),
#  require => Class['eb2_squid::install'],
#  notify => Class['eb2_squid::service'],
#}


#END


}

