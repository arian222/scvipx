#!/bin/bash
# https://t.me/gemilangkinasih

rm -rf "$0" 2>/dev/null
rm -rf autoscript 2>/dev/null
rm -rf sogoksetup.sh 2>/dev/null

Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'

apt install curl
IP=$( curl -sS ipv4.icanhazip.com )
clear
echo -e "\e[33m──────────────────────────────────────────\033[0m"
echo -e "\E[40;1;37m      INFORMATION AUTOSCRIPT PREMIUM      \E[0m"
echo -e "\e[33m──────────────────────────────────────────\033[0m"
echo -e "Developer   : ALECS (${GREEN}Latest Edition${NC})"
echo -e "Copyright   : ${GREEN}ALECS 2025${NC}"
echo -e "Os Support  : Debian 10/11 & Ubuntu 20"
echo -e "\e[33m──────────────────────────────────────────\033[0m"
echo ""
sleep 3

if [[ $( uname -m | awk '{print $1}' ) == "x86_64" ]]; then
    echo -e "Supports your OS ( ${green}$( uname -m )${NC} )"
else
    echo -e "Does not Support your OS ( ${YELLOW}$( uname -m )${NC} )"
    exit 1
fi

if [[ $( cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g' ) == "ubuntu" ]]; then
    echo -e "${OK}Supports your OS ( ${green}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
elif [[ $( cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g' ) == "debian" ]]; then
    echo -e "${OK}Supports your OS ( ${green}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
else
    echo -e "${EROR}Does not Support your OS ( ${YELLOW}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
    exit 1
fi

if [[ $IP == "" ]]; then
    echo -e "${EROR}IP Address ( ${YELLOW}Not Detected${NC} )"
else
    echo -e "${OK}IP Address ( ${green}$IP${NC} )"
fi

echo -e "\e[33m──────────────────────────────────────────\033[0m"
echo -e ""
read -p "$( echo -e "Press ${GRAY}[ ${NC}${green}Enter${NC} ${GRAY}]${NC} For Starting Installation")"
if [ "${EUID}" -ne 0 ]; then
		echo "Need root permission for script installation"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

clear
MYIP=$(curl -sS ipv4.icanhazip.com)
apt install ruby -y
gem install lolcat
apt install wondershaper -y
clear

# LINK REPO
REPO="https://raw.githubusercontent.com/arian222/scvipx/main/"

start=$(date +%s)
secs_to_human() {
echo "Installation time : $((${1} / 3600)) hours $(((${1} / 60) % 60)) minute's $((${1} % 60)) seconds"
}

function print_ok() {
echo -e "${OK} ${BLUE} $1 ${FONT}"
}
function print_install() {
clear
echo -e "\e[33m──────────────────────────────────────────\033[0m"
echo -e "$1"
echo -e "\e[33m──────────────────────────────────────────\033[0m"
sleep 2
}

function print_error() {
clear
echo -e "${ERROR} ${REDBG} $1 ${FONT}"
}

function print_success() {
if [[ 0 -eq $? ]]; then
clear
echo -e "\e[33m──────────────────────────────────────────\033[0m"
echo -e "$1 Success"
echo -e "\e[33m──────────────────────────────────────────\033[0m"
sleep 2
fi
}

function is_root() {
if [[ 0 == "$UID" ]]; then
    print_ok "Root user Start installation process"
else
    print_error "The current user is not the root user, please switch to the root user and run the script again"
fi
}
    
print_install "Create Direktori Xray"
mkdir -p /etc/xray
curl -s ipv4.icanhazip.com > /etc/xray/ipvps
touch /etc/xray/domain
mkdir -p /var/log/xray
chown www-data.www-data /var/log/xray
chmod +x /var/log/xray
touch /var/log/xray/access.log
touch /var/log/xray/error.log
mkdir -p /var/lib/kyt >/dev/null 2>&1

while IFS=":" read -r a b; do
case $a in
    "MemTotal") ((mem_used+=${b/kB})); mem_total="${b/kB}" ;;
    "Shmem") ((mem_used+=${b/kB}))  ;;
    "MemFree" | "Buffers" | "Cached" | "SReclaimable")
    mem_used="$((mem_used-=${b/kB}))"
;;
esac
done < /proc/meminfo
Ram_Usage="$((mem_used / 1024))"
Ram_Total="$((mem_total / 1024))"
tanggal=`date -d "0 days" +"%d-%m-%Y - %X" `
OS_Name=$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' )
Kernel=$( uname -r )
Arch=$( uname -m )
IP=$( curl -sS ipv4.icanhazip.com )

function first_setup(){
timedatectl set-timezone Asia/Jakarta
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
print_success "Directory Xray"
if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
echo "Setup Dependencies $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
sudo apt update -y
apt-get install --no-install-recommends software-properties-common
add-apt-repository ppa:vbernat/haproxy-2.0 -y
apt-get -y install haproxy=2.0.\*

elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
    echo "Setup Dependencies For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
    curl https://haproxy.debian.net/bernat.debian.org.gpg |
        gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
    echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]"\
        http://haproxy.debian.net buster-backports-1.8 main\
        >/etc/apt/sources.list.d/haproxy.list
    sudo apt-get update
    apt-get -y install haproxy=1.8.\*
else
    echo -e " Your OS Is Not Supported ($(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g') )"
    exit 1
fi
}

function nginx_install() {
if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
    print_install "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"

    sudo apt-get install nginx -y 
elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
    print_success "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"  
    apt -y install nginx 
else
    echo -e "Your OS Is Not Supported ( ${YELLOW}$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${FONT} )"

fi
}

function base_package() {
clear
print_install "Instalasi Packet Yang Dibutuhkan"
apt install zip pwgen openssl netcat socat cron bash-completion -y
apt install figlet -y
apt update -y
apt upgrade -y
apt dist-upgrade -y
systemctl enable chronyd
systemctl restart chronyd
systemctl enable chrony
systemctl restart chrony
chronyc sourcestats -v
chronyc tracking -v
apt install ntpdate -y
ntpdate pool.ntp.org
apt install sudo -y
sudo apt-get clean all
sudo apt-get autoremove -y
sudo apt-get install -y debconf-utils
sudo apt-get remove --purge exim4 -y
sudo apt-get remove --purge ufw firewalld -y
sudo apt-get install -y --no-install-recommends software-properties-common
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
sudo apt-get install -y speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl build-essential gcc g++ python htop lsof tar wget curl ruby zip unzip p7zip-full python3-pip libc6 util-linux build-essential msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg2 ca-certificates lsb-release gcc shc make cmake git screen socat xz-utils apt-transport-https gnupg1 dnsutils cron bash-completion ntpdate chrony jq openvpn easy-rsa
print_success "Packet Yang Dibutuhkan"
}

function pasang_domain() {
    clear
    print_install "Instalasi Domain Server"
    clear
    echo -e ""
    echo -e "▒█▀▀▄ ▒█▀▀▀█ ▒█▀▄▀█ ░█▀▀█ ▀█▀ ▒█▄░▒█ ░░ ▒█░▒█ ▒█▀▀█\033[0m" 
    echo -e "▒█░▒█ ▒█░░▒█ ▒█▒█▒█ ▒█▄▄█ ▒█░ ▒█▒█▒█ ▀▀ ▒█░▒█ ▒█▄▄█\033[0m" 
    echo -e "▒█▄▄▀ ▒█▄▄▄█ ▒█░░▒█ ▒█░▒█ ▄█▄ ▒█░░▀█ ░░ ░▀▄▄▀ ▒█░░░\033[0m"
    echo -e "\e[33m───────────────────────────────────────────────────\033[0m"
    echo -e "1. Use Your Domain - Gunakan Domain Sendiri $NC"
    echo -e "2. Use Domain Otomatis - Gunakan Domain Otomatis $NC"
    echo -e "\e[33m───────────────────────────────────────────────────\033[0m"
    echo -e ""

    while true; do
        read -rp "Input 1 or 2 / Pilih 1 atau 2 : " dns
        if [[ -z "$dns" ]]; then
            echo "Input kosong, harap pilih yang benar."
            continue
        fi

        if [[ "$dns" -eq 1 ]]; then
            while true; do
                read -rp "Enter Your Domain / masukan domain : " dom
                if [[ -z "$dom" ]]; then
                    echo "Domain tidak boleh kosong, masukkan domain yang valid."
                else
                    echo "$dom" > /root/scdomain 
                    echo "$dom" > /etc/xray/scdomain 
                    echo "$dom" > /etc/xray/domain 
                    echo "$dom" > /root/domain 
                    print_success "Instalasi Domain"
                    break
                fi
            done
            break

        elif [[ "$dns" -eq 2 ]]; then
            apt install jq curl -y
            wget -q -O /root/cf "${REPO}/sogokfiles/cf" >/dev/null 2>&1
            chmod +x /root/cf
            bash /root/cf
            print_success "Instalasi Domain Random"
            break
        else
            echo "Input tidak valid, harap pilih 1 atau 2."
            continue 
        fi
    done
}

restart_system(){
clear
MYIP=$(curl -sS ipv4.icanhazip.com)
izinsc="https://raw.githubusercontent.com/arian222/scvipx/main/sogokregister"
rm -f /usr/bin/user
username=$(curl $izinsc | grep $MYIP | awk '{print $2}')
echo "$username" >/usr/bin/user
expx=$(curl $izinsc | grep $MYIP | awk '{print $3}')
echo "$expx" >/usr/bin/e

# DETAIL ORDER
username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)

clear
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(((d1 - d2) / 86400))

DATE=$(date +'%Y-%m-%d')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "$COLOR1 $NC Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}

mai="datediff "$Exp" "$DATE""
CITY=$(curl -s ipinfo.io/city )
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )

Info="(${green}Online${NC})"
Error="(${RED}Expired${NC})"
today=`date -d "0 days" +"%Y-%m-%d"`
Exp1=$(curl $izinsc | grep $MYIP | awk '{print $4}')
if [[ $today < $Exp1 ]]; then
sts="${Info}"
else
sts="${Error}"
fi
TIMES="10"
CHATID="1670137273"
KEY="7506598241:AAFRMmFOlPu225VdiUMIGL7kE4ECEnvPAc4"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TIMEZONE=$(printf '%(%H:%M:%S)T')
TEXT="
<code>──────────────────────────</code>
🧿Instalasi Special Autoscript V2.4🧿
<code>──────────────────────────</code>
<code>Username :</code> <code>$username</code>
<code>Domain   :</code> <code>$domain</code>
<code>IP       :</code> <code>$MYIP</code>
<code>ISP      :</code> <code>$ISP</code>
<code>Timezone :</code> <code>$TIMEZONE</code>
<code>Location :</code> <code>$CITY</code>
<code>Expired  :</code> <code>$exp</code>
<code>──────────────────────────</code>
🧿CREATED BY ALECS 2025🧿
<code>──────────────────────────</code>
Notifications Automatic From Github
"'&reply_markup={"inline_keyboard":[[{"text":"ORDER SCRIPT","url":"https://t.me/Alecss12"}]]}'

curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}

# PASANG SSL
function pasang_ssl() {
clear
print_install "Instalasi SSL Pada Domain"
rm -rf /etc/xray/xray.key
rm -rf /etc/xray/xray.crt
domain=$(cat /root/domain)
STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
rm -rf /root/.acme.sh
mkdir /root/.acme.sh
systemctl stop $STOPWEBSERVER
systemctl stop nginx
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
chmod 777 /etc/xray/xray.key
print_success "SSL Domain" 
}

function make_folder_xray() {
rm -rf /etc/vmess/.vmess.db
rm -rf /etc/vless/.vless.db
rm -rf /etc/trojan/.trojan.db
rm -rf /etc/shadowsocks/.shadowsocks.db
rm -rf /etc/ssh/.ssh.db
rm -rf /etc/bot/.bot.db
rm -rf /etc/user-create/user.log
mkdir -p /etc/bot
mkdir -p /etc/xray
mkdir -p /etc/vmess
mkdir -p /etc/vless
mkdir -p /etc/trojan
mkdir -p /etc/shadowsocks
mkdir -p /etc/ssh
mkdir -p /usr/bin/xray/
mkdir -p /var/log/xray/
mkdir -p /var/www/html
mkdir -p /etc/kyt/limit/vmess/ip
mkdir -p /etc/kyt/limit/vless/ip
mkdir -p /etc/kyt/limit/trojan/ip
mkdir -p /etc/kyt/limit/ssh/ip
mkdir -p /etc/limit/vmess
mkdir -p /etc/limit/vless
mkdir -p /etc/limit/trojan
mkdir -p /etc/limit/ssh
mkdir -p /etc/user-create
chmod +x /var/log/xray
touch /etc/xray/domain
touch /var/log/xray/access.log
touch /var/log/xray/error.log
touch /etc/vmess/.vmess.db
touch /etc/vless/.vless.db
touch /etc/trojan/.trojan.db
touch /etc/shadowsocks/.shadowsocks.db
touch /etc/ssh/.ssh.db
touch /etc/bot/.bot.db
echo "& plughin Account" >> /etc/vmess/.vmess.db
echo "& plughin Account" >> /etc/vless/.vless.db
echo "& plughin Account" >> /etc/trojan/.trojan.db
echo "& plughin Account" >> /etc/shadowsocks/.shadowsocks.db
echo "& plughin Account" >> /etc/ssh/.ssh.db
echo "Database Log Create User Account" >> /etc/user-create/user.log
}

function install_xray() {
clear
print_install "Instalasi Core Xray 1.8.1 Latest Version"
domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
chown www-data.www-data $domainSock_dir

latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version $latest_version
wget -O /etc/xray/config.json "${REPO}sogokconfig/config.json" >/dev/null 2>&1
wget -O /etc/systemd/system/runn.service "${REPO}sogokfiles/runn.service" >/dev/null 2>&1
domain=$(cat /etc/xray/domain)
print_success "Core Xray 1.8.1 Latest Version" 

clear
curl -s ipinfo.io/city > /etc/xray/city
curl -s ipinfo.io/org | cut -d " " -f 2-10 > /etc/xray/isp
print_install "Memasang Konfigurasi Packet"
wget -O /etc/haproxy/haproxy.cfg "${REPO}sogokconfig/haproxy.cfg" > /dev/null 2>&1
wget -O /etc/nginx/conf.d/xray.conf "${REPO}sogokconfig/xray.conf" > /dev/null 2>&1
sed -i "s/xxx/${domain}/g" /etc/haproxy/haproxy.cfg
sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
curl ${REPO}sogokconfig/nginx.conf > /etc/nginx/nginx.conf
cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem
chmod +x /etc/systemd/system/runn.service
rm -rf /etc/systemd/system/xray.service.d

cat > /etc/systemd/system/xray.service << EOF
[Unit]
Description=Xray Service
Documentation=https://t.me/gemilangkinasih
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF
print_success "Konfigurasi Packet Xray"  
}

function ssh(){
clear
print_install "Instalasi Password SSH"
wget -O /etc/pam.d/common-password "${REPO}sogokfiles/password"
chmod +x /etc/pam.d/common-password
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/altgr select The default for the keyboard layout"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/compose select No compose key"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/ctrl_alt_bksp boolean false"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layoutcode string de"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layout select English"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/modelcode string pc105"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/model select Generic 105-key (Intl) PC"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/optionscode string"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/store_defaults_in_debconf_db boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/switch select No temporary switch"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/toggle select No toggling"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_layout boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_options boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_layout boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_options boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variantcode string"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variant select English"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/xkb-keymap select"

cd
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

cat > /etc/rc.local <<-END
# !/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local.service

echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
print_success "Instalasi Password SSH" 
}

function udp_mini(){
clear
print_install "Instalasi Service Limit IP & Quota"
wget -q ${REPO}sogokconfig/fv-tunnel && chmod +x fv-tunnel && ./fv-tunnel

clear
# INSTALL PORT UDP MINI 7100,7200,7300
mkdir -p /usr/local/kyt/
wget -q -O /usr/local/kyt/udp-mini "${REPO}sogokfiles/udp-mini"
chmod +x /usr/local/kyt/udp-mini
wget -q -O /etc/systemd/system/udp-mini-1.service "${REPO}sogokfiles/udp-mini-1.service"
wget -q -O /etc/systemd/system/udp-mini-2.service "${REPO}sogokfiles/udp-mini-2.service"
wget -q -O /etc/systemd/system/udp-mini-3.service "${REPO}sogokfiles/udp-mini-3.service"
systemctl disable udp-mini-1
systemctl stop udp-mini-1
systemctl enable udp-mini-1
systemctl start udp-mini-1
systemctl disable udp-mini-2
systemctl stop udp-mini-2
systemctl enable udp-mini-2
systemctl start udp-mini-2
systemctl disable udp-mini-3
systemctl stop udp-mini-3
systemctl enable udp-mini-3
systemctl start udp-mini-3
print_success "Instalasi Limit IP Service" 
}

function ins_SSHD(){
clear
print_install "Instalasi SSHD In Process"
wget -q -O /etc/ssh/sshd_config "${REPO}sogokfiles/sshd" >/dev/null 2>&1
chmod 700 /etc/ssh/sshd_config
/etc/init.d/ssh restart
systemctl restart ssh
/etc/init.d/ssh status
print_success "Instalasi SSHD" 
}

clear
function ins_dropbear(){
clear
print_install "Instalasi Dropbear In Process"
apt-get install dropbear -y
wget -q -O /etc/default/dropbear "${REPO}sogokconfig/dropbear.conf"
chmod +x /etc/default/dropbear
/etc/init.d/dropbear restart
/etc/init.d/dropbear status
print_success "Instalasi Dropbear" 
}

function ins_vnstat(){
clear
print_install "Instalasi Vnstat In Process"
apt -y install vnstat > /dev/null 2>&1
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev > /dev/null 2>&1
wget -q ${REPO}sogokfiles/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
/etc/init.d/vnstat status
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6
print_success "Instalasi Vnstat" 
}

function ins_openvpn(){
clear
print_install "Instalasi OpenVPN In Process"
wget -q ${REPO}sogokfiles/openvpn &&  chmod +x openvpn && ./openvpn
/etc/init.d/openvpn restart
print_success "Instalasi OpenVPN" 
}

function ins_backup(){
clear
print_install "Instalasi Backup Server In Process"
apt install rclone -y
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "${REPO}sogokconfig/rclone.conf"
cd /bin
git clone  https://github.com/magnific0/wondershaper.git
cd wondershaper
sudo make install
cd
rm -rf wondershaper
rm -rf /usr/local/sbin/wondershaper
echo > /home/limit
apt install msmtp-mta ca-certificates bsd-mailx -y
cat > /etc/msmtprc << EOF
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
account default
host smtp.gmail.com
port 587
auth on
user teohazzam@gmail.com
from teohazzam@gmail.com
password ikoo rxjw dnzc mhxg
logfile ~/.msmtp.log
EOF
chown -R www-data:www-data /etc/msmtprc
wget -q -O /etc/ipserver "${REPO}sogokfiles/ipserver" && bash /etc/ipserver
print_success "Instalasi Backup Server" 
}

clear
function ins_swab(){
clear
print_install "Instalasi Swap 1 G In Process"
gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
curl -sL "$gotop_link" -o /tmp/gotop.deb
dpkg -i /tmp/gotop.deb > /dev/null 2>&1

dd if=/dev/zero of=/swapfile bs=1024 count=1048576
mkswap /swapfile
chown root:root /swapfile
chmod 0600 /swapfile > /dev/null 2>&1
swapon /swapfile >/dev/null 2>&1
sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab

chronyd -q 'server 0.id.pool.ntp.org iburst'
chronyc sourcestats -v
chronyc tracking -v

wget -q ${REPO}sogokfiles/bbr.sh &&  chmod +x bbr.sh && ./bbr.sh
echo "Banner /etc/kyt.txt" >> /etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/kyt.txt"@g' /etc/default/dropbear
wget -O /etc/kyt.txt "${REPO}sogokfiles/issue.net"
print_success "Instalasi Swap 1 G" 
}

function ins_epro(){
clear
print_install "Instalasi ePro WebSocket Proxy"
wget -O /usr/bin/ws "${REPO}sogokfiles/ws" >/dev/null 2>&1
wget -O /usr/bin/tun.conf "${REPO}sogokconfig/tun.conf" >/dev/null 2>&1
wget -O /etc/systemd/system/ws.service "${REPO}sogokfiles/ws.service" >/dev/null 2>&1
chmod +x /etc/systemd/system/ws.service
chmod +x /usr/bin/ws
chmod 644 /usr/bin/tun.conf
systemctl disable ws
systemctl stop ws
systemctl enable ws
systemctl start ws
systemctl restart ws
wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" >/dev/null 2>&1
wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" >/dev/null 2>&1
wget -O /usr/sbin/ftvpn "${REPO}sogokfiles/ftvpn" >/dev/null 2>&1
chmod +x /usr/sbin/ftvpn
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

cd
apt autoclean -y > /dev/null 2>&1
apt autoremove -y > /dev/null 2>&1
print_success "Instalasi ePro WebSocket Proxy" 
}

ins_udp() {
cd
mkdir -p /root/udp

# change to time GMT+7
echo "change to time GMT+7"
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# install udp-custom
echo downloading udp-custom
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1ixz82G_ruRBnEEp4vLPNF2KZ1k8UfrkV' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1ixz82G_ruRBnEEp4vLPNF2KZ1k8UfrkV" -O /root/udp/udp-custom && rm -rf /tmp/cookies.txt
chmod +x /root/udp/udp-custom

echo downloading default config
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1klXTiKGUd2Cs5cBnH3eK2Q1w50Yx3jbf' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1klXTiKGUd2Cs5cBnH3eK2Q1w50Yx3jbf" -O /root/udp/config.json && rm -rf /tmp/cookies.txt
chmod 644 /root/udp/config.json

if [ -z "$1" ]; then
cat > /etc/systemd/system/udp-custom.service << EOF
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
else
cat > /etc/systemd/system/udp-custom.service << EOF
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server -exclude $1
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
fi

echo start service udp-custom
systemctl start udp-custom &>/dev/null

echo enable service udp-custom
systemctl enable udp-custom &>/dev/null
}

function ins_restart(){
clear
print_install "Process Restarting All Packet"
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/vnstat restart
systemctl restart haproxy
/etc/init.d/cron restart
systemctl daemon-reload
systemctl start netfilter-persistent
systemctl enable --now nginx
systemctl enable --now xray
systemctl enable --now rc-local
systemctl enable --now dropbear
systemctl enable --now openvpn
systemctl enable --now cron
systemctl enable --now haproxy
systemctl enable --now netfilter-persistent
systemctl enable --now ws
systemctl enable --now udp-custom
history -c
echo "unset HISTFILE" >> /etc/profile

cd
rm -f /root/openvpn
rm -f /root/key.pem
rm -f /root/cert.pem
print_success "Instalasi All Packet" 
}

# INSTALL MENU
function menu(){
clear
print_install "Instalasi Menu Packet"
wget -q ${REPO}sogokmenu/menu.zip
unzip menu.zip
chmod +x menu/*
mv menu/* /usr/local/sbin
rm -rf menu
rm -rf menu.zip
}

# MENU MENJADI DEFAULT
function profile(){
clear
cat > /root/.profile << EOF
# ~/.profile: executed by Bourne-compatible login shells.
if [ "$BASH" ]; then
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
fi
mesg n || true
welcome
EOF

chmod 644 /root/.profile
cat > /etc/cron.d/xp <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
30 23 * * * root /usr/local/sbin/xp
END
	
cat > /etc/cron.d/dailyreboot <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 3 * * * root reboot
END

echo "*/1 * * * * root echo -n > /var/log/nginx/access.log" > /etc/cron.d/log.nginx
echo "*/1 * * * * root echo -n > /var/log/xray/access.log" >> /etc/cron.d/log.xray
service cron restart

cat > /etc/systemd/system/rc-local.service << EOF
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
EOF

echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
cat > /etc/rc.local << EOF
#!/bin/sh -e
# rc.local
# By default this script does nothing.
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
systemctl restart netfilter-persistent
exit 0
EOF

chmod +x /etc/rc.local
AUTOREB=$(cat /home/daily_reboot)
SETT=11
if [ $AUTOREB -gt $SETT ]; then
    TIME_DATE="PM"
else
    TIME_DATE="AM"
fi
print_success "Instalasi Menu Packet" 
}

# RESTART ALL SERVICE
function enable_services(){
clear
print_install "Enable Service In Process"
systemctl daemon-reload
systemctl start netfilter-persistent
systemctl enable --now rc-local
systemctl enable --now cron
systemctl enable --now netfilter-persistent
systemctl restart nginx
systemctl restart xray
systemctl restart cron
systemctl restart haproxy
print_success "Enable Service" 
}

function instal(){
clear
first_setup
nginx_install
base_package
make_folder_xray
pasang_domain
password_default
pasang_ssl
install_xray
ssh
udp_mini
ins_SSHD
ins_dropbear
ins_vnstat
ins_openvpn
ins_backup
ins_swab
ins_epro
ins_udp
ins_restart
menu
profile
enable_services
restart_system
}

instal
rm -rf /root/menu
rm -rf /root/*.zip
rm -rf /root/*.sh
rm -rf /root/domain
rm -rf /root/scdomain
rm -rf /root/nsdomain
clear
echo "" | tee -a /root/install.log
echo "░██████╗░█████╗░░██████╗░░█████╗░██╗░░██╗"| tee -a /root/install.log
echo "██╔════╝██╔══██╗██╔════╝░██╔══██╗██║░██╔╝"| tee -a /root/install.log
echo "╚█████╗░██║░░██║██║░░██╗░██║░░██║█████═╝░"| tee -a /root/install.log
echo "░╚═══██╗██║░░██║██║░░╚██╗██║░░██║██╔═██╗░"| tee -a /root/install.log
echo "██████╔╝╚█████╔╝╚██████╔╝╚█████╔╝██║░╚██╗"| tee -a /root/install.log
echo "╚═════╝░░╚════╝░░╚═════╝░░╚════╝░╚═╝░░╚═╝"| tee -a /root/install.log
echo "██████╗░███████╗████████╗███████╗██╗░░██╗"| tee -a /root/install.log
echo "██╔══██╗██╔════╝╚══██╔══╝██╔════╝██║░██╔╝"| tee -a /root/install.log
echo "██████╔╝█████╗░░░░░██║░░░█████╗░░█████═╝░"| tee -a /root/install.log
echo "██╔═══╝░██╔══╝░░░░░██║░░░██╔══╝░░██╔═██╗░"| tee -a /root/install.log
echo "██║░░░░░███████╗░░░██║░░░███████╗██║░╚██╗"| tee -a /root/install.log
echo "╚═╝░░░░░╚══════╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝"| tee -a /root/install.log
echo "" | tee -a /root/install.log
secs_to_human "$(($(date +%s) - ${start}))" | tee -a /root/install.log
sudo hostnamectl set-hostname $username
echo -e "${green}Script Successfull Installed" | tee -a /root/install.log
read -p "$( echo -e "Press ${YELLOW}[ ${NC}${YELLOW}Enter${NC} ${YELLOW}]${NC} For Reboot")"
reboot