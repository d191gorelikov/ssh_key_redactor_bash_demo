mvkey() {

if [ -e published_pem.txt ]; then

mv published_pem.txt published.pem

echo "published_pem.txt переименован в published.pem"

else

echo "Файл published_pem.txt уже переименован"

fi



if [ -e chain_pem.txt ]; then

mv chain_pem.txt chain.pem

echo "chain_pem.txt переименован в chain.pem"

else

echo "Файл chain_pem.txt уже переименован"

fi



if [ -e root_pem.txt ]; then

mv root_pem.txt root.pem

echo "root_pem.txt переименован в root.pem"

else

echo "Файл chain_pem.txt уже переименован"

fi

}





base64file() {

if [ -e base ]; then

echo "Директория base уже существует"

else

mkdir base/

fi

if [ -e published.pem ]; then

cat published.pem | base64 | tr -d '\n' > base/published_b64.pem

echo "published.pem зашифрован"

fi

if [ -e chain.pem ]; then

cat chain.pem | base64 | tr -d '\n' > base/chain_b64.pem

echo "chain.pem зашифрован"

fi

if [ -e unencryptedServer.key ]; then

cat unencryptedServer.key | base64 | tr -d '\n' > base/unencryptedServer_b64.key

echo "unencryptedServer.key зашифрован"

fi

}







base64dec() {	

if [ -e base/published_b64.pem ]; then

cat base/published_b64.pem | base64 --decode | tr -d '\n' > base/published_decode.pem

echo "published.pem расшифрован"

fi

if [ -e base/chain_b64.pem ]; then

cat base/chain_b64.pem | base64 | tr -d '\n' > base/chain_decode.pem

echo "chain.pem расшифрован"

fi

if [ -e base/unencryptedServer_b64.key ]; then

cat base/unencryptedServer_b64.key | base64 --decode | tr -d '\n' > base/unencryptedServer_decode.key

echo "unencryptedServer.key расшифрован"

fi

}



options=("Генерация CSR из cfg и создание приватного ключа (файл cfg должен иметь название cfg" "Раcшифровка приватного ключа server.key в unencryptedServer.key(строго server.key)" "Перемеименование Published_pem.txt, chain_pem.txt в формат .pem"

"Перевод publish, chain,unencryptedServer в base64" "Расшифровка файлов из base64" "Выйти")

select num in "${options[@]}"

do

case $num in

"${options[0]}")

openssl req -out server.csr -newkey rsa:2048 -nodes -keyout server.key -config config.cfg

Echo "Server.csr и server.key созданы"

;;

"${options[1]}")

openssl rsa -in server.key -out unencryptedServer.key

echo "unencryptedServer.key создан"

;;

"${options[2]}")

mvkey

;;

"${options[3]}")

base64file

;;

"${options[4]}")

base64dec

;;

"${options[5]}")

exit

;;

*)

echo "Нет такого варианта"

;;



esac

done
