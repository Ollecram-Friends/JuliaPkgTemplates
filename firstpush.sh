#!/bin/bash

# This script is used to perform the 1st push of a newly generated 
# local package on an existing, empty GitHub repository

# ARGS[1] Name of the repository (also the name of the package)
# ARGS[2] Name of the GitHub owning account (either a user or an organization) 

# 1. Check that one argument was supplied
if [ $# -eq 0 ];
then echo "Error. One argument with the name of the Julia Pkg must be supplied" && exit 1;
elif [ $# -eq 1 ];
then echo "Error. Two arguments must be supplied: package name and account name" && exit 1;
elif [ $# -gt 2 ];
then echo "Error. Only two arguments must be supplied: package name and account name" && exit 1;
fi

# 2. Give input arguments explicit names
echo "First push requested for pkg $1 to the $2 account"

# 3. Check that JULIA_PKG_DEVDIR variable is defined
if [ -z ${JULIA_PKG_DEVDIR+x} ]; 
then echo "Error: JULIA_PKG_DEVDIR is unset" && exit 1;
else echo "JULIA_PKG_DEVDIR is set to '$JULIA_PKG_DEVDIR'";
fi

# 4. Check that JuliaPkgTemplates exists as a directory under JULIA_PKG_DEVDIR
if [ ! -d "$JULIA_PKG_DEVDIR/JuliaPkgTemplates" ]; 
then echo "Error: local clone of JuliaPkgTemplates not found under $JULIA_PKG_DEVDIR" && exit 1;
else echo "JuliaPkgTemplates local clone found under '$JULIA_PKG_DEVDIR'";
fi

# 5. Check that local copy of repository exists as a directory under JULIA_PKG_DEVDIR
if [ ! -d "$JULIA_PKG_DEVDIR/$1" ]; 
then echo "Error: local clone of $1 not found under $JULIA_PKG_DEVDIR" && exit 1;
else echo "$1 local clone found under '$JULIA_PKG_DEVDIR'";
fi

# 6. Change directory and test that remote origin URL has not been set yet! 
cd $JULIA_PKG_DEVDIR/$1
rou_before=$(cut -d "=" -f2 <<< $(git config --list | grep remote.origin.url))
if [ $rou_before=="git@github.com:$2/$1.git" ]
then echo -e "The repository remote origin is already set ($rou_before). \n\tNot the first push? Pls proceed manually." && exit 1;
fi

# 7. Set default branch name (`main`) and set origin URL
git branch -M main
git remote set-url origin git@github.com:$2/$1.git

rou=$(git config --list | grep remote.origin.url)
echo "SET $rou"

# 8. Push
git push -u origin main 
 
