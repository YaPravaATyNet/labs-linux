sed -e 's/:x:/ has id /; s/:.*//; s/^/user /' /etc/passwd > work3.log
passwd -S root | awk '{print $3}' >> work3.log
cat /etc/group | awk -F : '{print $1}' | tr '\n' ',' | sed 's/.$/\n/' >> work3.log
echo Be careful! > /etc/skel/readme.txt
useradd -p $(openssl passwd -crypt 12345678) u1
groupadd g1
usermod -aG g1 u1 
id u1 >> work3.log
usermod -aG g1 alex  # just replace user to alex
grep '^g1:' /etc/group | awk -F : '{print $4}' >> work3.log 
usermod -s /usr/bin/mc u1
useradd -p $(openssl passwd -crypt 87654321) u2
mkdir /home/test13
cp work3.log /home/test13/work3-1.log
cp work3.log /home/test13/work3-2.log
chown u1:u2 /home/test13	#u1-own, u2-group
chown u1:u2 /home/test13/*
chmod 750 /home/test13
chmod 640 /home/test13/*
mkdir /home/test14
chown u1:u1 /home/test14
chmod +t /home/test14
cp /bin/nano /home/test14/nano
chown u1:u1 /home/test14/nano
chmod u+s /home/test14/nano
mkdir test15
echo Hello world > test15/seret_file
chmod 444 test15/secret_file
chmod 111 test15