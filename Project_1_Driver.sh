#CONFIG
source Common_Variables.sh # NOTE: if in doubt, use absolute filepath here (this is basically an import statement)
source Driver_Functions.sh # NOTE: if in doubt, use absolute filepath here (this is basically an import statement)
script_directory=$script_dir
tests_directory=$tests_dir
one_at_a_time=false # pause between tests

#FUNCTIONS
Instruct() { # Provide a reminder about what input/behavior is expected for a test.
    Instruct_Helper "$1"
}

P1() { # Use P1 to interpret the specified program; pass along any additional parameters 
    P1_Helper $*
}

Interpret() { # Use Bermudez's RPAL interpreter the specified program; pass along any additional parameters
    Interpret_Helper $*
}

Compare() {
    Timeout P1 $*
    Interpret $*
}

Eval() {
    Eval_Helper "$*"
}

EvalAll() {
    count=0;
    passcount=0;
    eval_dir="$tests_directory"
    cd "$eval_dir"
    for f in *
    do
#        echo "Test $f;" >> temp.txt
        if ! Eval_Helper $f; then
            ((passcount++));
        fi
        ((count++))
    done
    printf "$passcount passed. "
    printf "\t$count files.""\n"
    cd "$OPLDPWD"
}

Test() {
    FILENAME=$1
    (cd "$tests_directory"; File_Contents "$FILENAME");
    Compare $FILENAME;
    Eval $FILENAME;
    Pause $one_at_a_time;
}

#SETUP
cd "$script_directory"
echo "|---$0---|"; 

#MAIN
#EvalAll

#Test Innerprod;
#Test Innerprod2;
#Test Treepicture;
#Test add;
#Test clean;
#Test conc.1;
#Test conc1;
#Test conc3;
#Test defns.1;
#Test defns.2;
#Test defns.3;
#Test div;
#Test envlist;
#Test fn1;
#Test fn2;
#Test fn3;
#Test ftst;
#Test if1;
#Test if2;
#Test infix;
#Test infix2;
#Test pairs1;
#Test pairs2;
#Test pairs3;
#Test pf;
#Test picture;
#Test print1;
#Test print2;
#Test prog;
#Test recurs.1;
#Test reverse;
#Test send;
#Test simple.div;
#Test stem1;
#Test stem2;
#Test string1;
#Test sum;
Test t1;
#Test t16;
#Test t18;
#Test t19;
#Test t2;
#Test t3;
#Test t3.1;
#Test t9;
#Test test1;
#Test tiny;
#Test tiny.1;
#Test towers;
#Test trees;
#Test tuples;
#Test vectorsum;
#Test wsum1;
#Test wsum2;

#AFTERMATH

