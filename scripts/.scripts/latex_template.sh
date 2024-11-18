#!/bin/bash

templates_dir="/mnt/Storage/omar/Latex Templates"
logo="/mnt/Storage/omar/College/logo.png"
json_file="/mnt/Storage/omar/College/Courses Templates/Fall2024.json"

# List of template options
templates=("lab_report" "general_report")

# Function to replace placeholders in a template file
replace_placeholders() {
  # Check if a template file is provided
  if [ -z "$1" ]; then
    echo "Usage: replace_placeholders <template_file>"
    return 1
  fi

  # Check if the provided file exists
  if [ ! -f "$1" ]; then
    echo "File '$1' not found."
    return 1
  fi

  # Read the template file content
  template_content=$(<"$1")

  # Extract course names from JSON and load them into an array
  IFS=$'\n' courses=($(jq -r '.[] | .course_title' "$json_file"))

  # Display course names and ask user to select
  echo "Select the course:"
  for i in "${!courses[@]}"; do
    echo "$((i + 1)). ${courses[i]}"
  done
  read -p "Enter the number of the course you want to use: " course_choice

  # Validate selection
  if ! [[ "$course_choice" =~ ^[0-9]+$ ]] || ((course_choice < 1 || course_choice > ${#courses[@]})); then
    echo "Invalid input. Please enter a number within the range."
    return 1
  fi

  # Get the selected course JSON object
  matched_json=$(jq -r --argjson idx $((course_choice - 1)) '.[$idx]' "$json_file")

  # Decode the JSON and replace placeholders
  course_title=$(echo "$matched_json" | jq -r '.course_title')
  course_code=$(echo "$matched_json" | jq -r '.course_code')
  instructor=$(echo "$matched_json" | jq -r '.instructor')
  teaching_assistant=$(echo "$matched_json" | jq -r '.teaching_assistant')

  # Replace each field in the template
  template_content=$(echo "$template_content" | sed "s/<course_title>/$course_title/g")
  template_content=$(echo "$template_content" | sed "s/<course_code>/$course_code/g")
  template_content=$(echo "$template_content" | sed "s/<instructor>/$instructor/g")
  template_content=$(echo "$template_content" | sed "s/<teaching_assistant>/$teaching_assistant/g")

  cp "$logo" .
  read -p "Enter name for your file: " file_name

  # Write the modified content to a new file
  echo "$template_content" >"./$file_name"
  echo "Replacement completed. Modified file saved as '$file_name'."
}

# Display template options to the user
echo "Choose a template:"
for ((i = 0; i < ${#templates[@]}; i++)); do
  echo "$((i + 1)). ${templates[i]}"
done

# Read user input for template selection
read -p "Enter the number of the template you want to use: " choice

if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
  echo "Invalid input. Please enter a number."
  exit 1
fi

if ((choice < 1 || choice > ${#templates[@]})); then
  echo "Invalid choice. Please enter a number within the range."
  exit 1
fi

selected_template=${templates[choice - 1]}

# Output the selected template
echo "Selected Template: $selected_template"

replace_placeholders "$templates_dir/$selected_template.latex"
