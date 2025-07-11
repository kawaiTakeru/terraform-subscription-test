terraform {
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 🔍 Billing Account の存在チェック（エラー時に失敗）
data "azapi_resource_list" "billing_accounts" {
  type                   = "Microsoft.Billing/billingAccounts@2020-05-01"
  parent_id              = "/"
  response_export_values = ["name"]
}

# 📝 エラーガード：Billing Account が見つからなければ明示的に失敗
resource "null_resource" "check_billing_permission" {
  count = length(data.azapi_resource_list.billing_accounts.output) > 0 ? 0 : 1

  provisioner "local-exec" {
    command = "echo '❌ Billing Account にアクセスできません。Billing Account Reader 権限が必要です。' && exit 1"
  }
}

# ✅ サブスクリプション作成（例）
resource "azapi_resource" "subscription" {
  type      = "Microsoft.Subscription/aliases@2021-10-01"
  name      = var.subscription_alias_name
  parent_id = "/"

  body = jsonencode({
    properties = {
      displayName   = var.subscription_display_name
      billingScope  = "/providers/Microsoft.Billing/billingAccounts/${var.billing_account_name}/billingProfiles/${var.billing_profile_name}/invoiceSections/${var.invoice_section_name}"
      workload      = var.subscription_workload
    }
  })

  timeouts {
    create = "30m"
    read   = "5m"
    delete = "30m"
  }

  depends_on = [null_resource.check_billing_permission]
}
