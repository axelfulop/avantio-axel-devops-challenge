#!/bin/bash

PROFILE=$1
ENV=$2
REGION=$3

if [ -z "$PROFILE" ]; then
    echo "PROFILE is empty"
    exit 1
fi

if [ -z "$ENV" ]; then
    echo "ENV is empty"
    exit 1
fi

if [ -z "$REGION" ]; then
    echo "REGION is empty"
    exit 1
fi

TF_DIRECTORY="terraform/$REGION/$ENV"
INIT_DIRECTORY="terraform/$REGION/init"

export AWS_PROFILE=$PROFILE

# Function to run Terraform commands
run_terraform() {
    terraform -chdir="$1" $2 -var "profile=$PROFILE" -var "env=$ENV" -var "region=$REGION"
}

# Display menu
echo "Select an option:"
echo "1) Deploy for the first time"
echo "2) Subsequent deployment"

read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        echo "First deployment detected. Initializing and applying Terraform..."
        run_terraform "$INIT_DIRECTORY" "init"
        run_terraform "$INIT_DIRECTORY" "apply"
        ;;
    2)
        echo "Subsequent deployment. Initializing and applying Terraform..."
        run_terraform "$TF_DIRECTORY" "init"
        run_terraform "$TF_DIRECTORY" "apply"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac
