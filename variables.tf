variable "project" {
  default = "terraformjlt"
}

# set to every day, at 18:00 hourds (6pm)
# https://crontab.guru/
variable "cron_pattern" {
  default = "*/5 * * * *"
}

variable "label_key" {
  default = "instance-scheduler"
}

variable "label_value" {
  default = "enabled"
}

variable "scheduler_function_bucket" {
  default = "terraformjlt_sch_bkt"
}