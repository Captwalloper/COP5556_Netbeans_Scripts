#CONFIG
script_directory=$"C:\Users\comcc_000\Desktop\UF Spring 2016\Programming Language Principles\PLP_RPAL\RPAL\rpal"
project="pr1"
log_file=$project"_log_file"".txt"
golden_log_file="golden_"$log_file

one_at_a_time=false # pause between tests
golden_run=false # declare this run as the gospel against which to run regression tests
run_diff=false # compare most recent log to golden log

#FUNCTIONS
Log() { # In addition to sending stdout to console, append it to the logfile.
    Log_Helper $log_file
}

Instruct() { # Provide a reminder about what input/behavior is expected for a test.
    Instruct_Helper "$1"
}

Test() { # Compile and run the specified program; pass along any additional parameters; log everything 
    Test_Helper $* | Log
}

TimeoutTest() { # Same as test, but timeout after a few seconds
    seconds=3;
    TimeoutTest_Helper $seconds $*
}

Show_Expected_Results() { # Display a test's expected results for convenient comparison
    Show_Expected_Results_Helper $one_at_a_time "$1"
}

#SETUP
cd "$script_directory"
echo "|---$0---|"; 

rm $log_file # ensure log_file is regenerated each run

source Driver_Functions.sh # NOTE: if in doubt, use absolute filepath here (this is basically an import statement)






#MAIN
Instruct $"Sums 1 through 5"; Test add; Show_Expected_Results $"15"
Instruct $"???"; Test tiny; Show_Expected_Results $"???"





#AFTERMATH
if $run_diff
then
    printf "*******************************************************\n"
    printf "The difference between this run and the golden run was:\n"
    diff $log_file $golden_log_file
fi

if $golden_run;
then # regenerate gold log file
   rm $golden_log_file
   cp -a $log_file $golden_log_file 
fi
