while read line
  do
clientname=$(echo $line|cut -d= -f1)
distributionid=$(echo $line|cut -d= -f2)
bucketname=$(echo $line|cut -d= -f3)
echo $clientname $distributionid $bucketname
cd ../admin
VERSION=$(npm version patch  -m "auto verison tick [skip CI]")
VERSION=$(echo $VERSION | cut -c 2-)
echo $VERSION
aws s3 sync s3://m-test-files/admin/$VERSION s3://$bucketname.runsonm.com
grunt switch --target=$clientname
aws s3 cp app/scripts/target.js s3://$bucketname.runsonm.com/scripts/target.js
aws cloudfront create-invalidation --distribution-id $distributionid --paths /index.html

  done < props_admin.txt


while read line
  do
clientname=$(echo $line|cut -d= -f1)
distributionid=$(echo $line|cut -d= -f2)
echo $clientname $distributionid
cd ../web
VERSION=$(npm version patch  -m "auto verison tick [skip CI]")
VERSION=$(echo $VERSION | cut -c 2-)
echo $VERSION
aws s3 sync s3://m-test-files/admin/$VERSION s3://$bucketname.runsonm.com
grunt switch --target=$clientname
aws s3 cp app/scripts/target.js s3://$bucketname.runsonm.com/scripts/target.js
aws cloudfront create-invalidation --distribution-id $distributionid --paths /index.html

  done < props_web.txt
 grep -o '"id":[^,]*' l.txt | cut -d: -f2
