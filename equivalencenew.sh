#!/bin/bash

# Function to check if directory exists and create if not
ensure_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}

# Main loop to read CSV file
while IFS=',' read -r name equivalence
do
    ensure_directory "$name"

    # Download equivalence file if URL is provided
    if [ -n "$equivalence" ]; then
        wget -c "$equivalence" -P "$name"/ 2>&1 | tee -a logfile.txt
        if [ $? -eq 0 ]; then
            echo "Downloaded equivalence file for $name"
        else
            echo "Failed to download equivalence file for $name"
        fi
    else
        echo "$name: No equivalence file found in CSV"
    fi

done < equivalences3.csv
