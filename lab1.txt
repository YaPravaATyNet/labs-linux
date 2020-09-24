mkdir ~/test
cd ~/test
ls -la /etc > list
find /etc -maxdepth 1 -type d | wc -l >> list
find /etc -maxdepth 1 -name '.*' -type f | wc -l >> list
mkdir links
ln list links/list_hlink
ln -s ~/test/list ~/test/links/list_slink
echo 'list: '
find . -samefile list | wc -l
echo 'list_hlink: '
find . -samefile links/list_hlink | wc -l
echo 'list_slink: '
find . -samefile links/list_slink | wc -l
cat list | wc -l >> links/list_hlink
cmp -s links/list_hlink links/list_slink && echo 'hlink==slink: YES'
mv list list1
cmp -s links/list_hlinks links/list_slink && echo 'hlink==slink after renaming: YES'
cd ~
ln test/list1 list_link
find /etc -name '*.conf' -type f > list_conf
find /etc -name '*.d' -type d > list_d
cat list_conf > list_conf_d
cat list_d >> list_conf_d
mkdir test/.sub
cp list_conf_d test/.sub/
cp --backup=t list_conf_d test/.sub/
ls -aR test
man man > man.txt
split -b 1K man.txt man_
mkdir man.dir
mv man_* man.dir/
cat man.dir/man_* > man.dir/man.txt
cmp -s man.txt man.dir/man.txt && echo 'man.txt==man.dir/man.txt: YES'
sed -i '1 s/^/HAHAHA\n/' man.txt
echo MEOW-MEOW >> man.txt
diff man.dir/man.txt man.txt > patch.patch
mv patch.patch man.dir/
patch man.dir/man.txt man.dir/patch.patch
cmp -s man.txt man.dir/man.txt && echo 'man.txt==man.dir/man.txt after updating: YES'

