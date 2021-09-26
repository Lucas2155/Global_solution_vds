
variable "AWS_REGION" {
  type = string
}

variable "requerente" {
  type = string
}

variable "env" {
  type = string
}

#####################################EKS############################

variable "RANGE_SG_IPS" {
  type = list(string)
}

variable "name_prefix" {
  type = string
}

variable "cluster-name" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "keyName" {
  type        = string
  description = "Nome da chave de conta"
}

variable "versionCluster" {
  type = string
}

variable "services_ports" {
  type = list(string)
}

variable "map_roles" {
  description = "AdditionalIAMrolestoaddtotheaws-authconfigmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
}


variable "AWS_TYPE_INSTANCE" {
  type        = string
  description = "tipo da instancia"
}

variable "DEKS" {
  type = string
}

variable "DMAXEKS" {
  type = string
}

variable "DMIN" {
  type = string
}

######################schedule################

variable "scheduled_action_name_start" {
  type = string
}

variable "scheduled_action_name_stop" {
  type = string
}

variable "recurrence_start" {
  type        = string
  description = "Hora para ligar maquinas"
}

variable "recurrence_stop" {
  type        = string
  description = "Hora para deligar maquinas"
}