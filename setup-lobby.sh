apt update && apt upgrade -y
apt-get -y install git git-lfs openjdk-17-jdk gradle
git-lfs install
mkdir /darkan
cd /darkan
mkdir lobby
cd lobby
git clone git@github.com:DarkanRS/lobby-server.git
git clone git@github.com:DarkanRS/core.git
git clone git@github.com:DarkanRS/cache.git
cd core && ./gradlew publishToMavenLocal
iptables -A INPUT -p tcp --dport 43594 -j ACCEPT
iptables -A INPUT -p tcp --dport 43595 -j ACCEPT
iptables -A INPUT -p tcp --dport 4040 -j ACCEPT
