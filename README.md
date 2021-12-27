# aws-dos-console

Ths is a simple BASH / CMD .cmd script that autmate and simplify some operations:
- list the EC2 instances (based on your preferred region onn yuor AWS CLI configuration);
- select ID of the instance to manage;
- Start / Check / Stop that instance selected.

You can select instances to manage by ID then Start, Stop or simply check if it is on running state.

First Step: Launch this script

![Alt text](images/Start_Stop_v2.cmd.jpg?raw=true "Start / Stop Instances on CMD / Powershell")

Second Step: The script list instances and Ask you to select an instance, copy and paste the ID, then press enter

![Alt text](images/Start_Stop_v2.cmd_check.jpg?raw=true "Start / Stop Instances on CMD / Powershell ID instance")

- if you write 'check' it the script check simply the state, 
- if you write 'start' the script starts the instance, 
- if you write 'stop' the script stops the instance.

Then the script ask to you if you want to exit or not.