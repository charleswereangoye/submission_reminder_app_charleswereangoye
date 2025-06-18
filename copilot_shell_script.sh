#!/bin/bash
#automatically detect the submission_reminder_* directory that was first created with create_environment.sh script
first_dir=$(find . -maxdepth 1 -type d -name "submission_reminder_*" | head -n 1)

#ask user to enter the assignment name
read -p "Please enter the assignment name: " new_assign

#navigating to the right  directory for execution
cd $first_dir 

# Update the ASSIGNMENT value in config/config.env
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assign\"/" ./config/config.env

echo "Assignment has been updated successfully to $new_assign"
echo "Now running the reminder app..."
./startup.sh
