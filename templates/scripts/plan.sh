#!/bin/bash

terraform plan -out=tfapply > plan_output.txt

if grep -q "no changes" plan_output.txt; then
    echo "### NOTIFICATION: No changes detected. Exiting the build process."
    exit 1
else
    cat plan_output.txt
    echo "Changes detected. Continuing the build process."
fi

# 一時ファイルの削除
rm plan_output.txt
