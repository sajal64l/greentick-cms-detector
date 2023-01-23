#!/bin/bash

echo -e "***********************************************************************************";
echo -e "			Welcome to GreenTick CMS Detector";
echo -e "***********************************************************************************";
echo -e "CMS Scanned are: ";
echo -e "	1. Wordpress";
echo -e "	2. Drupal";
echo -e "	3. Joomla";
echo -e "	4. Magento";
echo -e "	5. Opencart";
echo -e "	6. Laravel";
echo -e "***********************************************************************************\n";

#Passing flags to the variable
while getopts u: flag
do 
	case "${flag}" in
		u) url=${OPTARG};;
	esac
done

echo -e "***********************************************************************************";
echo -e "Installing the Required tools :";
echo -e "***********************************************************************************\n";
sh -c "sudo apt install whatweb";
echo -e "***********************************************************************************\n";


echo -e "***********************************************************************************";
echo -e "Scanning $url for Content Management System";
echo -e "***********************************************************************************\n";

sh -c "whatweb -v $url" > whatweb.txt;

cat whatweb.txt | grep -ho 'WordPress' | sort -u > wp.txt;
wp=$(cat wp.txt | wc -l);


cat whatweb.txt | grep -ho 'Drupal' | sort -u > dp.txt;
dp=$(cat dp.txt | wc -l);

cat whatweb.txt | grep -ho 'Joomla' | sort -u > jm.txt;
jm=$(cat jm.txt | wc -l);

cat whatweb.txt | grep -ho 'Magento' | sort -u > mg.txt;
mg=$(cat mg.txt | wc -l);

cat whatweb.txt | grep -ho 'OpenCart' | sort -u > oc.txt;
oc=$(cat oc.txt | wc -l);

cat whatweb.txt | grep -ho 'Laravel' | sort -u > lv.txt;
lv=$(cat lv.txt | wc -l);

cat whatweb.txt | grep -ho '403 Forbidden' | sort -u >waf.txt;
waf=$(cat waf.txt | wc -l);


if [[ $wp -eq 1 ]]
then
  echo -e "WordPress is installed on $url\n"
elif [[ $dp -eq 1 ]]
then
  echo -e "Drupal is installed on $url\n"
elif [[ $jm -eq 1 ]]
then
  echo -e "Joomla is installed on $url\n"
elif [[ $mg -eq 1 ]]
then
  echo  -e "Magento is installed on $url\n"
elif [[ $oc -eq 1 ]]
then
  echo  -e "OpenCart is installed on $url\n"
elif [[ $lv -eq 1 ]]
then
  echo -e "Laravel is installed on $url\n"
elif [[ $waf -eq 1 ]]
then
  echo -e "Sorry, Firewall is blocking our request on ${url}\n"
else
  echo -e "Sorry, CMS could not be detected on $url\n"
fi

rm -r oc.txt lv.txt wp.txt dp.txt jm.txt mg.txt waf.txt whatweb.txt;

echo -e "***********************************************************************************";
echo -e "			Thank You for Using Me";
echo -e "***********************************************************************************\n";

