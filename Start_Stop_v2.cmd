@echo off

echo -----------------------------------------
echo Checking the Instances on AWS EC2 for

aws iam list-account-aliases --output table --color off

FOR /F "tokens=* USEBACKQ" %%F IN (`aws configure get region`) DO (
SET region=%%F
)
echo Your current region is: %region%

aws ec2 describe-instances --query "Reservations[*].Instances[*].{InstanceID:InstanceId,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" --output table --color off

echo -----------------------------------------
:askInstance
set /p id="Enter the InstanceID you want to manage: "

echo -----------------------------------------

:getConfirmation
set /p ActionInstance=Need to [start/stop/check/change] "%id%" Instance? 
if /I "%ActionInstance%"=="start" goto :StartInstance
if /I "%ActionInstance%"=="stop" goto :StopIstance
if /I "%ActionInstance%"=="check" goto :CheckIstance
if /I "%ActionInstance%"=="change" goto :GetIstance
REM added goto getConfirmation in case of invalid responses
goto getConfirmation

:StartInstance
aws ec2 start-instances --instance-ids %id%
echo The Instance "%id%" is starting ...
timeout 2 > nul
aws ec2 describe-instances --instance-id %id% --query "Reservations[*].Instances[*].{Instance:InstanceId,PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" --output table --color off
timeout 5
goto ExitProgram

:StopIstance
aws ec2 stop-instances --instance-ids %id%
echo The Instance "%id%" is stopping ...
timeout 2 > nul
aws ec2 describe-instances --instance-id %id% --query "Reservations[*].Instances[*].{Instance:InstanceId,PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" --output table --color off
timeout 5
goto ExitProgram

:CheckIstance
aws ec2 describe-instances --instance-id %id% --query "Reservations[*].Instances[*].{Instance:InstanceId,PublicIP:PublicIpAddress,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name}" --output table --color off
timeout 5
goto ExitProgram

:GetIstance
set /p ActionChangeInstance=Set instance "%id%" type to [t3.small/t3.medium/t3.large/t3.xlarge/t3.2xlarge]:

:ChangeInstance
aws ec2 modify-instance-attribute --instance-id %id% --instance-type "{\"Value\": \""%ActionChangeInstance%"\"}"
echo The Instance "%id%" type is changing to "%ActionChangeInstance%" ...
timeout 2 > nul
aws ec2 describe-instances --instance-id %id% --query "Reservations[*].Instances[*].{Instance:InstanceId,Type:InstanceType,Name:Tags[?Key=='Name']|[0].Value}" --output table --color off
timeout 5
goto ExitProgram

:ExitProgram
set /p ActionExit=Want to exit [y/n]? 
if /I "%ActionExit%"=="y" goto end
if /I "%ActionExit%"=="n" goto getConfirmation
REM added goto ActionExit in case of invalid responses
goto ActionExit
