#Service class
class eb2_squid::service (

#THis value is telling us if the service should be enabled on the system
$service_ensure = hiera('squid3::service::active'),
#END

#THis value is telling us if the service should be running or NOT
$service_status = hiera('squid3::service::status'),
#END

#This is the service name which is different from OS to OS
$service_name   = hiera('squid3::service'),
#END

){



service { $service_name:
    ensure    => $service_ensure,
    enable    => $service_status,
    name      => $service_name,
    hasstatus => true,
    require   => Class['eb2_squid::install'],
  }




}
