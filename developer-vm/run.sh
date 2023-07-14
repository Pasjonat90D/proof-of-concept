#!/bin/sh

oldDefaultMachineFolder=$(vboxmanage list systemproperties | grep folder | cut -d" "  -f4- | xargs)
newDefaultMachineFolder="$(pwd)/disk"

echo 'Disks location'
echo '- default: '$oldDefaultMachineFolder
echo '- developer-vm: '$newDefaultMachineFolder

read -p "Continue (y/n)? " choice
case "$choice" in
  y|Y )
        echo "Creating..."
        if [ ! -d "$newDefaultMachineFolder" ]; then
          echo "Creating folder ${newDefaultMachineFolder}..."
          mkdir "$newDefaultMachineFolder"
        fi

        echo 'Changing default machine folder'
        vboxmanage setproperty machinefolder $newDefaultMachineFolder
        #
        echo 'Creating disk'
        vagrant up
        echo 'Created successfully'
        #
        echo 'Restoring default machine folder'
        vboxmanage setproperty machinefolder "$oldDefaultMachineFolder"

        echo 'Process completed'


#        vagrant ssh
#        sudo apt-get update
        ;;
  n|N )
        echo "No"
        ;;
  * )
        echo "Invalid"
        ;;
esac