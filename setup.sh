# Specify the environment
INSTALL_PATH=$HOME/Rendering
FLAMENCO_SOURCE=https://flamenco.blender.org/downloads/flamenco-3.1-linux-amd64.tar.gz

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

# Download Flamenco
cd $INSTALL_PATH
wget -c $FLAMENCO_SOURCE -O - | tar -xz
