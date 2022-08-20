#!/bin/sh

# The path to the linux host file
HOSTS_FILE=/etc/hosts
# The IP address for Cloaks+
IP="159.203.120.188"
# The domain to redirect to Cloaks+
REDIRECT_DOMAIN="s.optifine.net"
# The value to be inserted into the hosts file
INSERT_VALUE="$IP $REDIRECT_DOMAIN"
# The argument provided by the user
OPTION=${1?You need to provide an option! Please provide --install or --uninstall as an argument.}

if [ "$OPTION" = "--install" ]; then
    if grep -q "$INSERT_VALUE" "$HOSTS_FILE"; then
        echo "Cloaks+ is already installed!"
    else
        echo "Installing Cloaks+ into $HOSTS_FILE";
        sudo -- sh -c -e "echo '$INSERT_VALUE' >> $HOSTS_FILE";
        if grep -q "$INSERT_VALUE" "$HOSTS_FILE"; then
            echo "Cloaks+ was successfully installed";
        else
            echo "Failed to install Cloaks+."
        fi
    fi
elif [ "$OPTION" = "--uninstall" ]; then
    if grep -q "$INSERT_VALUE" "$HOSTS_FILE"; then
        echo "Removing Cloaks+"
        sudo sed -i".bak" "/$INSERT_VALUE/d" $HOSTS_FILE
        if grep -q "$INSERT_VALUE" "$HOSTS_FILE"; then
            echo "Failed to remove Cloaks+";
        else
            echo "Successfully removed Cloaks+"
        fi
    else
       echo "Cloaks+ is not installed 1"
    fi
else
    echo "Unknown option, please use '--install' or '--uninstall'."
fi