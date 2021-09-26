data aws_vpc vpc {
  filter {
    name   = "tag:Name"
    values = ["vpc10"]
  }
}

data aws_subnet_ids private {
  vpc_id = data.aws_vpc.vpc.id
  filter {
    name   = "tag:Name"
    values = ["sn_vpc_10_*"]
  }
}

output vpcs {
    value = [
        data.aws_vpc.vpc.id,
        data.aws_subnet_ids.private
    ]
}

module "SG" {
  source             = "git@gitlab.com:engines-aws/engine-sg.git"
  name_prefix        = var.name_prefix
  env                = var.env
  app                = "Cloud-it"
  modalidade         = "Cloud-it"
  projeto            = "Cloud-it"
  cluster-name       = var.cluster-name
  vpc_id             = data.aws_vpc.vpc.id
  services_ports     = ["443"]
  protocol           = "tcp"
  list_ips = [data.aws_vpc.vpc.cidr_block,"0.0.0.0/0"]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.11"
}

module "eks" {
  source                               = "git@gitlab.com:engines-aws/engine-eks.git"
  cluster_name                         = "${var.cluster-name}-${var.env}"
  subnets                              = data.aws_subnet_ids.private.ids
  vpc_id                               = data.aws_vpc.vpc.id
  map_roles                            = var.map_roles
  manage_aws_auth                      = true
  #worker_additional_security_group_ids = [module.SG.sgoutput]
  cluster_enabled_log_types            = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cluster_version                      = var.versionCluster
  cluster_endpoint_private_access = false
  cluster_endpoint_public_access = true
  worker_groups = [
    {
      instance_type                 = "%{if var.env == "prod" || var.env == "stress-test"}${var.AWS_TYPE_INSTANCE}%{else}t3a.large%{endif}"
      asg_max_size                  = "%{if var.env == "prod" || var.env == "stress-test"}${var.DMAXEKS}%{else}2%{endif}"
      asg_desired_capacity          = "%{if var.env == "prod" || var.env == "stress-test"}${var.DMIN}%{else}2%{endif}"
      kubelet_extra_args            = "--node-labels=cloudit=microservices"
      key_name                      = var.keyName

    }
  ]
  tags = {
    Name                                                   = "${var.cluster-name}-${var.env}"
    Terraform                                              = true
    APP                                                    = "Cloudit"
    Projeto                                                = "Cloudit"
    Requerente                                             = var.requerente
    Ambiente                                               = var.env
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" = "shared"

  }
}

module "SCHEDULE-NODE-A" {
  source                      = "git@gitlab.com:engines-aws/engine-schedule-start-stop-aws.git"
  env                         = var.env
  scheduled_action_name_start = var.scheduled_action_name_start
  scheduled_action_name_stop  = var.scheduled_action_name_stop
  recurrence_start            = var.recurrence_start
  recurrence_stop             = var.recurrence_stop
  autoscaling_group_name      = module.eks.NAME-AUTOSCALING[0]
}
