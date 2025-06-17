#!/bin/bash

#ask user to enter the assignment name
read -p "Please enter the assignment name: " new_assign

# Update the ASSIGNMENT value in config/config.env
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assign\"/" config/config.env

echo "Assignment has been updated successfully to $new_assign"
echo "Now running the reminder app..."
./startup.sh
