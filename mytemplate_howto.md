# Julia Pkg Templates - How To

This file is hosted within the GitHub repository [JuliaPkgTemplates](https://github.com/Ollecram-Friends/JuliaPkgTemplates). 

In this repository you find Julia reusable [code](mytemplate.jl) showing how to exploit functionality implemented by the [PkgTemplates.jl](https://github.com/invenia/PkgTemplates.jl) Julia project. Documentation of the latter is found [there](https://invenia.github.io/PkgTemplates.jl/stable/). 

Code in this repository ***is NOT a Julia package***, but rather a ***precursor*** for building new Julia packages with a similar structure in a ***repeatable way***.

## Assumptions

I assume that  
1. You have a GitHub account configured for **SSH**
2. You have set the variables `github.user`, `user.name` and `user.email` in your GitHub configuration, as you you verify by `git config --list`  
3. You have setup your shell so that **JAVA_PKG_DEVDIR** variable holds the path to all the local Git clones
4. You have Julia 1.5.0 or a later version 

## How To PHASE 1 - Create the new package locally

1. Open the shell and execute the following commands to ***clone this project***
    - `cd $JAVA_PKG_DEVDIR`
    - `git clone git@github.com:Ollecram-Friends/JuliaPkgTemplates.git`
2. In the shell, execute the following commands to ***start the Julia REPL***
    - `cd $JAVA_PKG_DEVDIR`   (...just in case you moved elsewhere...)
    - `julia`
3. In the Julia REPL run the following commands, where `MyJuliaPkg` in the last one stands for the name of the new package
    - `cd("JuliaPkgTemplates")`
    - `include("mytemplate.jl")`
    - `t=template()`
    - `t("MyJuliaPkg")`
4. Quit the Julia REPL
    - `CTRL+D`

A ***safer/quicker alternative*** to manually executing the above steps 2 to 4 is to run the following `bash` script just after step 1:
- `./mytemplate.sh MyJuliaPkg`

## How To PHASE 2 - Create GitHub repository and fill it with local content

1. On GitHub ***create a new empty repository with the same name***
    - With your account, use the GitHub Web UI to create the project
    - No initial content is needed, not even the README and .gitignore
    - If the repo is meant to serve for initial package development
        - ***make it private***
        - ***create it at the organization level***  
    - Copy the SSH url of the created repository to the clipboard
    - Review `Settings / Actions / Actions Permissions / Policies` at the organization level. In particular, if Actions are only enabled for `Selected repositories` the newly created one must be selected for automation to work.
2. Issue Git commands to ***set the remote origin and push***
    - `cd $JAVA_PKG_DEVDIR`
    - `cd MyJuliaPkg`
    - `git remote set-url origin <SSH REPOSITORY URL from the CLIPBOARD>`
    - `git branch -M main`
    - `git push -u origin main`

