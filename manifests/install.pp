#Package installation class
class eb2_squid::install (

#This value is from OS YAML file because it's a OS specific package name
$squid3_package    = hiera('squid3_package'),
#END

#This values are take from HOST's YAML files.
#Because we need to specify if we need squid or not
$squid3_enable = hiera('squid3::enable'),
#END


)

{

#Install squid 3 package.
package { $squid3_package:
ensure   =>  $squid3_enable,
}

}

