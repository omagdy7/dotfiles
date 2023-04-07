#!/bin/sh
##################################################################
#  ___                         __  __                 _          #
# / _ \ _ __ ___   __ _ _ __  |  \/  | __ _  __ _  __| |_   _    # 
#| | | | '_ ` _ \ / _` | '__| | |\/| |/ _` |/ _` |/ _` | | | |   #
#| |_| | | | | | | (_| | |    | |  | | (_| | (_| | (_| | |_| |   #
# \___/|_| |_| |_|\__,_|_|    |_|  |_|\__,_|\__, |\__,_|\__  |   #
#                                           |___/       |___/    #
#                                                                #
##################################################################

path="/run/media/omar/Storage/omar/Books"
choice=$(ls "$path" | dmenu -i -l 10)
new_choice=$choice

while [ -d "$path/$new_choice" ] 
do
  choice=$(ls "$path/$new_choice" | dmenu -l 10)
  new_choice+="/"
  new_choice+=$choice #path/books for cs/
  echo $new_choice
done

zathura --mode fullscreen "$path/$new_choice"



  




