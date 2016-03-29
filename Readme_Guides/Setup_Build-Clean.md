#Setup Build/Clean
  1. Click the "Build" button (hotkey F5)
  2. If prompted, select your makefile browser dialog box

###If that didn't work...
  1. Go to File->Project Properties
  2. Select Build category, then select Make subcategory
  3. Make sure the "Build Command" and "Clean Command" fields are correct.
  <br> *Hint:* is Clean Command set to "${MAKE} clean" when your Makefile is set to "cl:"?
  <br> *Hint:* is Netbeans looking for **M**akefile when you have **m**akefile?
