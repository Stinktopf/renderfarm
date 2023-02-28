# Specify the environment
INSTALL_PATH=$HOME/Rendering
FLAMENCO_SOURCE=https://flamenco.blender.org/downloads/flamenco-3.1-linux-amd64.tar.gz
JQ_SOURCE=https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64

# Create Directorys
mkdir $INSTALL_PATH
mkdir $INSTALL_PATH/init
mkdir $INSTALL_PATH/flamenco
mkdir $INSTALL_PATH/flamenco/project
mkdir $INSTALL_PATH/flamenco/renders
mkdir $INSTALL_PATH/flamenco/software

# Copy scripts from repository to init folder
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cp -r $SCRIPTPATH/scripts/* $INSTALL_PATH/init/

# Install JQ
wget -O- $JQ_SOURCE > $INSTALL_PATH/init/jq-linux64
chmod +x $INSTALL_PATH/init/jq-linux64

# Download Flamenco
cd $INSTALL_PATH
wget -c $FLAMENCO_SOURCE -O - | tar -xz
