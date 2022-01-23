@echo off
echo -----------------------------------------
echo Checking the Instances on AWS EC2 for

aws iam list-account-aliases --output table --color off

echo -----------------------------------------

aws ec2 describe-instances --query "Reservations[*].Instances[*].{InstanceID:InstanceId,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" --output table --color off

echo -----------------------------------------

:askInstance
set /p id="Enter the InstanceID you want to manage: "

echo -----------------------------------------

:getConfirmation
set /p ActionInstance=Need to [check/start/stop/change] "%id%" Instance? 
if /I "%ActionInstance%"=="start" goto :StartInstance
if /I "%ActionInstance%"=="stop" goto :StopIstance
if /I "%ActionInstance%"=="check" goto :CheckIstance
if /I "%ActionInstance%"=="change" goto :GetIstance
REM added goto getConfirmation in case of invalid responses
goto getConfirmation

:StartInstance
aws ec2 start-instances --instance-ids %id%
timeout 2
aws ec2 describe-instances --instance-id %id% --query "Reservations[*].Instances[*].{Instance:InstanceId,PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" --output table --color off
timeout 5
goto ExitProgram

:StopIstance
aws ec2 stop-instances --instance-ids %id%
timeout 2
aws ec2 describe-instances --instance-id %id% --query "Reservations[*].Instances[*].{Instance:InstanceId,PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" --output table --color off
timeout 5
goto ExitProgram

:CheckIstance
aws ec2 describe-instances --instance-id %id% --query "Reservations[*].Instances[*].{Instance:InstanceId,PublicIP:PublicIpAddress,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" --output table --color off
timeout 5
goto ExitProgram

:GetIstance
set /p ActionChangeInstance=Set instance "%id%" type to [t3.small/t3.medium/t3.large/t3.xlarge/t3.2xlarge]:
if /I "%ActionChangeInstance%"=="t3.small" goto :t3small
if /I "%ActionChangeInstance%"=="t3.medium" goto :t3medium
if /I "%ActionChangeInstance%"=="t3.large" goto :t3large
if /I "%ActionChangeInstance%"=="t3.xlarge" goto :t3xlarge
if /I "%ActionChangeInstance%"=="t3.2xlarge" goto :t32xlarge
REM added goto getConfirmation in case of invalid responses
goto getConfirmation

:t3small
aws ec2 modify-instance-attribute --instance-id %id% --instance-type "{\"Value\": \"t3.small\"}"
timeout 2
aws ec2 describe-instances --instance-id %id% --query "Reservations[*].Instances[*].{Instance:InstanceId,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value}" --output table --color off
timeout 5
goto ExitProgram

:t3medium
aws ec2 modify-instance-attribute --instance-id %id% --instance-type "{\"Value\": \"t3.medium\"}"
timeout 2
aws ec2 describe-instances --instance-id %id% --query "Reservations[*].Instances[*].{Instance:InstanceId,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value}" --output table --color off
timeout 5
goto ExitProgram

:t3large
aws ec2 modify-instance-attribute --instance-id %id% --instance-type "{\"Value\": \"t3.large\"}"
timeout 2
aws ec2 describe-instances --instance-id %id% --query "Reservations[*].Instances[*].{Instance:InstanceId,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value}" --output table --color off
timeout 5
goto ExitProgram

:t3xlarge
aws ec2 modify-instance-attribute --instance-id %id% --instance-type "{\"Value\": \"t3.xlarge\"}"
timeout 2
aws ec2 describe-instances --instance-id %id% --query "Reservations[*].Instances[*].{Instance:InstanceId,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value}" --output table --color off
timeout 5
goto ExitProgram

:t32xlarge
aws ec2 modify-instance-attribute --instance-id %id% --instance-type "{\"Value\": \"t3.2xlarge\"}"
timeout 2
aws ec2 describe-instances --instance-id %id% --query "Reservations[*].Instances[*].{Instance:InstanceId,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value}" --output table --color off
timeout 5
goto ExitProgram

:ExitProgram
set /p ActionExit=Want to exit [y/n]? 
if /I "%ActionExit%"=="y" goto end
if /I "%ActionExit%"=="n" goto getConfirmation
REM added goto ActionExit in case of invalid responses
goto ActionExit
