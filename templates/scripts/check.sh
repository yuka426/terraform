#!/bin/bash

# Accept Command Line Arguments
SKIPVALIDATIONFAILURE=$1
tfValidate=$2
tfFormat=$3
tfCheckov=$4
tfTfsec=$5
# -----------------------------

echo "### VALIDATION Overview ###"
echo "-------------------------"
echo "Skip Validation Errors on Failure : ${SKIPVALIDATIONFAILURE}"
echo "Terraform Validate : ${tfValidate}"
echo "Terraform Format   : ${tfFormat}"
echo "------------------------"
terraform init
if (( ${tfValidate} == "Y"))
then
    echo "## VALIDATION : Validating Terraform code ..."
    terraform validate
fi
tfValidateOutput=$?

if (( ${tfFormat} == "Y"))
then
    echo "## VALIDATION : Formatting Terraform code ..."
    terraform fmt -recursive
fi
tfFormatOutput=$?

echo "## VALIDATION Summary ##"
echo "------------------------"
echo "Terraform Validate : ${tfValidateOutput}"
echo "Terraform Format   : ${tfFormatOutput}"
echo "------------------------"

if (( ${SKIPVALIDATIONFAILURE} == "Y" ))
then
  #if SKIPVALIDATIONFAILURE is set as Y, then validation failures are skipped during execution
  echo "## VALIDATION : Skipping validation failure checks..."
elif (( $tfValidateOutput == 0 && $tfFormatOutput == 0))
then
  echo "## VALIDATION : Checks Passed!!!"
else
  # When validation checks fails, build process is halted.
  echo "## ERROR : Validation Failed"
  exit 1;
fi