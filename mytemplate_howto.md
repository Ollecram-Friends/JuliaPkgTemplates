# Julia Pkg Templates - How To

This file is hosted within the GitHub repository [JuliaPkgTemplates](https://github.com/Ollecram-Friends/JuliaPkgTemplates). 

In this repository you find Julia reusable [code](mytemplate.jl) showing how to exploit functionality implemented by the [PkgTemplates.jl](https://github.com/invenia/PkgTemplates.jl) Julia project. Documentation of the latter is found [there](https://invenia.github.io/PkgTemplates.jl/stable/). 

Code in this repository ***is NOT a Julia package***, but rather a ***precursor*** for building new Julia packages with a similar structure in a ***repeatable way***.

## Assumptions

I assume that  
1. You have a GitHub account configured for **SSH**
2. You have set the variables `github.user`, `user.name` and `user.email` in your GitHub configuration, as you can verify by `git config --list`  
3. You have setup your shell so that the **JAVA_PKG_DEVDIR** variable holds the path to all the local Git clones
4. You have Julia 1.5.0 or a later version (only because I have made no test with older versions)
5. You have added the `PkgTemplates` Julia package to your Julia environment

## PHASE 1 - Create the new package locally
1. Open the shell and execute the following commands to ***clone this project***
    - `cd $JAVA_PKG_DEVDIR`
    - `git clone git@github.com:Ollecram-Friends/JuliaPkgTemplates.git`
    - `cd $JAVA_PKG_DEVDIR/JavaPkgTemplates`
Now you may proceed with the ***cautious way***.  Alternatively, you may try the ***confident way***, as defined below.

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

A ***quicker alternative to the cautious way*** is to run the following *bash* script just after step 1:
- `./mytemplate.sh MyJuliaPkg`

## PHASE 2 - Create GitHub repository and fill it with local content

1. On GitHub ***create a new empty repository with the same name***
    - With your account, use the GitHub Web UI to create the Git repository
    - You can create it at the ***user*** or at the ***organization*** level 
    - No initial content is needed, not even the README and .gitignore
    - If the repo is meant to serve for initial package development
        - ***make it private***
        - ***create it at the organization level***  

Now you may proceed with the ***cautious way***.  Alternatively, you may try the ***confident way***, as defined below.

### The *CAUTIOUS* way

2. Issue Git commands to ***set the remote origin and push***
    - Copy the SSH url of the created repository to the clipboard
    - `cd $JAVA_PKG_DEVDIR/MyJuliaPkg`
    - `git remote set-url origin <SSH REPOSITORY URL from the CLIPBOARD>`
    - `git branch -M main`
    - `git push -u origin main`

### The *CONFIDENT* way

A ***quicker alternative to the cautious way*** is to run the following *bash* script just after step 1. The script  is **safer**, because it ***performs several checks to avoid being run against the wrong repository***:
- `./firstpush.sh MyJuliaPkg MyGitHubAccount`

## PHASE 3 - Create and upload SSH Keys

The proper working of **Documenter** workflows require to upload an SSH key to GitHub. 
This is accomplished in a few steps, namely

1. Run the script `ssh_keygen.sh` with a single argument (a name) to generate the public and private keys 
    - ./ssh_keygen.sh DOCUMENTER
2. Upload the ***public key***, i.e. the content of the generated file `DOCUMENTER_SSH_KEY.pub` as a DEPLOY KEY
    - Access each repository whose workflows must be able to authorize with GitHub through the SSH key  
    - Open the repository web page at `Settings/Deploy Keys` and insert the public key string in the `Key` field 
    - Make sure that the `Allow write access` box is checked.
3. Store the ***private key***, i.e. the content of the generated file `DOCUMENTER_SSH_KEY.base64` as a ***SECRET*** 
    - At the ***organization level*** open `Settings/Secrets` and click `New organization secret`
    - Type `DOCUMENTER_KEY` in the secret's **Name** field
    - Paste the key string in the secret's **Value** field
    - Type `Selected repositories` on `Repository access`
    - Select one or more repositories (among the ones currently defined at the organization level)

    After the last step a list of all secrets defined at the organization level is updated. The list of repositories that can be possibly given access by a secret can then be modified at any time by clicking the `Update` button within the secret's display box. 


## PHASE 4 - Develop the package (before registration)

It is certainly sensible to postpone putting a package in the official Julia registry at a point in time when the code has reached a certain maturity level. Meanwhile, the code being developed can be tested together with all other packages in the Julia ecosystem: the way to do that is to leverage the `dev` option with the Julia package management tool `Pkg`.  

That is, instead of `add MyJuliaPkg` (which would only work after the package will be registered) we run `dev MyJuliaPkg`.
To learn more about this way of proceeding, look the package manager documentation at [Pkg.jl](https://julialang.github.io/Pkg.jl/). 

