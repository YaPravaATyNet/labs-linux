yum group install "Development Tools"
mkdir lab4
cp /mnt/share/bastet-0.43.tgz lab4/bastet-0.43.tgz
cd lab4 
tar zxvf bastet-0.43.tgz
cd bastet-0.43
yum install boost boost-thread boost-devel
yum install ncurses-devel
make

# изменяем  Makefile дописывая
# install:
#	cp -p $(PROGNAME) /usr/bin/

make install 
rpm -qa > task3.log
yum deplist gcc > task4_1.log
rpm -q --whatrequires libgcc > task4_2.log
mkdir localrepo
cp /mnt/share/checkinstall-1.6.2-3.el6.1.x86_64.rpm localrepo/checkinstall-1.6.2-3.el6.1.x86_64.rpm 
cd localrepo
createrepo ./
nano /etc/yum.repo.d/localrepo.repo 
# заполняем файл 
# [localrepo]
# name=localrepo
# mirrorlist=file://root/localrepo
# enabled=1
# gpgcheck=0

yum repolist enabled > task6.log
cd /etc
mkdir yum.repo.d.old
mv yum.repo.d/Centos-* yum.repo.d.old/
yum list available
yum install checkinstall
cd ~
cp /mnt/share/fortunes-ru_1.52-2_all.deb fortunes-ru_1.52-2_all.deb
yum install epel-release
yum install alien 
alien --to-rpm fortunes-ru_1.52-_all.deb
rpm -iv --force fortunes-ru_1.52-3_all.noarch.rpm
yumdownloader --source nano
rpm -iv nano-2.3.1-10.e17.src.rpm 
cd rpmbuild/SPECS
nano nano.spec 
# добавляем строчку
# ln -s "nano" "%{buildroot}/%{_bindir}/newnano"
yum install groff
rpmbuild -bb nano.spec 
yum localinstall RPMS/x86_64/nano-2.3.1-10.e17.rpm 