# AWS DOS Console Script

This repository contains the **AWS-DOS-CONSOLE** script, designed to help manage AWS EC2 instances with ease using DOS batch commands. The script provides a user-friendly, command-line interface for controlling EC2 instances directly from a Windows machine without needing to use the AWS Management Console.

## Features

- **Start/Stop EC2 Instances**: Easily start or stop your AWS EC2 instances by specifying the **Instance ID**.
- **Query Instance State**: Check the current state (running, stopped) of any EC2 instance.
- **Reboot Instances**: Reboot your instances quickly and efficiently.
- **Simplified Management**: Provides a batch script for Windows users, removing the need to manually enter complex AWS CLI commands.

## Prerequisites

Before running the script, make sure the following are installed and properly configured:

- **AWS CLI**: The AWS Command Line Interface (CLI) must be installed and configured with valid AWS credentials.
- **Windows OS**: This script is written for DOS/Windows environments.
- **AWS Credentials**: You should have AWS credentials set up and configured.

### Install AWS CLI

If you don't have the AWS CLI installed, follow the steps below:

1. Download the AWS CLI installer for Windows from the [official AWS documentation](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html).
2. Run the installer and follow the instructions to complete the installation.
3. Configure your AWS credentials by running the following command:

    ```bash
    aws configure
    ```

## How to Use

1. Clone the repository:
    ```bash
    git clone https://github.com/CarloSacchi/aws-dos-console.git
    cd aws-dos-console
    ```

2. Make sure AWS CLI is properly installed and configured with your credentials.

3. Run the batch file:
    ```cmd
    AWS_DOS_Console.bat
    ```

4. Follow the on-screen instructions to start, stop, reboot, or check the status of your EC2 instances by specifying the **Instance ID**.

## License

This project is licensed under the MIT License

## Instructions

Ths is a simple BASH / CMD .cmd script that automate and simplify some operations like:
- list the EC2 instances (based on your preferred region on yuor AWS CLI configuration);
- select ID of the instance to manage;
- Start / Check / Stop that instance selected
- Change type of an instance.

You can select instances to manage by ID then Start, Stop or simply check if it is on running state.

First Step: Launch this script

![Alt text](images/Start_Stop_v2.cmd.jpg?raw=true "Start / Stop Instances on CMD / Powershell")

Second Step: The script list instances and Ask you to select an instance, copy and paste the ID, then press enter

![Alt text](images/Start_Stop_v2.cmd_check.jpg?raw=true "Start / Stop Instances on CMD / Powershell ID instance")

- if you write 'check' it the script check simply the state, 
- if you write 'start' the script starts the instance, 
- if you write 'stop' the script stops the instance.

Then the script ask to you if you want to exit or not.
