profile               = "YOUR_AWS_PROFILE_HERE"
prod_profile          = "YOUR_AWS_PROFILE_HERE" #If deploying that DNS to the other account
hosted_zone           = "YOUR_HOSTED_ZONE_HERE"
alternate_hosted_zone = "YOUR_HOSTED_ZONE_HERE" #If deploying that DNS to the other account
environment           = "dev"
project               = "Dev Terraform Demo"
datadog_api_key       = "YOUR_DD_API_KEY" #ONLY NEEDED IF YOU EITHER SET THE VALUE FOR "enable_monitoring" to "true" in variables.tfvars OR if you add a line in this file for "enable_monitoring = true"
datadog_app_key       = "YOUR_DD_APP_KEY" #ONLY NEEDED IF YOU EITHER SET THE VALUE FOR "enable_monitoring" to "true" in variables.tfvars OR if you add a line in this file for "enable_monitoring = true