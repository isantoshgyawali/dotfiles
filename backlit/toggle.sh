#!/bin/bash
#!/bin/bash

#-- Just to pass the file_path between
#-- as this is for the keyboard shortcut purposes and making it
#-- run on superuser privilleges will make it's implementation worthless
file_path=$(cat ~/config/backlit/filepath.txt)
echo $file_path

esc_state=$(cat $file_path)

if [[ "$esc_state" == "1" ]]; then 
	echo 0 >> $file_path 

else 
	echo 1 >> $file_path
fi
