#!/bin/bash

# Database file
DB_FILE="employee_db.txt"

# Function to add an employee
add_employee() {
    echo "Enter Employee ID:"
    read emp_id
    echo "Enter Employee Name:"
    read emp_name
    echo "Enter Employee Salary:"
    read emp_salary
    echo "$emp_id, $emp_name, $emp_salary" >> $DB_FILE
    echo "Employee added successfully."
    echo
}

# Function to update employee information
update_employee() {
    echo "Enter Employee ID to update:"
    read emp_id
    grep -q "$emp_id" $DB_FILE
    if [ $? -eq 0 ]; then  #if the previous command is 0
        echo "Enter new Employee Name:"
        read new_name
        echo "Enter new Employee Salary:"
        read new_salary
        sed -i "/^$emp_id/c$emp_id, $new_name, $new_salary" $DB_FILE
        echo "Employee information updated."
        echo
    else
        echo "Employee not found."
    fi
    echo
}

# Function to delete employee information
delete_employee() {
    echo "Enter Employee ID to delete:"
    echo
    read emp_id
    grep -q "$emp_id" $DB_FILE
    if [ $? -eq 0 ]; then  #if the previous command is 0
        sed -i "/^$emp_id/d" $DB_FILE
        echo "Employee information deleted."
        echo
        else
        echo "Employee not found."
    fi
    echo
}

# Function to search employee information
search_employee() {
    echo "Enter Employee ID to query: "
    read emp_id
    echo
    grep -q "$emp_id" $DB_FILE
    if [ $? -eq 0 ]; then  #if the previous command is 0
        grep "$emp_id" $DB_FILE
    else
        echo "Employee not found."
    fi
    echo
}

# Function to generate a salary slip and save it to a file
generate_salary_slip() {
    echo "Enter Employee ID for Salary Slip:"
    read emp_id
    grep -q "$emp_id" $DB_FILE
    if [ $? -eq 0 ]; then  #if the previous command is 0

 #gets the employee's information of the given ID.
        employee_details=$(grep "$emp_id" $DB_FILE)  
#gets the employee's name and outputs as second field with a comma before the name.
        emp_names=$(echo "$employee_details" | cut -d ',' -f 2)
#gets the employee's salary and outputs as third field with a comma before the salary.
        emp_salary=$(echo "$employee_details" | cut -d ',' -f 3)
       
#Generate salary slip
       	echo
        echo "Generating salary slip for $emp_name "
        echo "--------------------------------------------"
        echo "Employee ID: $emp_id"
        echo "Employee Name: $emp_names"
        echo "Salary: $emp_salary"
        echo "--------------------------------------------"
        echo
	
# Save the salary slip to a fixed file
        salary_slip_file="salary_slip.txt"
        echo "Salary Slip for $emp_names" > "$salary_slip_file"
        echo "--------------------------------------------" >> "$salary_slip_file"
        echo "Employee ID: $emp_id" >> "$salary_slip_file"
        echo "Employee Name: $emp_names" >> "$salary_slip_file"
        echo "Salary: $emp_salary" >> "$salary_slip_file"
        echo "--------------------------------------------" >> "$salary_slip_file"

        echo "Salary slip saved to $salary_slip_file"
        echo   
        else
        echo "Employee not found."
        echo
    fi
}

# Main menu
while true; do
    echo "Employee Database Management System"
    echo "1. Add Employee Details. "
    echo "2. Update Employee Details."
    echo "3. Delete Employee Details."
    echo "4. Search Employee information"
    echo "5. Generate Salary Slip"
    echo "6. Exit"
    echo
    echo "Select an option(1-6) then press enter: " 
    read choice
 
    case $choice in
        1) add_employee ;;
        2) update_employee ;;
        3) delete_employee ;;
        4) search_employee ;;
        5) generate_salary_slip ;;
        6) echo "Exiting..." ; exit 0 ;;
        *) echo "Invalid option"  ;;
	  
    esac
done

