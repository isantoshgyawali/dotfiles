# Fixing Up backlit

for some unknown reasons to me : \n
    I can't turn on the keyboard backlit with just scrolllock option \n
    so there could be many ways to fix that but writing a basic script \n
    is fine and faster \n\n

# HERE :

what is hapening down here is: \n
 @- lightsOn.sh is a executable that will setup the initialization by turning the \n 
    lightsOn of specific led mentioned from /sys/class/leds by giving proper \n
    permissions and inserting value 1 to brightness \n 
 @- then, toggle.sh which is also a executable which will be used as a file to be \n
    executed on the keyboard shortcuts ; that will toggle the lights on/off \n\n
 
 @- and filePath.txt is a file to save the filePath which is used as middleware to \n
    pass down the file_path from the lightsOn to turnOn \n
    "I don't know if awk can do this but anyway this is easy for me specifically" \n\n
 
 @- now, I thing to be done is : adding the execute using alias or path, \n
    alias lto="sudo ~/config/backlit/lto"
