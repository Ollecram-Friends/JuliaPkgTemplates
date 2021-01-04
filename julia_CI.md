# Julia Package Development CI with GitHub Actions
You may want to read this [HowTo](mytemplate_howto.md) ***before*** this file, to learn a simple, repeatable way to create GitHub projects for new Julia packages with ***uniform structure and workflows***. 

You may intend to run CI workflows with GitHub Actions ***on the CI infrastructure provided for you by GitHub***. This usually requires to pay a monthly extra that varies according to job time and storage limits, although free plans also exist for open source projects. ***If this is the case you may not need to read more of what follows***.

## GitHub Actions CI with a self-hosted runner

Julia heavily relies on **GitHub** for package development and dependency management. 
Julia ***package developers*** are expected to leverage the templating tool in [PkgTemplates.jl](https://github.com/invenia/PkgTemplates.jl) in order to follow a uniform set of best practices when structuring the source tree of their packages. **Continuous Integration** (CI) requires to define ***workflows*** whose execution is automatically triggered by events (commits, pull requests) associated with the Git repository holding the package Julia code and documentation. Projects structured with the use of *PkgTemplates* also keep the logic of CI *worflows* together with Julia code and documentation, in the same Git repository. 

There are several CI automation tools today (TravisCI, AppVeyor, GitHub Actions) which are available as *web services*. This avoid the needs for developers to install and run these services on their own infrastructure. This is a tremendous advantage, if one only consider that a laptop is often a developer's only "infrastructure". 
Some of these web CI services can be used for free, usually only for *open source* projects stored on ***public Git repositories***. These free plans also limit the number of builds per unit time, so they cannot accomodate the needs of several people developing against the same repository. 

Notably, [GitHub Actions](https://docs.github.com/en/free-pro-team@latest/actions) also offers an alternative to buying time on their web infrastructure: GitHub Actions workflows can be executed for free by a ***self-hosted runner***, an application running on the computer of each developer. It must be noted that building with GitHub actions using a self-hosted runner can only be safely made on a **private** repository. The risk in using a self-hosted runner with a public repo is that someone could in principle install code in the repository to be eventually executed by the runner that could create/modify/delete resources in the host residing *outside* of the local repository copy.

The following ***serious drawback*** emerged in some early attempts at using GitHub Actions with a self-hosted runner:
*Developers must install one distinct copy of the runner application for each repository (hence, for each package being developed)*. This clearly was (and it still is) a show-stopper for anybody wanting to do more than just a trial. 

Fortunately, the above limitation is now removed for projects hosted by a GitHub ***Organization***. The monthly cost of creating an organization is currently quite affordable (4$ per seat/member). This buys each member the hosting of an unlimited number of public and private repositories within the organization. 

Let us make all this more definite by focusing first on the scenario where a ***single developer*** 
1. Owns a GitHub ***user*** account (e.g. **Ollecram**) at monthly 4$ (unlimited private repos)
2. Owns a GitHub ***organization*** account with 1+ seats (e.g. **Ollecram-Friends**)
3. Keeps non-CI projects in Git repositories (public or private) at the ***user*** account
4. Keeps CI projects in ***private*** Git repositories at the ***organization*** account
5. Enables a ***Self-Hosted Runner*** in the ***organization*** account for running CI against all projects therein

Read the following section for details about the last point.

### How to setup a GitHub Actions self-hosted runner

After you have created your organization, let do the following to setup a ***self-hosted runner***
1. Sign-in into GitHub with your ***user account***
2. In the upper, rightmost corner of your browser window, right-click your profile image and select `Your organizations`
3. In the `Organizations` page, select the one where you want to setup the self-hosted runner
4. In the `Organization` page select `Settings` 
5. In the `Settings` page select `Actions`
6. In the `Actions` page, select `Allow local actions only` within the section `Action permissions / Policies`
7. Click the `Save` button to save the change made in the previous step
8. In the `Actions` page, within the `Self-hosted runners` section, click the `Add new` button
9. Execute the following detailed instructions to download, configure and start the runner
10. Check the `Runner groups` table in the `Self-hosted runners` section of the `Actions` page. The newly created runner should appear in the `Idle` state under the `Default` group, with the name it was assigned to it in the previous step.

Note that at this stage the runner will be only invoked to run jobs from repositories that are associated to a `Runner group`. This means that workflows triggered for a repository that is not part of any Runner group will be executed on the GitHub Actions web infrastructure. 

To redirect workflows from ***all repositories*** in your organization to the self-hosted runner, just select the `Default` runner group. To selectively redirect workflows from certain repositories you just need to create more runner groups.    

 