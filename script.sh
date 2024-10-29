read -p "Would you like to update packages: [Y]/[N]" response

if [["$response" == "y" || "$response" == "Y"]]; 
then 
sudo apt-get update
sudo apt-get upgrade
