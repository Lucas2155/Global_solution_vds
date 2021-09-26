module "vpca"{
    source = "../../engine/vpc/" 
        AWS_REGION = "us-east-1"
        CIDRVPC = "10.0.0.0/16"
        map_public_true = "true" 
        cloudit_DMZ_A = "us-east-1a"
        CIDR_cloudit_DMZ_A = "10.0.1.0/24" 
        cloudit_APP_C = "us-east-1c"
        CIDR_cloudit_APP_C = "10.0.2.0/24" 
        instance_tenancy = "default"
        enable_dns_support = "true"
        enable_dns_hostnames = "true"
        enable_classiclink = "false"
        name_vpc = "vpc10"
        ENV = "sandbox"
        cluster-name = "cloudit"
        nuvpc= "10"
}

module "vpcb"{
    source = "../../engine/vpc/" 
        AWS_REGION = "us-east-1"
        CIDRVPC = "20.0.0.0/16"
        map_public_true = "true" 
        cloudit_DMZ_A = "us-east-1a"
        CIDR_cloudit_DMZ_A = "20.0.1.0/24" 
        cloudit_APP_C = "us-east-1c"
        CIDR_cloudit_APP_C = "20.0.2.0/24" 
        instance_tenancy = "default"
        enable_dns_support = "true"
        enable_dns_hostnames = "true"
        enable_classiclink = "false"
        name_vpc = "vpc20"
        ENV = "sandbox"
        cluster-name = "cloudit"
        nuvpc= "20"

}


