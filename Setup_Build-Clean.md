# COP5556_Netbeans_Scripts
Scaffolding to run RPAL in netbeans.

1. Install netbeans with c++ module
	If netbeans is installed without c++...
	1. Go to tools->plugins->settings
	2. Make sure all update centers are active (left panel)
	3. Go to Available Plugins
	4. Press Chech for Newest
	5. Install everything in C/C++ category (e.g. Gdbserver , C/C++, optionally NBCndUnit)
2. Create Project
	1. Go to file->New Project
	2. Category=C/C++, Projects=C/C++ Project with Existing Sources; Hit next
	3. Browse to your project folder
	4. Select Configuration Mode: Automatic; Next
3. Copy scripts into your project
	1. Move [the files] into your project as desired
4. Create custom configuration
	1. File->Project Properties
	2. In Build Category, Press Manage Configurations
	3. Press New
	4. Input name (e.g. Driver)
	5. Press Set Active; OK
	6. Press apply, OK
	7. Ensure RPAL_Driver_Driver.sh, Project_1_Driver.sh executable
	8. Set Run command to "./RPAL_Driver_Driver.sh"
5. Hit Run
6. Make sure build/clean works
7. Make sure debugger works
	1. Make sure you have every g++ with a -g switch
