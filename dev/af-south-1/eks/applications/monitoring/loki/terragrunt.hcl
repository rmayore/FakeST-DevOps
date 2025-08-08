include {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tf-modules/helm/grafana///"
}

inputs = {
  cluster_name           = dependency.cluster.outputs.cluster_name
  cluster_endpoint       = dependency.cluster.outputs.cluster_endpoint
  cluster_ca_certificate = dependency.cluster.outputs.cluster_ca_certificate
  chart_name             = "loki"
  chart_version          = "3.3.0"
  k8s_namespace          = dependency.namespace.outputs.namespace
  values                 = {

                              "deploymentMode"                                  = "SimpleScalable"

                              "backend.replicas"                                = "3"
                              "read.replicas"                                   = "3"
                              "write.replicas"                                  = "3"


                              "minio.enable"                                     = "false"

                              "loki.schemaConfig.configs[0].from"                = "2025-01-01"
                              "loki.schemaConfig.configs[0].store"               = "fake-st-logs"
                              "loki.schemaConfig.configs[0].object_store"        = "s3"
                              "loki.schemaConfig.configs[0].schema"              = "v13"
                              "loki.schemaConfig.configs[0].index.prefix"        = "loki_index_"
                              "loki.schemaConfig.configs[0].index.period"        = "24h"

                              "loki.storage_config.aws.region"                   = var.aws_region
                              "loki.storage_config.aws.bucketnames"              = dependency.loki_s3_bucket.outputs.bucket_name
                              "loki.storage_config.aws.s3forcepathstyle"         = "false"

                              "loki.pattern_ingester.enabled"                    = "true"

                              "loki.limits_config.allow_structured_metadata"     = "true"
                              "loki.limits_config.volume_enabled"                = "true"
                              "loki.limits_config.retention_period"              = "672h"

                              "loki.querier.max_concurrent"                      = "4"

                              "loki.storage.type"                                = "s3"
                              "loki.storage.bucketNames.chunks"                  = dependency.loki_s3_bucket.outputs.bucket_name
                              "loki.storage.bucketNames.ruler"                   = dependency.loki_s3_bucket.outputs.bucket_name
                              "loki.storage.bucketNames.admin"                   = dependency.loki_s3_bucket.outputs.bucket_name


                              "loki.serviceAccount.create"                        = "false"
                              "loki.serviceAccount.name"                          = dependency.loki_s3_service_account.outputs.service_account_name
                           }
}

dependency "cluster" {
  config_path = "../../../cluster"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    cluster_name = "fake-cluster-name"
    cluster_endpoint = "fake-cluster-endpoint"
    cluster_ca_certificate = "fake-base64-ca-certificate"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}


dependency "namespace" {
  config_path = "../namespace"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    namespace = "monitoring"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}



dependency "loki_s3_bucket" {
  config_path = "../../../../s3/loki"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    bucket_id = "fake-bucket-id"
    bucket_name = "fake-bucket-name"
    bucket_arn = "fake-bucket-arn"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}




dependency "loki_s3_service_account" {
  config_path = "../../../service_accounts/loki_s3"
  mock_outputs_allowed_terraform_commands = ["validate,plan"]
  mock_outputs = {
    service_account_name = "fake-loki-sa"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}
