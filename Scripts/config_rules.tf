provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

resource "aws_config_aggregate_authorization" "config_auth" {
  account_id = "ACCOUNT-ID"
  region     = "us-east-1"
}

resource "aws_config_configuration_aggregator" "acc_aggregate" {
  name = "awsconfig_aggregator"

  account_aggregation_source {
    account_ids = ["ACCOUNT-ID"]
    regions     = ["us-east-1"]
  }
}

resource "aws_config_config_rule" "rule16" {
  name = "mfa_enabled_for_iam_console_access"
  description = "Checks whether AWS Multi-Factor Authentication (MFA) is enabled for all AWS Identity and Access Management (IAM) users that use a console password. The rule is COMPLIANT if MFA is enabled."

  source {
    owner             = "AWS"
    source_identifier = "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule15" {
  name = "iam_user_mfa_enabled"
  description = "Checks whether the AWS Identity and Access Management users have multi-factor authentication (MFA) enabled."

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_MFA_ENABLED"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule14" {
  name = "iam_root_access_key_check"
  description = "Checks whether the root user access key is available. The rule is COMPLIANT if the user access key does not exist."

  source {
    owner             = "AWS"
    source_identifier = "IAM_ROOT_ACCESS_KEY_CHECK"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule13" {
  name = "iam_policy_no_statements_with_admin_access"
  description = "Checks the IAM policies that you create, such as identity-based or resource-based policies, for Allow statements that grant permissions to all actions on all resources."

  source {
    owner             = "AWS"
    source_identifier = "IAM_POLICY_NO_STATEMENTS_WITH_ADMIN_ACCESS"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule12" {
  name = "iam_password_policy"
  description = "Checks whether the account password policy for IAM users meets the specified requirements."

  source {
    owner             = "AWS"
    source_identifier = "IAM_PASSWORD_POLICY"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule11" {
  name = "iam_group_has_users_check"
  description = "Checks whether IAM groups have at least one IAM user."

  source {
    owner             = "AWS"
    source_identifier = "IAM_GROUP_HAS_USERS_CHECK"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule10" {
  name = "cmk_backing_key_rotation_enabled"
  description = "Checks that key rotation is enabled for each customer master key (CMK). The rule is COMPLIANT, if the key rotation is enabled for specific key object. The rule is not applicable to CMKs that have imported key material."

  source {
    owner             = "AWS"
    source_identifier = "CMK_BACKING_KEY_ROTATION_ENABLED"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule9" {
  name = "vpc_default_security_group_closed"
  description = "Checks that the default security group of any Amazon Virtual Private Cloud (VPC) does not allow inbound or outbound traffic."

  source {
    owner             = "AWS"
    source_identifier = "VPC_DEFAULT_SECURITY_GROUP_CLOSED"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule8" {
  name = "internet_gateway_authorized_vpc_only"
  description = "Checks that Internet gateways (IGWs) are only attached to an authorized Amazon Virtual Private Cloud (VPCs). The rule is NON_COMPLIANT if IGWs are not attached to an authorized VPC."

  source {
    owner             = "AWS"
    source_identifier = "INTERNET_GATEWAY_AUTHORIZED_VPC_ONLY"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule7" {
  name = "cloud_trail_enabled"
  description = "Checks whether AWS CloudTrail is enabled in your AWS account. Optionally, you can specify which S3 bucket, SNS topic, and Amazon CloudWatch Logs ARN to use."

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule6" {
  name = "kms_cmk_not_scheduled_for_deletion"
  description = "Checks whether customer master keys (CMKs) are not scheduled for deletion in AWS Key Management Service (KMS). The rule is NON_COMPLIANT if CMKs are scheduled for deletion."

  source {
    owner             = "AWS"
    source_identifier = "KMS_CMK_NOT_SCHEDULED_FOR_DELETION"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule5" {
  name = "eip_attached"
  description = "Checks whether all Elastic IP addresses that are allocated to a VPC are attached to EC2 instances or in-use elastic network interfaces (ENIs)."

  source {
    owner             = "AWS"
    source_identifier = "EIP_ATTACHED"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule4" {
  name = "ec2_volume_inuse_check"
  description = "Checks whether EBS volumes are attached to EC2 instances. Optionally checks if EBS volumes are marked for deletion when an instance is terminated."

  source {
    owner             = "AWS"
    source_identifier = "EC2_VOLUME_INUSE_CHECK"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule3" {
  name = "ec2_instance_no_public_ip"
  description = "Checks whether Amazon Elastic Compute Cloud (Amazon EC2) instances have a public IP association. The rule is NON_COMPLIANT if the publicIp field is present in the Amazon EC2 instance configuration item. This rule applies only to IPv4."

  source {
    owner             = "AWS"
    source_identifier = "EC2_INSTANCE_NO_PUBLIC_IP"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule2" {
  name = "lambda_inside_vpc"
  description = "Checks whether an AWS Lambda function is in an Amazon Virtual Private Cloud. The rule is NON_COMPLIANT if the Lambda function is not in a VPC."

  source {
    owner             = "AWS"
    source_identifier = "LAMBDA_INSIDE_VPC"
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_config_rule" "rule1" {
  name = "vpc-sg-open-only-to-authorized-ports"
  description = "A Config rule that checks whether the security group with 0.0.0.0/0 of any Amazon Virtual Private Cloud (Amazon VPCs) allows only specific inbound TCP or UDP traffic. The rule and any security group with inbound 0.0.0.0/0. is NON_COMPLIANT, if you do n..."

  source {
    owner             = "AWS"
    source_identifier = "VPC_SG_OPEN_ONLY_TO_AUTHORIZED_PORTS"
  }
  
   scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }

  depends_on = [aws_config_configuration_recorder.config_recorder]
}

resource "aws_config_configuration_recorder_status" "config_recorder_status" {
  name       = "${aws_config_configuration_recorder.config_recorder.name}"
  is_enabled = true
  depends_on = ["aws_config_delivery_channel.config_delivery_channel"]
}

resource "aws_s3_bucket" "aws_config_bucket" {
  bucket = "ACCOUNT-ID-awsconfig-bucket"
}

resource "aws_config_delivery_channel" "config_delivery_channel" {
  name           = "awsconfig_delivery_channel"
  s3_bucket_name = "${aws_s3_bucket.aws_config_bucket.bucket}"
}

resource "aws_config_configuration_recorder" "config_recorder" {
  name     = "aws_config_recorder"
  role_arn = "${aws_iam_role.config_role.arn}"
}

resource "aws_iam_role_policy_attachment" "iam_attachment" {
  role       = "${aws_iam_role.config_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

resource "aws_iam_role" "config_role" {
  name = "custom-awsconfig-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "config_bucket_policy" {
  name = "config-bucket-policy"
  role = "${aws_iam_role.config_role.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.aws_config_bucket.arn}",
        "${aws_s3_bucket.aws_config_bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "config_policy" {
  name = "custom-awsconfig-policy"
  role = "${aws_iam_role.config_role.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Action": "config:Put*",
        "Effect": "Allow",
        "Resource": "*"

    }
  ]
}
POLICY
}