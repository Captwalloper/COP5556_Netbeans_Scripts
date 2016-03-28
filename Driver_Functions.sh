# Contains all common functions among drivers

# CONFIG
source Common_Variables.sh
base_directory=$base_dir
rpal_directory=$script_dir
tests_directory=$tests_dir

#FUNCTIONS
# USE: Instruct_Helper message
# Example: Instruct_Helper "TYPE 1, CTRL-d"
Instruct_Helper() { # Provide a reminder about what input/behavior is expected for a test.
    printf "*********************************************""\n"
    printf "$1""\n"
}

# USE: Interpret_Helper programName programParam1 programParam2 ...
# Example: Interpret_Helper c01
# Example: Interpret_Helper c02 0 0
Interpret_Helper() { # Compile and run the specified program; pass along any additional parameters; log everything 
    printf "*********************************************""\n"  
    printf "RPAL_Interpreter ""$1""\n"                                
    printf "*********************************************""\n"
    Interpret_Helper_1 $*                   
}

Interpret_Helper_1() {
    if [ $# -eq 1 ] # no additional parameters supplied
    then
        (cd "$rpal_directory"; ./rpal -ast -noout tests/$1) 
    else 
        (cd "$rpal_directory"; echo "${@:2}" | ./rpal -ast -noout tests/$1)  
    fi 
}

# USE: P1_Helper programName programParam1 programParam2 ...
# Example: P1_Helper c01
# Example: P1_Helper c02 0 0
P1_Helper() { # Compile and run the specified program; pass along any additional parameters; log everything 
    printf "*********************************************""\n"  
    printf "P1 ""$1""\n"                                
    printf "*********************************************""\n"
    P1_Helper_1 $*                    
}

P1_Helper_1() {
    if [ $# -eq 1 ] # no additional parameters supplied
    then
        (cd "$base_directory"; ./p1 -ast "$tests_directory""/""$1") 
    else 
        (cd "$base_directory"; echo "${@:2}" | ./p1 -ast "$tests_directory""/""$1")  
    fi 
}

Eval_Helper() {
    FILENAME="$1"
    p1_file="Eval_P1_""$FILENAME"
    interpret_file="Eval_Interpret_""$FILENAME"

    Timeout P1_to_file "$p1_file" "$*"
    TrimEndSpaces $p1_file;

    Interpret_Helper_1 $* > $interpret_file;
    TrimEndSpaces $interpret_file;

    passed=0;
    if cmp -s $p1_file $interpret_file; then
        passed=1;
#        rm -f "Eval_P1_""$1" "Interpret_Helper_""$1"
    else 
        passed=0;
    fi
    printf "Eval $FILENAME"":\t""$passed"

    rm -f $p1_file".bak" $interpret_file".bak"
    rm -f $p1_file $interpret_file
    printf "\n"
    return $passed;
}

P1_to_file() {
    P1_Helper_1 ${@:2} > $1
}

TrimEndSpaces() {
    sed -i.bak 's/ *$//' $1
}

# USE: Timeout command args
# Example: Timeout echo "arg1" "arg2"
Timeout() { # Move on from input command if it continues longer than TIMEOUT
    TIMEOUT=1s;
    COMMAND=$1
    ARGS=${@:2}
    ( $COMMAND $ARGS; ) & pid=$!
    ( sleep $TIMEOUT && kill -HUP $pid ) 2>/dev/null & watcher=$!
    if wait $pid 2>/dev/null; then
#        echo "your_command finished"
        kill -HUP $watcher 
        wait $watcher >/dev/null 2>&1 # kill derpily, hide the errors
    else
#        echo "$COMMAND interrupted after $TIMEOUT";
        compiler="satisfied" # wanted to keep echo comment/else clause; this line satisfies compiler
    fi
}

File_Contents() {
    FILENAME=$1;
    Instruct_Helper "$(< $FILENAME)";
}

Pause() {
    TOGGLE=true;
    if [ $# -eq 1 ] # no additional parameters supplied
    then
        TOGGLE=$1;  
    fi
    
    if $TOGGLE; 
    then
       read -p "Press enter to continue..." 
    fi
}
