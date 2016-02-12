#CONFIG
one_at_a_time=false # pause until "enter" hit between drivers
directory_of_drivers=$"C:\Users\comcc_000\Desktop\UF Spring 2016\Programming Language Principles\PLP_RPAL\RPAL\rpal"

#FUNCTIONS
Launch() { # Run the specified Driver
    cd "$directory_of_drivers"
    ./$1
    printf $"\n""$1 Run Complete!""\n"
    if $one_at_a_time; then
        read -p "Press enter to continue..."
    fi
}

#SETUP
printf $"Running $0 ...""\n\n"

#Project 1
Launch Project_1_Driver.sh

read -p "Press enter to continue..."




