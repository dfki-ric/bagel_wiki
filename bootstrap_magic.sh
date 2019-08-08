#! /bin/bash

mkdir bob-magic-dev
cd bob-magic-dev
DEV_DIR="$( cd "$( dirname "$0" )" && pwd )"
git clone https://github.com/rock-simulation/pybob.git
cd pybob


# create default config for magic Bagel
logicalCpuCount=$([ $(uname) = 'Darwin' ] && 
                       sysctl -n hw.logicalcpu_max || 
                           lscpu -p | egrep -v '^#' | wc -l)
echo "autoprojEnv: false" > pybob.yml
echo "buildOptional: true" > pybob.yml
echo "buildconfAddress: git@github.com:dfki-ric/bagel-buildconf.git" >> pybob.yml
echo "buildconfBranch: master" >> pybob.yml
echo "defBuildType: debug" >> pybob.yml
echo "devDir: ${DEV_DIR}" >> pybob.yml
echo "numCores: $logicalCpuCount" >> pybob.yml
echo "pyScriptDir: ${DEV_DIR}/pybob" >> pybob.yml
echo "rockFlavor: master" >> pybob.yml

./pybob.py bootstrap
