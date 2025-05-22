#!/bin/bash

TODO_FILE="todo.txt"

# Ensure the file exists
touch "$TODO_FILE"

show_menu() {
    echo ""
    echo "==== Simple To-Do List ===="
    echo "1. View tasks"
    echo "2. Add task"
    echo "3. Remove task"
    echo "4. Exit"
    echo "==========================="
}

view_tasks() {
    echo ""
    echo "==== Your Tasks ===="
    if [[ ! -s $TODO_FILE ]]; then
        echo "No tasks found."
    else
        nl -w2 -s'. ' "$TODO_FILE"
    fi
}

add_task() {
    read -p "Enter new task: " task
    if [[ -n "$task" ]]; then
        echo "$task" >> "$TODO_FILE"
        echo "Task added."
    else
        echo "Empty task not added."
    fi
}

remove_task() {
    view_tasks
    read -p "Enter the task number to remove: " task_number
    if [[ "$task_number" =~ ^[0-9]+$ ]]; then
        sed -i "${task_number}d" "$TODO_FILE"
        echo "Task removed."
    else
        echo "Invalid input. Please enter a number."
    fi
}

# Main loop
while true; do
    show_menu
    read -p "Choose an option [1-4]: " choice
    case $choice in
        1) view_tasks ;;
        2) add_task ;;
        3) remove_task ;;
        4) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid option. Please choose 1–4." ;;
    esac
done

