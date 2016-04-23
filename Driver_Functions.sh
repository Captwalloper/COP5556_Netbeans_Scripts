# Contains all common functions among drivers

# CONFIG
source Common_Variables.sh
base_directory=$base_dir
rpal_directory=$script_dir
tests_directory=$tests_dir

#FUNCTIONS

# USE: Interpret_Helper filename 
# Example: Interpret_Helper t1
Interpret_Helper() { # Interpret the specified filename
    printf "*********************************************""\n"  
    printf "RPAL_Interpreter ""$1""\n"                                
    printf "*********************************************""\n"
    Interpret_Helper_1 $*                   
}

Interpret_Helper_1() {
    if [ "$#" -eq 1 ]; then
        ARGS="-ast -noout";
    else 
        ARGS=${@:2};
    fi
    (cd "$rpal_directory"; ./rpal $ARGS tests/$1)  
}

# USE: P1_Helper filename
# Example: P1_Helper t1
P1_Helper() { # P1 the specified filename
    printf "*********************************************""\n"  
    printf "P1 ""$1""\n"                                
    printf "*********************************************""\n"
    P1_Helper_1 $*                    
}

P1_Helper_1() {
    (cd "$base_directory"; ./p1 -ast "$tests_directory""/""$1") 
}

P2_Helper() { 
    printf "*********************************************""\n"  
    printf "P2 ""$1""\n"                                
    printf "*********************************************""\n"
    P2_Helper_1 $*                    
}

P2_Helper_1() {
    (cd "$base_directory"; ./p2 -all "$tests_directory""/""$1") 
}

Eval_Helper_P1() {
    FILENAME="$1"
    p1_file="Eval_P1_""$FILENAME"
    interpret_file="Eval_Interpret_""$FILENAME"

    Timeout P1_to_file "$p1_file" "$*"
    TrimEndSpaces $p1_file;

    Interpret_Helper_1 $* > $interpret_file;
    TrimEndSpaces $interpret_file;

    FILENAME="$1"

    passed=false; 
    if cmp -s $p1_file $interpret_file; then
        passed=true; 
#        rm -f "Eval_P1_""$1" "Interpret_Helper_""$1"
    else 
        passed=false; 
    fi

    rm -f $p1_file".bak";   rm -f $interpret_file".bak"
    rm -f $p1_file;         rm -f $interpret_file

    Bool_to_Int_Sane $passed;
    sane_bool=$?;
    Bool_to_Int_Bash $passed;
    bash_bool=$?;

    printf "Eval $FILENAME"":\t""$sane_bool""\n"
    return $bash_bool;
}

Eval_Helper_P2() {
    FILENAME="$1"
    p2_file="Eval_P2_""$FILENAME"
    interpret_file="Eval_Interpret_""$FILENAME"

    Timeout P2_to_file "$p2_file" "$*"
    TrimEndSpaces $p2_file;

    Interpret_Helper_1 $* > $interpret_file;
    TrimEndSpaces $interpret_file;

    FILENAME="$1"

    passed=false; 
    if cmp -s $p2_file $interpret_file; then
        passed=true; 
#        rm -f "Eval_P1_""$1" "Interpret_Helper_""$1"
    else 
        passed=false; 
    fi

    rm -f $p1_file".bak";   rm -f $interpret_file".bak"
    rm -f $p1_file;         rm -f $interpret_file

    Bool_to_Int_Sane $passed;
    sane_bool=$?;
    Bool_to_Int_Bash $passed;
    bash_bool=$?;

    printf "Eval $FILENAME"":\t""$sane_bool""\n"
    return $bash_bool;
}

Bool_to_Int_Bash() {
    BOOL=$1;
    if $BOOL;
    then 
        return 0; #yup, 0 is true in bash because reasons: http://stackoverflow.com/questions/2933843/why-0-is-true-but-false-is-1-in-the-shell
    else
        return 1; #... and false is anything else
    fi
}

Bool_to_Int_Sane() {
    BOOL=$1;
    if $BOOL;
    then 
        return 1; 
    else
        return 0;
    fi
}

P1_to_file() {
    FILE=$1;
    ARGS=${@:2};
    P1_Helper_1 $ARGS > $FILE
}

P2_to_file() {
    FILE=$1;
    ARGS=${@:2};
    P2_Helper_1 $ARGS > $FILE
}

TrimEndSpaces() {
    FILENAME=$1;
    sed -i.bak 's/ *$//' $FILENAME
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
    File_Contents_Header "$(< $FILENAME)";
}

File_Contents_Header() { # Provide a reminder about what input/behavior is expected for a test.
    printf "*********************************************""\n"
    printf "$1""\n"
}

Pause() {
    PAUSE=true;
    if [ $# -eq 1 ] # 1 parameter supplied
    then
        PAUSE=$1;  
    fi
    
    if $PAUSE; 
    then
       read -p "Press enter to continue..." 
    fi
}

GenerateCustomLines() {
    eval_dir="$tests_directory"
    cd "$eval_dir"
    echo "COPY-PASTE AFTER THIS..." > temp.txt
    for f in *
    do
        echo "Test $f;" >> temp.txt
    done
    cd "$OPLDPWD" # return to prior directory
}
