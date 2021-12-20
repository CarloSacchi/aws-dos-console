@echo off
echo -----------------------------------------
echo Checking the Instances on AWS EC2 for

aws iam list-account-aliases --output table --color off

echo -----------------------------------------

aws ec2 describe-instances --query "Reservations[*].Instances[*].{Instance:InstanceId,Name:Tags[?Key=='Name']|[0].Value}" --output table --color off

echo -----------------------------------------

:askInstance
set /p id="Enter the InstanceID you want to manage: "

echo -----------------------------------------

:getConfirmation
set /p ActionInstance=Need to [check/start/stop] "%id%" Instance? 
if /I "%ActionInstance%"=="start" goto :StartInstance
if /I "%ActionInstance%"=="stop" goto :StopIstance
if /I "%ActionInstance%"=="check" goto :CheckIstance
REM added goto getConfirmation in case of invalid responses
goto getConfirmation

:StartInstance
aws ec2 start-instances --instance-ids %id%
timeout 5
goto ExitProgram

:StopIstance
aws ec2 stop-instances --instance-ids %id%
timeout 5
goto ExitProgram

:CheckIstance
aws ec2 describe-instances --instance-id %id% | find "Name"
timeout 5
goto ExitProgram

:ExitProgram
set /p ActionExit=Want to exit [y/n]? 
if /I "%ActionExit%"=="y" goto end
if /I "%ActionExit%"=="n" goto getConfirmation
REM added goto ActionExit in case of invalid responses
goto ActionExit
