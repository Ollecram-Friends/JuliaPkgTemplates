# JuliaPkgTemplates
This project supports the creation of a CI/CD enabled GitHub repository to hold a new Julia package.

Here you find Julia reusable [code](mytemplate.jl) showing how to exploit functionality implemented by the [PkgTemplates.jl](https://github.com/invenia/PkgTemplates.jl) Julia project. Documentation of the latter is found [there](https://invenia.github.io/PkgTemplates.jl/stable/). 

By cloning this public project you should be able to reuse the **template()** function therein with minimal tailoring, if any, for the purpose of creating new Github projects where you intend to develop a Julia package. The [code](mytemplate.jl) does not contain user specific data such as the GitHub user name and email: these are taken from the user GitHub configuration. Also, the path of local packages/repositories should be set in the Julia **JULIA_PKG_DEVDIR** environment variable. 

CI/CD capabilities are enabled in the generated project through [Github Actions](https://docs.github.com/en/free-pro-team@latest/actions).  

## Usage
You may want to read this [HowTo](mytemplate_howto.md) to learn a simple, repeatable way to create GitHub projects for new Julia packages with a ***uniform structure and workflows***. 

## CI Workflows using GitHub Actions
More details about leveraging [Github Actions](https://docs.github.com/en/) for the automation of CI workflows and the overall GitHub setup for developing Julia packages in a small organization can be found [here](julia_CI.md). 


  
