rm -f curl.txt
curl --request POST \
--url 'https://us1.api.mailchimp.com/3.0/lists' \
--user 'anystring:api-key-us1' \
--header 'content-type: application/json' \
--data '{"name":"'$1'","contact":{"company":"Lime Labs","address1":"14 Santa Barbara Estate","city":"Santa Cruz","state":"GA","zip":"30308","country":"US"},"permission_reminder":"You are receiving this email because you signed up for updates about Freddies newest hats.","campaign_defaults":{"from_name":"Freddie","from_email":"freddie@freddiehats.com","subject":"","language":"en"},"email_type_option":true}' \
--include >>curl.txt

clientid="$(grep -o '"id":[^,]*' curl.txt | cut -d: -f2 | tr -d '"')"
echo $clientid
curl --request POST \
--url 'https://us1.api.mailchimp.com/3.0/lists/'$clientid'/merge-fields' \
--user 'anystring:api-key-us1' \
--header 'content-type: application/json' \
--data '{"name":"country", "type":"text","tag":"COUNTRY"}' \
--include

curl --request POST \
--url 'https://us1.api.mailchimp.com/3.0/lists/'$clientid'/merge-fields' \
--user 'anystring:api-key-us1' \
--header 'content-type: application/json' \
--data '{"name":"orders", "type":"number","tag":"ORDERS"}' \
--include

curl --request POST \
--url 'https://us1.api.mailchimp.com/3.0/lists/'$clientid'/merge-fields' \
--user 'anystring:apikey-us1' \
--header 'content-type: application/json' \
--data '{"name":"paid_in_full", "type":"radio", "options": { "choices": ["Yes", "No"]}, "tag": "PAIDINFULL"}' \
--include

curl --request POST \
--url 'https://us1.api.mailchimp.com/3.0/lists/'$clientid'/merge-fields' \
--user 'anystring:apiket-us1' \
--header 'content-type: application/json' \
--data '{"name":"gender", "type":"radio", "options": { "choices": ["Male", "Female"]}, "tag": "GENDER"}' \
--include
