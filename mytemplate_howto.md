# Julia Pkg Templates - How To

This file is hosted within the GitHub repository [JuliaPkgTemplates](https://github.com/Ollecram-Friends/JuliaPkgTemplates). 

In this repository you find Julia reusable [code](mytemplate.jl) showing how to exploit functionality implemented by the [PkgTemplates.jl](https://github.com/invenia/PkgTemplates.jl) Julia project. Documentation of the latter is found [there](https://invenia.github.io/PkgTemplates.jl/stable/). 

Code in this repository ***is NOT a Julia package***, but rather a ***precursor*** for building new Julia packages with a similar structure in a ***repeatable way***.

## Preliminaries

I assume that  
1. You have a GitHub account configured for **SSH**
2. You have set the variables `github.user`, `user.name` and `user.email` in your GitHub configuration, as you can verify by `git config --list`  
3. You have setup your shell so that the **JAVA_PKG_DEVDIR** variable holds the path to all the local Git clones
4. You have Julia 1.5.0 or a later version (only because I have made no test with older versions)
5. You have added the `PkgTemplates` Julia package to your Julia environment
6. You have created and saved **SSH keys** for use within the CI workflows (see below about how this can be done)

### How to create SSH Keys
The proper working of **Documenter** workflows requires to upload SSH keys to GitHub. 
This is accomplished in a few steps, namely

1. Run the script `ssh_keygen.sh` with a single argument (a name, e.g. `DOCUMENTER`) to generate the public and private SSH keys: 
    - `./ssh_keygen.sh DOCUMENTER`
    
    ***It is critical that all the 4 generated files be SAVED IN A SAFE PLACE*** because we intend to use the same key
    for building documentation across all projects. In the proposed GitHub setup this requires to store the ***public key*** (as a *DEPLOY key*) with each new Julia project, while the ***private key*** will be stored once, at the organization level. When all repositories with this DEPLOY key are deleted, ***the public key would be lost***, unless saved elsewhere. The risk of loosing the private key is lower, but still possible, whence it is critical that both be saved (note that GitHub requires the base64 representation of the private key). 

    Note also that the `ssh_keygen.sh` saves the generated keys under the `temp` subfolder of the [JuliaPkgTemplates](https://github.com/Ollecram-Friends/JuliaPkgTemplates) project. As per the `.gitignore` the content of that subfolder ***is NOT pushed to the remote origin*** for obvious reasons  (that being a *public* repo). Therefore, ***content generated in that folder MUST BE COPIED and KEPT ELSEWHERE***.

### Deploy the Documenter private KEY as an organization Secret

Store the ***private key***, i.e. the content of the generated file `DOCUMENTER_SSH_KEY.base64` as a ***SECRET*** 
    - At the ***organization level*** open `Settings/Secrets` and click `New organization secret`
    - Type `DOCUMENTER_KEY` in the secret's **Name** field
    - Paste the key string in the secret's **Value** field
    - Type `Selected repositories` on `Repository access`
    
    The list of repositories that can possibly be given access to this secret can be modified at any time by clicking the `Update` button within the secret's display box. This is something we will do each time we create the repository for a new Julia package at the organization level. 

## PHASE 1 - Create the new package locally
1. Open the shell and execute the following commands to ***clone this project***
    - `cd $JAVA_PKG_DEVDIR`
    - `git clone git@github.com:Ollecram-Friends/JuliaPkgTemplates.git`
    - `cd $JAVA_PKG_DEVDIR/JavaPkgTemplates`
Now you may proceed with the ***cautious way*** or, alternatively, you may try the ***confident way***, as defined below.

### The *CAUTIOUS* way

2. In the shell, execute the following commands to ***start the Julia REPL***
    - `julia`
3. In the Julia REPL run the following commands, where `MyJuliaPkg` in the last one stands for the name of the new package
    - `include("mytemplate.jl")`
    - `t=template()`
    - `t("MyJuliaPkg")`
4. Quit the Julia REPL
    - `CTRL+D`

### The *CONFIDENT* way

***A quicker alternative to the cautious way*** is to run the following *bash* script just after step 1:
- `./mytemplate.sh MyJuliaPkg`

### PHASE 1 Important Note
The argument to `mytemplate.sh` (and to the `PkgTemplates` generating function) is the **name** of the Julia ***package***, not necessarily being the same as the **name** of the GitHub ***repository***. Therefore ***YOU MUST PROVIDE the package name WITHOUT the .jl SUFFIX!***.

## PHASE 2 - Setup an empty GitHub repository for the new package
As per the preceding note, create a new empty GitHub repository ***with the .jl suffix*** in the name. This will make you compliant with the current Julia guidelines for a repository to hold a Julia ***package***. 

### 2A - Create the GitHub repository
1. On GitHub ***create a new empty repository*** with the name `MyJuliaPkg.jl`
    - With your account, use the GitHub Web UI to create the Git repository
    - You can create it at the ***user*** or at the ***organization*** level 
    - No initial content is needed, not even the README and .gitignore
    - In the following I assume the repo to support collaborative package development, therefore
        - ***create it at the organization level*** 
        - ***make it private***

### 2B - Set the Documenter public SSH Key 

2. Upload the ***public key***, i.e. the content of the generated file `DOCUMENTER_SSH_KEY.pub` as a DEPLOY KEY
    - Access the newly created repository web page at `Settings/Deploy Keys` and insert the public key string in the `Key` field 
    - Make sure that the `Allow write access` box is checked.

### 2C - Enable the newly created repo to access the DOCUMENTER_KEY Secret 
3. Enable the newly created repo to access the DOCUMENTER_KEY Secret   
    - Access the ***organization*** web page at `Settings/Secrets/Actions Secrets`
    - Click `Update` on the `DOCUMENTER_KEY` secret
    - Update the selection of organization repositories that may use this secret
    - Click `Update selection`  

## PHASE 3 - Apply fixes and improvements, then push the local repository

**Note** that ***the name of the newly created GitHub repository is assumed to include the*** `.jl` ***suffix***, although the suffix ***must be omitted*** in the following commands/scripts which take ***package name*** (without `.jl`) as an argument.  

Here I recommend that you adopt the *CONFIDENT WAY* as described in the following section.

### The *CONFIDENT* way

By running the following command you are protected against inadvertent mistakes because the *bash* script ***performs several checks to avoid being run against the wrong repository***. Besides, the script ***overcomes some shortcomings*** of the generated package code (it fixes a known Documenter issue, plus it adds the Blue style badger to the README.md file). For this, just type:
- `./firstpush.sh MyJuliaPkg MyGitHubAccount`

where `MyGitHubAccount` stands for 
- your ***GitHub organization account***, if you created the repo at the ***organization level***
- your ***GitHub user account***, if you created the repo at the ***user level*** 

### The *CAUTIOUS* way
Alternatively, you may proceed with the ***cautious way***, as defined below, which makes sense if you are not interested in the above mentioned code fixes and improvements, likely because you need to investigate possible Git issues.

For this, just issue Git commands to ***set the remote origin and push***
    - Copy the SSH url of the created repository to the clipboard
    - `cd $JAVA_PKG_DEVDIR/MyJuliaPkg`
    - `git remote set-url origin <SSH REPOSITORY URL from the CLIPBOARD>`
    - `git branch -M main`
    - `git push -u origin main`

### PHASE 3 Important Note
At the end of this step you should have a ***mismatch*** between the ***name of the GitHub repository*** (the *remote origin*) and the ***name of the folder*** holding the locally generated content: the former with the `.jl` suffix and the former without. In order to avoid confusion, ***it is recommended at this stage to delete the local (initial) content (`rm -rf MyJuliaPack`) and to get a new clone from GitHub***. 

## PHASE 4 - Develop the package (before registration)

It is certainly sensible to postpone putting a package in the official Julia registry at a point in time when the code has reached a certain maturity level. Meanwhile, the code being developed can be tested together with all other packages in the Julia ecosystem: the way to do that is to leverage the `dev` option with the Julia package management tool `Pkg`.  

That is, instead of `add MyJuliaPkg` (which would only work after the package will be registered) we run `dev MyJuliaPkg`.
To learn more about this way of proceeding, look the package manager documentation at [Pkg.jl](https://julialang.github.io/Pkg.jl/). 

