#!/bin/sh

foo () {
    echo $1
}

oldDefaultMachineFolder=$(vboxmanage list systemproperties | grep folder | cut -d" "  -f4- | xargs)
newDefaultMachineFolder="$(pwd)/disk"

echo 'Disks location'
echo '- default: '$oldDefaultMachineFolder
echo '- developer-vm: '$newDefaultMachineFolder

read -p "Continue (y/n)?" choice
case "$choice" in
  y|Y )
        echo "yes"
        foo 'test1'
        ;;
  n|N )
        echo "no"
        foo 'test2'
        ;;
  * )
        echo "invalid"
        foo 'test3'
        ;;
esac







#
#
#if [ ! -d "$newDefaultMachineFolder" ]; then
#  echo "Creating folder ${newDefaultMachineFolder}..."
#  mkdir "$newDefaultMachineFolder"
#fi
#echo $newDefaultMachineFolder
#
#echo 'Test' $oldDefaultMachineFolder
#
#echo 'Przed'
#vboxmanage setproperty machinefolder $newDefaultMachineFolder
#vboxmanage list systemproperties | grep folder
##
#vagrant up
##
#echo 'Po'
#vboxmanage setproperty machinefolder "$oldDefaultMachineFolder"
#vboxmanage list systemproperties | grep folder
#
#echo 'END'
#



