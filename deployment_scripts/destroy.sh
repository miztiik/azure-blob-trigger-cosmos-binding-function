# set -x
set -e

# Define colors for console output
GREEN="\e[32m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"
# echo -e "${GREEN}This text is green.${RESET}"

# Set Global Variables
MAIN_BICEP_TEMPL_NAME="main.bicep"
LOCATION=$(jq -r '.parameters.deploymentParams.value.location' params.json)
SUB_DEPLOYMENT_PREFIX=$(jq -r '.parameters.deploymentParams.value.sub_deploymnet_prefix' params.json)
ENTERPRISE_NAME=$(jq -r '.parameters.deploymentParams.value.enterprise_name' params.json)
ENTERPRISE_NAME_SUFFIX=$(jq -r '.parameters.deploymentParams.value.enterprise_name_suffix' params.json)
GLOBAL_UNIQUENESS_SOURCE=$(jq -r '.parameters.deploymentParams.value.global_uniqueness' params.json)

TO_DEL_NUM=$(echo $GLOBAL_UNIQUENESS_SOURCE | sed 's/^0*//') # Remove leading zeros
TO_DEL_NUM="$((TO_DEL_NUM - 1))" # Decrement by 1
printf -v GLOBAL_UNIQUENESS "%03d" "$TO_DEL_NUM" # Add leading zeros
# echo $GLOBAL_UNIQUENESS


RG_NAME="${ENTERPRISE_NAME}_${ENTERPRISE_NAME_SUFFIX}_${GLOBAL_UNIQUENESS}"

function shiva_de_destroyer {
  if [[ $1 == "shiva" ]]; then
    echo -e "${RED}"
    echo "|------------------------------------------------------------------|"
    echo "|                                                                  |"
    echo "|                   Shiva the destroyer in action                  |"
    echo "|             Beginning the end of the Miztiikon Universe          |"
    echo "|                                                                  |"
    echo "|------------------------------------------------------------------|"
    echo -e "${RESET}"
    

    echo -e "${RED} Initiating Resource Group Deletion ${RESET}" # Yellow
    echo -e "${CYAN} - ${RG_NAME} ${RESET}" # Green

    az deployment sub delete \
        --name ${RG_NAME}

    # Delete a resource group without confirmation
    az group delete \
        --name ${RG_NAME} --yes \
        --no-wait
  fi
}


# Universal DESTROYER BE CAREFUL
shiva_de_destroyer $1
