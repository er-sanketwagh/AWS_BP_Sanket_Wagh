provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

resource "aws_organizations_account" "child_account" {
  name  	 = "${MEMBER_ACCOUNT_NAME}"
  email		 = "${MEMBER_ACC_EMAIL_ID}"
  parent_id	 = "${OU_ID}"
}

resource "aws_organizations_policy_attachment" "scp_attachment" {
  policy_id = "${aws_organizations_policy.child_scp.id}"
  target_id = "${aws_organizations_account.child_account.id}"
  
  depends_on = [aws_organizations_account.child_account]
}

resource "aws_organizations_policy" "child_scp" {
  name = "member_account_scp"

  content = <<CONTENT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Deny",
            "Action": [
                "ec2:*"
            ],
            "Resource": "*",
            "Condition": {
                "StringNotEquals": {
                    "aws:RequestedRegion": [
                        "us-east-1"
                    ]
                }
            }
        }
    ]
}
CONTENT
}