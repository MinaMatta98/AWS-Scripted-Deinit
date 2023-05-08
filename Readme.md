# Readme
The purpose of this repository is to allow for uninitializing AWS services relating to the BDR. This comes in the form of:

> Removing ECS container services

> Stopping and NOT **Removing** EC2 Instances

> Setting Auto Scaling group size to 0

To use the script, simply run the following from a POSIX compliant shell *after importing AWS credentials*:
```
./stop.sh
```

# Extended Readme
This script is a shell script that uses the AWS CLI (Command Line Interface) to perform several tasks related to Amazon Elastic Container Service (ECS) and Amazon Elastic Compute Cloud (EC2) instances.

The script is doing the following:

> Update the service in the ECS cluster to zero desired count, this will stop the running tasks associated with the service.

> Delete the service in the ECS cluster

> Update the auto-scaling group to have a minimum size of zero.

> Set the desired capacity of the auto-scaling group to zero.

> Get all the instances ids using the aws ec2 describe-instances command and store it in the Instances variable.

> For each instance id in the Instances variable, the script stops the instances using the aws ec2 stop-instances command.

It's worth noting that the script uses several command chaining and piping commands to parse the response of each command, like awk -F '/' '{print $NF}' and sed 's/[," ]//g' to filter the output and extract specific values.

It also uses the aws ecs list-clusters, aws ecs list-services, aws autoscaling describe-auto-scaling-groups and aws ec2 describe-instances commands to get the list of clusters, services, auto-scaling groups and instances respectively.
