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

# 5. Check that repository exists locally as a directory under JULIA_PKG_DEVDIR
if [ ! -d "$JULIA_PKG_DEVDIR/$1" ]; 
then echo "Error: repository $1 not found under $JULIA_PKG_DEVDIR" && exit 1;
else echo "Repository $1 found under '$JULIA_PKG_DEVDIR'";
fi

# 6a. Test that this script is being run against the local git repo for the 1st time 
cd $JULIA_PKG_DEVDIR/$1
if [ ! -f "BEFORE_1st_PUSH" ]; 
then echo -e "This script was likely ALREADY RUN against the git repo ($1). \n\tPls proceed manually." && exit 1;
fi

# 6b. Test that remote origin URL has not yet been set [gives false positives, temporarily commented out] 
#rou_before=$(cut -d "=" -f2 <<< $(git config --list | grep remote.origin.url))
#if [ $rou_before=="git@github.com:$2/$1.git" ]
#then echo -e "The repository remote origin is already set ($rou_before). \n\tNot the first push? Pls proceed manually." && exit 1;
#fi

# 7. Fix Documenter 'main vs master' issue by declaring the branch name explicitly in `deploydocs()` 
sed -i '/deploydocs(;/a \    devbranch="main",' docs/make.jl

# 8. Override .gitignore with the 'canonical' copy from JuliaPkgTemplates
cp ../JuliaPkgTemplates/.gitignore .

# 9. Delete the file `BEFORE_1st_PUSH` to avoid this script being run twice against the same repo
rm BEFORE_1st_PUSH

# 10. Add and commit changes made by this script
git add docs/make.jl
git add .gitignore
git add BEFORE_1st_PUSH
git commit -m "1st push / Fixed 'main vs master' issue in docs/make.jl"

# 11. Set default branch name (`main`) and set origin URL
git branch -M main
git remote set-url origin git@github.com:$2/$1.git

rou=$(git config --list | grep remote.origin.url)
echo "SET $rou"

# 12. Push
git push -u origin main 
 
