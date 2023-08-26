sudo service postgresql stop
cd ../
sudo docker-compose up -d
cd homol
sleep 120
sudo docker-compose up -d --build --force-recreate
