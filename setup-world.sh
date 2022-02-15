read -p "Which port to set up on? " port
if [[ ! $port =~ ^[0-9]+$ ]] ; then
    echo "Port must be a number.."
    exit
fi
apt update && apt upgrade -y
apt-get -y install git git-lfs openjdk-17-jdk gradle
git-lfs install
mkdir /darkan
cd /darkan
git clone git@github.com:DarkanRS/world-server.git
git clone git@github.com:DarkanRS/cache.git
iptables -A INPUT -p tcp --dport $port -j ACCEPT
((port = port+1))
iptables -A INPUT -p tcp --dport $port -j ACCEPT
