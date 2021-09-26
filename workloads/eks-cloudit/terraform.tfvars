AWS_REGION = "us-east-1"
requerente = "cloudit"
env        = "sandbox"
########################SG#######################
services_ports = ["22", "80", "3389", "443", "8080"]
####################################EKS############################
RANGE_SG_IPS      = ["12.57.128.0/19", "12.57.160.0/19", "12.57.192.0/19", "12.57.224.0/19", "10.7.40.0/24", "10.7.60.0/24", "10.7.90.0/24", "10.7.30.0/24"]
name_prefix       = "eks-cloudit-"
cluster-name      = "cloudit"
s3_bucket_name    = "cloudit-fiap-iac"
keyName           = "eks-lab-cloudit"
versionCluster    = "1.19"
AWS_TYPE_INSTANCE = "t2.large"
DEKS              = "4"
DMAXEKS           = "8"
DMIN              = "4"
#####################schedule################
scheduled_action_name_start = "start"
scheduled_action_name_stop  = "stop"
recurrence_start            = "0 06 * * *"
recurrence_stop             = "0 00 * * *"
map_roles = [
  {
    rolearn  = "arn:aws:iam::786623674405:role/eks-admin-assume-role"
    username = "eks-admin-assume-role"
    groups   = ["system:masters"]
  },
  {
    rolearn  = "arn:aws:iam::786623674405:role/eks-admin-group"
    username = "eks-admin-group"
    groups   = ["system:masters"]
  },
]