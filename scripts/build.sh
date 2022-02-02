#!/bin/bash
# Script to create python package out of the proto files & publish the same to nexus

#TODO:Import logger
function yellow(){
    echo -e "\x1B[33m $1 \x1B[0m"
    if [ ! -z "${2}" ]; then
    echo -e "\x1B[33m $($2) \x1B[0m"
    fi
}


yellow 'Starting..'
yellow 'Download virtualenv'
pip3 install virtualenv --trusted-host nexus.rjil.ril.com --index-url http://Brain_os:Brain_os@nexus.rjil.ril.com:9081/repository/Brain_os-py-group/simple/

yellow 'Activate virtualenv'
python3 -m venv ./brainenv
source ./brainenv/bin/activate

yellow 'Pull protoutils from nexus' 
pip3 install protoutils --trusted-host nexus.rjil.ril.com --index-url http://Brain_os:Brain_os@nexus.rjil.ril.com:9081/repository/Brain_os-py-group/simple/

yellow 'Compile protos to python'
#TODO: bump up the version in the setup.py file to maka and publish a new version
protoutils convert --protopath ../brain-proto/ --pythonpath ./brainproto/
cd ./brainproto/

yellow 'Build python distribution'
python3 setup.py sdist

yellow 'Install twine'
pip3 install twine --trusted-host 10.141.51.157 --trusted-host nexus.rjil.ril.com --index-url http://Brain_os:Brain_os@nexus.rjil.ril.com:9081/repository/Brain_os-py-group/simple/

yellow 'Upload distribution to nexus using twine'
twine upload -r nexus --repository-url http://10.141.51.157:9081/repository/Brain_os-py/ -u Brain_os -p Brain_os ./dist/*

yellow 'Pull brainproto from nexus'
pip3 install brainproto --trusted-host nexus.rjil.ril.com --index-url http://Brain_os:Brain_os@nexus.rjil.ril.com:9081/repository/Brain_os-py-group/simple/

yellow 'Import brainproto to check if working'
echo `python3 -c 'import jio; dir(jio)'`

yellow 'Deactivate virtualenv and delete folders'
cd ../
deactivate
rm -rf ./brainenv
rm  -rf ./brainproto