 	   GMS2 Display Controller 
Simple display controller for Game Maker Studio 2

To install:
1. Create a script called "Display"
2. Copy and paste my code from the repo

To get started create a new object and initialize the Display as such:
### display = new Display(width, height);
After you initialized the Display you can modify flags such as:
### scale_gui  - boolean (false by default)
### 	       - whether to scale down the gui with the resolution
### fullscreen - boolean (false by default)
###	       - whether the game is fullscreen or not
And after modifying the flags you simply call:
### display.apply()
To apply all the settings.
### Getters:
###  get_width 	    - Returns current window width,
###  get_height     - Returns current window height,
###  get_min_width  - Returns smallest possible window width,
###  get_min_height - Returns smallest possible window height,
###  get_max_width  - Returns biggest possible window width,
###  get_max_height - Returns biggest possible window height,
###  get_fullscreen - Returns whether window is fullscreen or not,
###  toString	    - Returns string representation of resolution

### Functions:
###  apply() 		    - Applies all resolution settings,
###  increment_resolution() - Increments resolution scale by 1 (automatically applies),
###  decrement_resolution() - Decrements resolution scale by 1 (automatically applies),
###  toggle_fullscreen()    - Toggles fullscreen mode (automatically applies)
 
### IO Functions:
###  loadFromFile(file_path) - Loads settings from provided file (doesn't apply automatically),
###  saveToFile(file_path)   - Saves settings to a provided file
