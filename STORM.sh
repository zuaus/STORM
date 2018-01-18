 
token="454157611:AAG3GiwznqM6wFvJmYD9i8dTgUTSvJgQjik" 
function print_logo() {

 echo -e "\e[38;5;77m" 

echo -e "  "
echo -e "  "
echo -e "  "
echo -e "  "

echo -e "  \e[38;5;88m"

echo -e "
___________________________________________
 __   ___________   ___     _____     __  __
/  |  |___   ___|  / _ \   | ___ }   |  \/  |
\_ \      | |     | | | |  | |_) }   | |\/| |
 _) |     | |     | |_| |  |  _< \   | |  | |
|__/      |_|      \___/   |_|  \_\  |_|  |_|   
___________________________________________|
              BY @TAHAJ20 DEVSTORM
                 
"

echo -e " "

echo -e " "

echo -e " "

echo -e "
___________________________________________
  __   ___________   ___     _____     __  __
/  |  |___   ___|  / _ \   | ___ }   |  \/  |
\_ \      | |     | | | |  | |_) }   | |\/| |
 _) |     | |     | |_| |  |  _< \   | |  | |
|__/      |_|      \___/   |_|  \_\  |_|  |_|
___________________________________________|
              BY @TAHAJ20 DEVSTORM
               
"

echo -e " "

echo -e " "

echo -e " "

echo -e " "

}


if [ ! -f ./tg/tgcli ]; then

echo -e ""

echo -e " "

echo -e " "

echo -e "
___________________________________________
 __   ___________   ___     _____     __  __
/  |  |___   ___|  / _ \   | ___ }   |  \/  |
\_ \      | |     | | | |  | |_) }   | |\/| |
 _) |     | |     | |_| |  |  _< \   | |  | |
|__/      |_|      \___/   |_|  \_\  |_|  |_|
___________________________________________|
              BY @TAHAJ20 DEVSTORM
               
"

echo -e " "

echo -e "  "

echo -e " "

    echo " "

    echo "Run $0 install"

    exit 1

 fi

if [ ! $token ]; then

echo -e ""

echo -e ""

  echo -e "\e[31;1mToken Not found\e"

 exit 1

 fi



  print_logo

   echo -e ""

echo -e ""

echo -e " "

echo -e "  "

echo -e "  "

echo -e "
___________________________________________
 __   ___________   ___     _____     __  __
/  |  |___   ___|  / _ \   | ___ }   |  \/  |
\_ \      | |     | | | |  | |_) }   | |\/| |
 _) |     | |     | |_| |  |  _< \   | |  | |
|__/      |_|      \___/   |_|  \_\  |_|  |_|
___________________________________________|
              BY @TAHAJ20 DEVSTORM
               
"

echo -e "  "

echo -e "  "

echo -e "  "

echo -e ""

echo -e " "

echo -e " "


curl "https://api.telegram.org/bot"$token"/sendmessage" -F

./tg/tgcli -s ./bot/bot.lua $@ --bot=$token


