#!bin/bash

echo "Welcome to Pypi Upload Tester"
echo "Before we proceed, Kindly enter your Pypi Username and Password."
echo -n "Username: "
read name
echo -n "Password: "
read -s pass
echo " "
echo "Checking dependencies..."

if which python3 >/dev/null;
then
    echo "Python is installed. Skipping Python Installation..."
else
    echo "Installing Python..."
    sudo apt install python3 -y
fi

if which python-pip3 >/dev/null;
then
    echo "pip3 is installed. Skipping pip3 Installation..."
else
    echo "installing pip3"
    sudo apt install python3-pip -y
fi

pip3 install twine
python3 setup.py sdist
echo "Uploading to test pypi..."
twine upload --repository testpypi dist/* --username $name --password $pass
echo "Sucessfully added to test pypi. Please check it out and test them before uploading to pypi..."