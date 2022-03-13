#!/usr/bin/bash

echo "----------------------------------------------"
echo ".bash_aliases"
echo "----------------------------------------------"
diff .bash_aliases ~/.bash_aliases
echo -e "\n\n"
echo "----------------------------------------------"
echo "diffing .bash_completion"
echo "----------------------------------------------"
diff .bash_completion ~/.bash_completion
echo -e "\n\n"
echo "----------------------------------------------"
echo "diffing .bash_profile"
echo "----------------------------------------------"
diff .bash_profile ~/.bash_profile
echo -e "\n\n"
echo "----------------------------------------------"
echo "diffing .bashrc"
echo "----------------------------------------------"
diff .bashrc ~/.bashrc
echo -e "\n\n"
echo "----------------------------------------------"
echo "diffing .bash_wsl_aliases"
echo "----------------------------------------------"
diff .bash_wsl_aliases ~/.bash_wsl_aliases
echo -e "\n\n"
echo "----------------------------------------------"
echo "diffing .profile"
echo "----------------------------------------------"
diff .profile ~/.profile
echo -e "\n\n"