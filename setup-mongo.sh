iptables -A INPUT -p tcp --dport 27017 -j ACCEPT
apt-get -y install gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
apt update && apt upgrade -y
apt install mongodb-org -y
apt update && apt upgrade -y
apt autoremove && apt clean
mkdir /data /data/db
systemctl enable mongod
service mongod start

echo "Admin password: (DO NOT use ampersands -> @)"
read mongo_admin_pwd

echo "User name will be set to admin and password to $mongo_admin_pwd."

mongo "admin" --eval "db.createUser({'user':'admin','pwd':'$mongo_admin_pwd','roles': ['userAdminAnyDatabase','readWriteAnyDatabase']})"

echo ' ' >> /etc/mongod.conf
echo 'security:' >> /etc/mongod.conf
echo '  authorization: enabled' >> /etc/mongod.conf
service mongod restart

echo "Darkan read/write user password: (DO NOT use ampersands -> @)"
read darkan_readWrite_pwd

mongo "darkan-server" -u "admin" -p --authenticationDatabase admin --eval "db.createCollection('darkan-server')"
mongo "darkan-server" -u "admin" -p --authenticationDatabase admin --eval "db.createUser({'user':'dkadmin','pwd':'$darkan_readWrite_pwd','roles':[{'role':'dbOwner','db':'darkan-server'},{'role':'readWrite','db':'darkan-server'}]})"

echo "Finished setup. You can use the following information for the world config:"
echo "mongoUrl: localhost"
echo "mongoPort: 27017"
echo "mongoUser: dkadmin"
echo "mongoPass: $darkan_readWrite_pwd"