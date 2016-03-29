#!/bin/bash

#CONFIG
source Common_Variables.sh
directory_of_drivers=$scripts_dir
one_at_a_time=false # pause until "enter" hit between drivers

#FUNCTIONS
Launch() { # Run the specified Driver
    cd "$directory_of_drivers"
    ./$1
    printf $"\n""$1 Run Complete!""\n"
    if $one_at_a_time; then
        read -p "Press enter to continue..."
    fi
}

Force_Quit() {
    trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT
}

#SETUP
printf $"Running $0 ...""\n\n"

#MAIN

#Project 1
Launch Project_1_Driver.sh

read -p "Press enter to continue..."


#AFTERMATH
Force_Quit





