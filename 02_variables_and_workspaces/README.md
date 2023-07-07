Still need to update README files for DAY 2 - sorry :)

Here we begin using the same code for both prod and dev envoronments.  We will walk through tw different approaches:
1. Store the state locally so this is a good way to introduce terraform workspaces.  
2. Remote backends stored in an S3 bucket in each account

## Using Workspaces

STEPS:
1.  navigate to the "seperate backends" directory 
2.  `terraform init`
2.  `terraform workspace list` (Note there is only a default workspace listed)
3.  `terraform workspace new prod` - this will create (and select) a workspace names "prod"
4.  `terraform workspace new dev` - this will create (and select) a workspace names "dev"
5.  `terraform workspace list` (note dev is selected since you created that one most recently)
6.  `terraform apply -var-file="dev.auto.tfvars` - This will use the values declared in the dev.tfvars file
7.  `terraform workspace select prod`
8.  `terraform apply -var-file="prod.auto.tfvars` - This will use the values declared in the prod.tfvars file

## Using Separate state files/locations

Note: We could also specify a remote state location and have a separate backend config for dev and prod like this

```
├── 02_variables_and_workspaces
│   ├── README.md
│   ├── backend.tf
│   ├── data.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── envs
│   │   ├── dev
│   │   │   ├── backend.tfvars - this would specify remote backend location
│   │   │   └── terraform.tfvars - this would be the same content as dev.tfvars (name doesnt really matter)
│   │   └── prod
│   │       ├── backend.tfvars - this would specify remote backend location
│   │       └── terraform.tfvars - this would be the same content as prod.tfvars (name doesnt really matter)
│   └── variables.tf
```


then when running the init:

`terraform init -backend-config="./envs/dev/backend.tfvars"`

and when running the plan/apply:

`terraform plan var-file="./envs/dev/terraform.tfvars`

