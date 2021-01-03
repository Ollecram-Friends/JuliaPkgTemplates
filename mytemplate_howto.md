# Julia Pkg Templates - How To

This file is hosted within the GitHub repository [JuliaPkgTemplates](https://github.com/Ollecram-Friends/JuliaPkgTemplates). 

In this repository you find Julia reusable [code](mytemplate.jl) showing how to exploit functionality implemented by the [PkgTemplates.jl](https://github.com/invenia/PkgTemplates.jl) Julia project. Documentation of the latter is found [there](https://invenia.github.io/PkgTemplates.jl/stable/). 

Code in this repository ***is NOT a Julia package***, but rather a ***precursor*** for building new Julia packages with a similar structure in a ***repeatable way***.

## Assumptions

I assume that  
1. You have a GitHub account configured for **SSH**
2. You have set the variables `github.user` and `github.email` in your GitHub configuration  
3. You have setup your shell so that **JAVA_PKG_DEVDIR** variable holds the path to all the local Git clones
4. You have Julia 1.5.0 or a later version 

## How To 1 - Create the new package locally

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

## How To 2 - Create GitHub project and override with local content

1. On GitHub ***create a new empty project with the same name***
    - With your account, use GitHub Web UI to create the project
    - Copy the SSH url of the created package to the clipboard
2. Issue Git commands to ***set the remote origin and push***
    - `cd $JAVA_PKG_DEVDIR`
    - `cd MyJuliaPkg`
    - `git remote set-url origin <SSH REPOSITORY URL from the CLIPBOARD>`
    - `git branch -M main`
    - `git push -u origin main`

