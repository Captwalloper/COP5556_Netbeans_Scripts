#Setup Project Configurations

##(Optional) Rename the "default" Configuration to "Debug"
  1. To the left of the Build Button is a drop-down box for project configurations. Click it's down arrow.
  2. Pick "customize"
  3. Press "Manage Configurations"
  4. Select "default"; press rename; etc.
  
##Setup "Driver" Configuration
  1. Complete steps 1-3 above to reach the "Configurations" screen.
  2. Press New
  4. Input name (e.g. Driver)
  5. Press Set Active; OK
  6. Press apply, OK
  7. Choose the Run category
  8. Set the Run Command field appropriately
    * **For Windows:** set it to the location of DriverBootstrap.bat relative to your project directory (or absolutely, if that's hard)
    <br>      *Note:* for me it's "rpal/DriverBootstrap.bat" (rpal is a directory in my project folder)
    * **For Other:** set it to the location of RPAL_Driver_Driver.sh instead (see above)
  9. Apply; OK
