#The Akoziland Ventoy Imager
A wrapper around the offical ventoy script in order to automate the download proccess.
Download the script, navigate to the directory it is saved in, then run it from the terminal with ./akoziventoyimager.sh.
You may need to add executable permissions with chmod +x akoziventoyimager.sh.
Usage:
```akoziventoyimager.sh CMD [ OPTION ] /dev/sdX
  CMD:
    -h   display the help message
    -i   install ventoy to sdX (fail if disk already installed with ventoy)
    -I   force install ventoy to sdX (no matter installed or not)
    -u   update ventoy in sdX
    -l   list Ventoy information in sdX
    
  OPTION: (optional)
   -r SIZE_MB  preserve some space at the bottom of the disk (only for install)
   -s          enable secure boot support (default is disabled)
   -g          use GPT partition style, default is MBR style (only for install)
   -L          Label of the main partition (default is Ventoy)```
