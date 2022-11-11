virtualenv --python=python3.9 protoutils-env

source protoutils-env/bin/activate

pip install .

python3.9 ./protoutils/command.py convert --protopath /Users/rajan/IdeaProjects/ril/brain-proto --pythonpath /Users/rajan/IdeaProjects/ril/brain-proto/compile
python3.9 ./protoutils/command.py convert --protopath ./protos --pythonpath ./p-compile




