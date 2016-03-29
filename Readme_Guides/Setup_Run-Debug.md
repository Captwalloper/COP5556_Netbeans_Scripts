#Setup Run/Debug
  1. Go to File->Project Properties
  2. Choose the Run category
  3. Set the Run Command field appropriately
    * For Windows: set it to p1.exe
    * For Other: set it to ./p1.exe
  4. Set args
    * add the following to the Run Command " -ast [path_to_test_file]"
    <br>    *Note:* The test file is a special, custom file input you make to debug with. In practice, you'll probably copy-paste tests (or trickly parts of them) into it. 
    <br>    *Note:* The test file must be placed in the same directory as the other tests for the driver to be able to find it by default.
    * My full Run Command, on Windows, looks like: "p1.exe -ast rpal/tests/Test_Ze_Stuff.txt"
