get_auth=$(curl -i -X POST -H 'Content-Type: application/json-rpc' -d @auth.json http://192.168.56.60/api_jsonrpc.php | sed -n 's/.*result":"\(.*\)",.*/\1/p')
sed -i "s/my_key/$get_auth/g" ./script.json
curl -i -X POST -H 'Content-Type: application/json-rpc' -d @script.json http://192.168.56.60/api_jsonrpc.php
sed -i "s/$get_auth/my_key/g" ./script.json
