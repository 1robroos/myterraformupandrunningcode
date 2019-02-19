# using module for the webserver
S3 state files look like:
```
$ aws s3 ls kfsolutions-terraform-up-and-running-state/ --recursive
2019-02-19 11:48:20       4501 prod/data-stores/mysql/terraform.tfstate
2019-02-18 21:32:01       4496 stage/data-stores/mysql/terraform.tfstate
2019-02-19 09:39:31        318 stage/services/webserver-cluster/terraform.tfstate
```
The local tfstate files are zero in size:
```
[rob@rob-Latitude-5590 rearrange (⎈ |minikube:default)]$ find .  -name terraform.tfstate -ls| grep -v "\.terra" 
  4353987      0 -rw-r--r--   1 rob      rob             0 feb 17 09:25 ./stage/data-stores/mysql/terraform.tfstate
  4353957      0 -rw-r--r--   1 rob      rob             0 feb 18 21:53 ./modules/services/webserver-cluster/terraform.tfstate
  4354076      0 -rw-rw-r--   1 rob      rob             0 feb 19 11:37 ./prod/data-stores/mysql/terraform.tfstate
  4354084      0 -rw-r--r--   1 rob      rob             0 feb 19 13:35 ./prod/services/webserver-cluster/terraform.tfstate
```

The S3-paths to the remote state files are similar to the directory structure :

```
$ tree 
.
├── global
│   └── s3
│       ├── main.tf
│       └── outputs.tf
├── modules
│   └── services
│       └── webserver-cluster
│           ├── main.tf
│           ├── main.tf.asgelb
│           ├── outputs.tf
│           ├── terraform.tfstate
│           ├── terraform.tfstate.backup
│           ├── user-data.sh
│           ├── vars.tf
│           └── vars.tf.asgelb
├── prod
│   ├── data-stores
│   │   └── mysql
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       ├── terraform.tfstate
│   │       └── vars.tf
│   └── services
│       └── webserver-cluster
│           ├── main.tf
│           ├── terraform.tfstate
│           └── vars.tf
├── README.md
└── stage
    ├── data-stores
    │   └── mysql
    │       ├── main.tf
    │       ├── outputs.tf
    │       ├── terraform.tfstate
    │       └── vars.tf
    └── services
        └── webserver-cluster
            ├── main.tf
            └── vars.tf

15 directories, 24 files
```
