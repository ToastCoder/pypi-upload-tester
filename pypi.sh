#!bin/bash
# Author: Vigneshwar Ravichandar

check_python()
{
    if which python3 >/dev/null;
    then
        echo "Python3 is installed. Skipping Python Installation..."
    else
        echo "Installing Python3..."
        sudo apt install python3 -y
    fi
}

check_pip()
{
    if which python-pip3 >/dev/null;
    then
        echo "pip3 is installed. Skipping pip3 Installation..."
    else
        echo "installing pip3"
        sudo apt install python3-pip -y
    fi
}

create_dist()
{
    pip3 install twine
    python3 setup.py sdist
}

up_testpypi()
{
    $flag0 = 0
    while [ $flag0 -eq 0 ]
    do
        echo "TEST PYPI UPLOAD WIZARD"
        echo -n "Please check if your source code is bug-free before proceeding.Attempt to proceed(Y/N):  "
        read flag1
        if [[ $flag1 -eq "y" ] || [ $flag2 -eq "Y" ]]
        then
            echo "Uploading to test pypi..."
            twine upload --repository testpypi --username $1 --password $2 dist/*
            echo "Uploaded to test pypi."
            echo "Please verify the test pypi package before proceeding to actual pypi package upload."
            $flag0 = 1
        elif [[ $flag1 -eq "n" ] || [ $flag1 -eq "N" ]]
        then
            echo "Please verify the source code and try again."
        fi
    done
}

up_pypi()
{
    $flag0 = 0
    while [ $flag0 -eq 0 ]
    do
        echo "PYPI UPLOAD WIZARD"
        echo -n "Please check if your test-pypi package is bug-free before proceeding.Attempt to proceed(Y/N):  "
        read flag1
        if [[ $flag1 -eq "y" ] || [ $flag2 -eq "Y" ]]
        then
            echo "Uploading to pypi..."
            twine upload --username $1 --password $2 dist/*
            echo "Uploaded to pypi."
            $flag0 = 1
        elif [[ $flag1 -eq "n" ] || [ $flag1 -eq "N" ]]
        then
            echo "Please verify the test-pypi package and try again."
        fi
    done
}

echo " "
echo "PYPI Upload Tester"
echo " "
echo "Before we proceed, Kindly enter your Pypi Username and Password."
echo -n "Username: "
read name
echo -n "Password: "
read -s pass
echo " "
REQ_FILE = setup.py
if test -f "$REQ_FILE"
then
    echo "Checking dependencies and verifying their installation..."
    check_python
    check_pip
    create_dist
    up_testpypi $name $pass
    up_pypi $name $pass
else
    echo "Unable to find setup.py in the current directory."
    echo "Please move the script to the directory where setup.py exists."
fi