class eb2_squid::config (


#This values are take from HOST's YAML files
$squid3_main_conf = hiera('squid3::main::conf'),
#END


#This value is from common.yaml files
$file_file    =hiera(file::file),
#END





){

file { $squid3_main_conf:
  ensure  => $file_file,
  content => template('eb2_squid/main_conf.erb'),
  require => Class['eb2_squid::install'],
  #notify => Service["$service_name"],
}


}

