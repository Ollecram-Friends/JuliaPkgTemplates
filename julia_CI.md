# Julia Package Development CI with GitHub Actions
You may want to read this [HowTo](mytemplate_howto.md) ***before*** this file, to learn a simple, repeatable way to create GitHub projects for new Julia packages with ***uniform structure and workflows***. 

This file illustrates the author experience with a CI strategy that could be appealing to small teams of Julia package developers.

The goals influencing the strategy are
1. Minimizing the fixed costs of the CI infrastructure
2. Avoid requiring complex automation logic to be learned and maintained by team members
3. Avoid implementing the CI infrastructure in-house   

Julia heavily relies on **GitHub** for package development and dependency management. 
Julia ***package developers*** are expected to leverage the templating tool in [PkgTemplates.jl](https://github.com/invenia/PkgTemplates.jl) in order to follow a uniform set of best practices when structuring the source tree of their packages. **Continuous Integration** (CI) requires to define ***workflows*** whose execution is automatically triggered by events (commits, pull requests) associated with the Git repository holding the package Julia code and documentation. Projects structured with the use of *PkgTemplates* also keep the logic of CI *worflows* together with Julia code and documentation, in the same Git repository. 

There are several CI automation tools today (TravisCI, AppVeyor, GitHub Actions) which are available as *web services*. This avoid the needs for developers to install and run these services on their own infrastructure. This is a tremendous advantage, if one only consider that a laptop is often a developer's only `infrastructure`. 
Some of these web CI services can be used for free, usually only for *open source* projects stored on ***public Git repositories***. These free plans also limit the number of builds per unit time, so they cannot accomodate the needs of several people developing against the same repository. 

Notably, [GitHub Actions](https://docs.github.com/en/free-pro-team@latest/actions) also offers an alternative to buying time on their web infrastructure: GitHub Actions workflows can be executed for free by a ***self-hosted runner***, an application running on the computer of each developer. It must be noted that Building with GitHub actions using a self-hosted runner can only be safely made on a **private** repository. The risk in using a self-hosted runner with a public repo is that someone could in principle install code in the repository to be eventually executed by the runner that could create/modify/delete resources in the host residing *outside* of the local repository copy.

The following ***serious drawback*** emerged in some early attempts at using GitHub Actions with a self-hosted runner:
*Developers must install one distinct copy of the runner application for each repository (hence, for each package being developed)*. This clearly was (and it still is) a show-stopper for anybody wanting to do more than just a trial. 

Fortunately, the above limitation is now removed for projects hosted by a GitHub ***Organization***. The monthly cost of creating an organization is 4$ per seat. Considering that 7$ buy a single user the ability to create an unlimited number of private repositories, 11$ buy everybody the ability to have an unlimited number of private repositories within her/his own organization. We will touch later upon the more likely scenario where multiple developers need to access the same  project without requiring each of them to get a *paid seat* in the organization where the project is contained.  

Therefore, let us focus first on the scenario where a ***single developer*** 
a. Owns a GitHub ***user*** account (e.g. **Ollecram**) at monthly 7$ (unlimited private repos)
b. Owns a GitHub ***organization*** account with 1+ seats (e.g. **Ollecram-Friends**)
c. Keeps non-CI projects in Git repositories (public or private) at the ***user*** account
d. Keeps CI projects in ***private*** Git repositories at the ***organization*** account
e. Enables a ***Self-Hosted Runner*** in the ***organization*** account for running CI against all projects therein

 