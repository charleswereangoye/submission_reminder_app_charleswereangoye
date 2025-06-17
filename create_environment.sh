#!/bin/bash
#step 1 prompt the user for their name 
read -p "please enter your name: " username

#create parent directory  with user input
p_dir="submission_reminder_${username}"

#step 2 create folder structure
mkdir -p $p_dir/app
mkdir -p $p_dir/modules
mkdir -p $p_dir/assets
mkdir -p $p_dir/config

#step 3 file creation
# 1 reminder.sh
cat <<'EOL' > $p_dir/app/reminder.sh
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOL

# 2 functions.sh
cat <<'EOL' > $p_dir/modules/functions.sh
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOL

# 3 submissions.txt
cat <<'EOL' > $p_dir/assets/submissions.txt
student,assignment,submission status
Chinemerem,Shell Navigation,not submitted
Chiagoziem,Git,submitted
Divine,Shell Navigation,not submitted
Anissa,Shell Basics,submitted
EOL

# 4 config.env
cat <<'EOL' > $p_dir/config/config.env
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

# 5 startup.sh
cat <<'EOL' > $p_dir/startup.sh
#!/bin/bash
./app/reminder.sh
EOL

#step 4 making all .sh file executable
find "${p_dir}" -type f -name "*.sh" -exec chmod +x {} \;

echo "Your app has been successfully created in $p_dir"
echo "To run your app cd $p_dir and run the startup.sh file"
