#!/usr/bin/sh

aws ecs update-service --cluster="$(aws ecs list-clusters --output=text | awk -F '/' '{print $NF}')" --service="$(aws ecs list-services --cluster="$(aws ecs list-clusters --output=text | awk -F '/' '{print $NF}')" --output=text | awk -F '/' '{print $NF}')" --desired-count=0

aws ecs delete-service --cluster="$(aws ecs list-clusters --output=text | awk -F '/' '{print $NF}')" --service="$(aws ecs list-services --cluster="$(aws ecs list-clusters --output=text | awk -F '/' '{print $NF}')" --output=text | awk -F '/' '{print $NF}')"

aws autoscaling update-auto-scaling-group --auto-scaling-group-name="$(aws autoscaling describe-auto-scaling-groups | grep GroupName | grep -v arn | awk -F ":" '{print $NF}' | sed 's/[," ]//g')" --min-size=0

aws autoscaling set-desired-capacity --auto-scaling-group-name="$(aws autoscaling describe-auto-scaling-groups | grep GroupName | grep -v arn | awk -F ":" '{print $NF}' | sed 's/[," ]//g')" --desired-capacity=0

Instances=$(aws ec2 describe-instances | grep InstanceId | awk -F ":" '{print $2}' | sed 's/[",[:space:][:blank:]]//g')

for Instance in "${Instances[@]}"
do
    aws ec2 stop-instances --instance-ids="$Instance"
done
