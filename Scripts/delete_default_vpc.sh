#!/bin/bash

{
#Install pip and awscli
# curl -O https://bootstrap.pypa.io/get-pip.py
# python get-pip.py
# pip install awscli --upgrade

#AWS configure default region
aws configure set default.region us-east-1
#Describe all the regions inside a regions.txt file in the current working directory
#aws ec2 describe-regions --all-regions --query "Regions[].{Name:RegionName}" --output text > regions.txt

#Describe all the vpc's inside a vpcs.txt file in the current working directory
file1="$PWD/regions.txt"
while IFS= read -r region
do
	 aws ec2 describe-vpcs --region $region --query "Vpcs[].{Name:VpcId}" --output text >> vpcs.txt 
done <$file1

#Describe all the subnets inside a subnets.txt file in the current working directory
file2="$PWD/regions.txt"
while IFS= read -r region
do
	 aws ec2 describe-subnets --region $region --query "Subnets[].{Name:SubnetId}" --output text >> subnets.txt 
done <$file2

#Describe all the igw's inside a igws.txt file in the current working directory
file3="$PWD/regions.txt"
while IFS= read -r region
do
	aws ec2 describe-internet-gateways --region $region --query "InternetGateways[].{Name:InternetGatewayId}" --output text >> igws.txt
done <$file3

#Describe all the dhcp-options inside a dhcp-options.txt file in the current working directory
file4="$PWD/regions.txt"
while IFS= read -r region
do
	aws ec2 describe-dhcp-options --region $region --query "DhcpOptions[].{Name:DhcpOptionsId}" --output text >> dhcp_options.txt
done <$file4

#Delete all the subnets by iterating through the regions
file5="$PWD/regions.txt"
while IFS= read -r region
do
	file6="$PWD/subnets.txt"
	while IFS= read -r subnet
	do
		aws ec2 delete-subnet --subnet-id $subnet --region $region 
	done <$file6
done <$file5

#Detach all the igw's from each region
file7="$PWD/regions.txt"
while IFS= read -r region
do
	file8="$PWD/vpcs.txt"
	while IFS= read -r vpc
	do
		file9="$PWD/igws.txt"
		while IFS= read -r igw
		do
			aws ec2 detach-internet-gateway --internet-gateway-id $igw --vpc-id $vpc --region $region 
		done <$file9
	done <$file8
done <$file7

#Delete all the igw's from each region
file10="$PWD/regions.txt"
while IFS= read -r region
do
	file11="$PWD/igws.txt"
	while IFS= read -r igw
	do
		aws ec2 delete-internet-gateway --internet-gateway-id $igw --region $region 
	done <$file11
done <$file10

#Delete all the vpc's by iterating through the regions
file12="$PWD/regions.txt"
while IFS= read -r region
do
	file13="$PWD/vpcs.txt"
	while IFS= read -r vpc
	do
		aws ec2 delete-vpc --vpc-id $vpc --region $region 
	done <$file13
done <$file12

#Delete all the dhcp-options by iterating through the regions
file14="$PWD/regions.txt"
while IFS= read -r region
do
	file15="$PWD/dhcp_options.txt"
	while IFS= read -r dhcpoptions
	do
		aws ec2 delete-dhcp-options --dhcp-options-id $dhcpoptions --region $region 
	done <$file15
done <$file14

rm -rf regions.txt subnets.txt vpcs.txt igws.txt dhcp_options.txt
} > &>/dev/null &
 	