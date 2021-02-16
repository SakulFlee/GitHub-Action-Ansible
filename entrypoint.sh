#!/usr/bin/env bash

# --- Parse Options ---

PLAYBOOK_FILE="${1}"
INVENTORY_FILE="${2}"
REQUIREMENTS_FILE="${3}"
ADDITIONAL_ARGUMENTS="${4}"
PRE_TASK="${5}"
POST_TASK="${6}"

# --- Print Options ---
echo ""
echo ">>> Options:"
echo "PLAYBOOK_FILE: $PLAYBOOK_FILE"
echo "INVENTORY_FILE: $INVENTORY_FILE"
echo "REQUIREMENTS_FILE: $REQUIREMENTS_FILE"
echo "ADDITIONAL_ARGUMENTS: $ADDITIONAL_ARGUMENTS"
echo "PRE_TASK: $PRE_TASK"
echo "POST_TASK: $POST_TASK"

# --- Check Options ---
if [ -z "$PLAYBOOK_FILE" ]; then
    echo ""
    echo "No Ansible-Playbook file option was set (or is empty)!"
    exit 1
fi

if [ -z "$INVENTORY_FILE" ]; then
    echo ""
    echo "No Ansible-Playbook inventory file option was set (or is empty)!"
    exit 1
fi

# --- Pre Task ---
if [ ! -z "$PRE_TASK" ]; then
    echo ""
    echo ">>> Running pre task"
    
    eval "$PRE_TASK"
fi

# --- Requirements ---
if [ ! -z "$REQUIREMENTS_FILE" ]; then
    echo ""
    echo ">>> Installing requirements"
    
    eval "ansible-galaxy install -r $REQUIREMENTS_FILE"
fi

# --- Execute Playbook ---
echo ""
echo ">>> Execute Playbook"

eval "ansible-playbook -i $INVENTORY_FILE $ADDITIONAL_ARGUMENTS $PLAYBOOK_FILE"
EXIT_STATUS=$?
if [ $EXIT_STATUS -ne 0 ]; then
    echo "Ansible-Playbook execution failed. Check the log (above) for more information."
    exit $EXIT_STATUS
fi

# --- Post Task ---
if [ ! -z "$POST_TASK" ]; then
    echo ""
    echo ">>> Running post task"
    
    eval "$POST_TASK"
fi
