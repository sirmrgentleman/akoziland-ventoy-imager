#/bin/bash

#Akoziland Ventoy Imager v1.0, a tool for creating a ventoy image on a drive specified by the user.
#Run akoziventoyimager.sh -h for help.
#Current implementation is mostly a wrapper. It grabs the latest ventoy download, extracts it, then runs the official ventoy script.
#Original Author gitlab.com/sirmrgentleman

rss_feed_url="https://sourceforge.net/projects/ventoy/rss?path=/"
setup_dir=./.ventoy_setup

echo 'Welcome to the Akoziland Ventoy Imager'

#Get flags to pass to Ventoy.
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <arguements>. Run $0 -h for detailed help."
    exit 
fi

if [ "$1" == "-h" ]; then
    cat << EOF
The Akoziland Ventoy Imager
A wrapper around the offical ventoy script in order to automate the download proccess.
Usage:
akoziventoyimager.sh CMD [ OPTION ] /dev/sdX
CMD:
    -h   display this message
    -i   install ventoy to sdX (fail if disk already installed with ventoy)
    -I   force install ventoy to sdX (no matter installed or not)
    -u   update ventoy in sdX
    -l   list Ventoy information in sdX

  OPTION: (optional)
   -r SIZE_MB  preserve some space at the bottom of the disk (only for install)
   -s          enable secure boot support (default is disabled)
   -g          use GPT partition style, default is MBR style (only for install)
   -L          Label of the main partition (default is Ventoy)
EOF
    exit
fi

#Create temporary data folder
mkdir $setup_dir
echo 'The Imager will request root access later on.'
echo "Akoziland Ventoy Imager is creating a hidden folder at $setup_dir,"
echo 'Imager should delete it automatically afterwards. If not, it can safely be deleted manually.'
echo 'The Download will begin momentarily...'

# Fetch the RSS feed
rss_content=$(curl -s "$rss_feed_url")

# Extract the download URL of the latest Linux tar.gz file and save it.
download_url=$(echo "$rss_content" | grep -oPm1 "(https://sourceforge.net/projects/ventoy/files/v[0-9]+\.[0-9]+\.[0-9]+/ventoy-[0-9]+\.[0-9]+\.[0-9]+-linux\.tar\.gz/download)")
echo "Latest Ventoy download URL: $download_url"
file_name=$(echo "$download_url" | grep -oE '[^/]+\.tar\.gz' | sed 's/\-linux.tar.gz$//')
curl -L -o ./.ventoy_setup/ventoy-latest.tar.gz $download_url
tar -xf ./.ventoy_setup/ventoy-latest.tar.gz -C ./.ventoy_setup/

#Run the official ventoy script.
tput setaf 1; echo "Waiting for root password..."; tput sgr0
sudo "./.ventoy_setup/$file_name/Ventoy2Disk.sh" "$@"
rm -rf ./.ventoy_setup
echo "Completed. Exiting...."