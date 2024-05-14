# Fixing Up backlit

for some unknown reasons to me : <br/>
    I can't turn on the keyboard backlit with just scrolllock option <br/>
    so there could be many ways to fix that but writing a basic script <br/>
    is fine and faster for me :) <br/><br/>

# HERE :

what is hapening down here is: <br/>
 @- lightsOn.sh is a executable that will intialize the setup by turning the <br/> 
    lightsOn of specific led mentioned from /sys/class/leds by giving proper <br/>
    permissions and inserting value 1 to brightness <br/>
 @- then, toggle.sh which is also a executable will be used as a file to be <br/>
    executed on the keybinds; that will toggle the lights on/off <br/><br/>
 
 @- and filePath.txt is a file to save the filePath which is used as middleware to <br/>
    pass down the file_path from the lightsOn to turnOn <br/>
    "I don't know other workaround to do this on wayland [ there is xset for x11 ] <br/>
     but anyway this is easy for me specifically" <br/><br/>
 
 @- now, One thing to be done is : call it as using alias or bin, <br/>
    alias lto="sudo ~/config/backlit/lto"

# Better fix - [ method 2 ]
just run kbBacklit.sh on some keybinds 
as its way easier to implement and grasp and works well on both x/wayland server
