#!/bin/bash

cp --parents  /var/lib/jenkins/jobs/*/config.xml -r .
cp -r var/lib/jenkins/jobs .
rm -r var

find . -name *.xml -type f -exec sed -i "s/192.168.81.39/192.168.68.110/g"  {} \;
find . -name *.xml -type f -exec sed -i "s/192.168.81.81/192.168.68.190/g"  {} \;
find . -name *.xml -type f -exec sed -i "s/192.168.81.32/192.168.68.191/g"  {} \;

sync

git diff .
