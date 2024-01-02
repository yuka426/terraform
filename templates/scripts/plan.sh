#!/bin/bash

terraform plan -out=tfapply > plan_output.txt

if grep -q "no changes" plan_output.txt; then
    echo "No changes detected. Exiting the build process."
    exit 1
else
    echo "Changes detected. Continuing the build process."
fi

# 一時ファイルの削除
rm plan_output.txt
