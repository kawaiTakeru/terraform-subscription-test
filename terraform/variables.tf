
variable "subscription_alias_name" {
  description = "内部で使われるサブスクリプションエイリアス名"
  type        = string
}

variable "subscription_display_name" {
  description = "ポータルなどで表示される名前"
  type        = string
}

variable "billing_account_name" {
  description = "課金アカウント名"
  type        = string
}

variable "billing_profile_name" {
  description = "課金プロファイル名"
  type        = string
}

variable "invoice_section_name" {
  description = "請求セクション名"
  type        = string
}

variable "subscription_workload" {
  description = "ワークロード種別"
  type        = string
  default     = "Production"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region"
  type        = string
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the Subnet"
  type        = string
}
