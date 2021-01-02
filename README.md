# JuliaPkgTemplates
This project supports the creation of a CI/CD enabled GitHub repository to hold a new Julia package.

Here you find Julia reusable [code](mytemplate.jl) showing how to exploit functionality implemented by the [PkgTemplates.jl](https://github.com/invenia/PkgTemplates.jl) Julia project. Documentation of the latter is found [here](https://invenia.github.io/PkgTemplates.jl/stable/). 

By cloning this public project you should be able to reuse the **template()** function therein with minimal tailoring, if any, for the purpose of creating new Github projects where you intend to develop a Julia package. The [code](mytemplate.jl) does not contain user specific data such as the GitHub user name and email: these are taken from the user GitHub configuration. Also, the path of local packages/repositories should be set in the Julia **JULIA_PKG_DEVDIR** environment variable. 

CI/CD capabilities are enabled in the generated project through [Github Actions](https://docs.github.com/en/free-pro-team@latest/actions).  

After cloning this project, change directory to **$JULIA_PKG_DEVDIR**, start the Julia REPL and type the following 

<pre><font color="#4E9A06"><b>marcello@X570</b></font>:<font color="#3465A4"><b>~</b></font>$ cd $JULIA_PKG_DEVDIR
<font color="#4E9A06"><b>marcello@X570</b></font>:<font color="#3465A4"><b>~/Links/repos/git</b></font>$ julia
               <font color="#4E9A06"><b>_</b></font>
   <font color="#3465A4"><b>_</b></font>       _ <font color="#CC0000"><b>_</b></font><font color="#4E9A06"><b>(_)</b></font><font color="#75507B"><b>_</b></font>     |  Documentation: https://docs.julialang.org
  <font color="#3465A4"><b>(_)</b></font>     | <font color="#CC0000"><b>(_)</b></font> <font color="#75507B"><b>(_)</b></font>    |
   _ _   _| |_  __ _   |  Type &quot;?&quot; for help, &quot;]?&quot; for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.5.3 (2020-11-09)
 _/ |\__&apos;_|_|_|\__&apos;_|  |  Official https://julialang.org/ release
|__/                   |

<font color="#4E9A06"><b>julia&gt; </b></font>cd(&quot;JuliaPkgTemplates&quot;)

<font color="#4E9A06"><b>julia&gt; </b></font>include(&quot;mytemplate.jl&quot;)
template (generic function with 1 method)

<font color="#4E9A06"><b>julia&gt; </b></font>t=template()
</pre>
Template:
  authors: [&quot;Marcello Vitaletti &lt;marcello.vitaletti@gmail.com&gt; and contributors&quot;]
  dir: &quot;~/Links/repos/git&quot;
  host: &quot;github.com&quot;
  julia: v&quot;1.5.0&quot;
  user: &quot;ollecram&quot;
  plugins:
    Codecov:
      file: nothing
    CompatHelper:
      file: &quot;~/.julia/packages/PkgTemplates/Osgxj/templates/github/workflows/CompatHelper.yml&quot;
      destination: &quot;CompatHelper.yml&quot;
      cron: &quot;0 0 * * *&quot;
    Documenter:
      assets: String[]
      logo: Logo(nothing, nothing)
      makedocs_kwargs: Dict{Symbol,Any}()
      canonical_url: nothing
      make_jl: &quot;~/.julia/packages/PkgTemplates/Osgxj/templates/docs/make.jl&quot;
      index_md: &quot;~/.julia/packages/PkgTemplates/Osgxj/templates/docs/src/index.md&quot;
    Git:
      ignore: [&quot;*.jl.cov&quot;, &quot;*.jl.*.cov&quot;, &quot;*.jl.mem&quot;, &quot;deps/deps.jl&quot;, &quot;deps/build.log&quot;, &quot;deps/downloads/&quot;, &quot;deps/usr/&quot;, &quot;deps/src/&quot;, &quot;docs/build/&quot;, &quot;docs/site/&quot;, &quot;Manifest.toml&quot;]
      name: nothing
      email: nothing
      branch: nothing
      ssh: true
      jl: true
      manifest: false
      gpgsign: false
    GitHubActions:
      file: &quot;~/.julia/packages/PkgTemplates/Osgxj/templates/github/workflows/ci.yml&quot;
      destination: &quot;ci.yml&quot;
      linux: true
      osx: false
      windows: false
      x64: true
      x86: false
      coverage: true
      extra_versions: VersionNumber[v&quot;1.2.0&quot;]
    License:
      path: &quot;~/.julia/packages/PkgTemplates/Osgxj/templates/licenses/ASL&quot;
      destination: &quot;LICENSE&quot;
    ProjectFile:
      version: v&quot;0.1.0&quot;
    Readme:
      file: &quot;~/.julia/packages/PkgTemplates/Osgxj/templates/README.md&quot;
      destination: &quot;README.md&quot;
      inline_badges: false
    SrcDir:
      file: &quot;~/.julia/packages/PkgTemplates/Osgxj/templates/src/module.jl&quot;
    TagBot:
      file: &quot;~/.julia/packages/PkgTemplates/Osgxj/templates/github/workflows/TagBot.yml&quot;
      destination: &quot;TagBot.yml&quot;
      trigger: &quot;JuliaTagBot&quot;
      token: Secret(&quot;GITHUB_TOKEN&quot;)
      ssh: Secret(&quot;DOCUMENTER_KEY&quot;)
      ssh_password: nothing
      changelog: nothing
      changelog_ignore: nothing
      gpg: nothing
      gpg_password: nothing
      registry: nothing
      branches: nothing
      dispatch: nothing
      dispatch_delay: nothing
    Tests:
      file: &quot;~/.julia/packages/PkgTemplates/Osgxj/templates/test/runtests.jl&quot;
      project: true

<font color="#4E9A06"><b>julia&gt; </b></font></pre>

You are now ready to create your package by calling the function returned by the previous REPL command and passing as its single argument the name you want to be given to your new Julia package (".jl" suffix excluded). 

### Example ###

<pre>
<font color="#4E9A06"><b>julia&gt; </b></font>t(&quot;MyJuliaPkg&quot;)
<font color="#06989A"><b>[ Info: </b></font>Running prehooks
<font color="#06989A"><b>[ Info: </b></font>Running hooks
<font color="#4E9A06"><b> Activating</b></font> new environment at `~/Links/repos/git/MyJuliaPkg/test/Project.toml`
<font color="#4E9A06"><b>   Updating</b></font> registry at `~/.julia/registries/General`
<font color="#4E9A06"><b>   Updating</b></font> git-repo `https://github.com/JuliaRegistries/General.git`
<font color="#4E9A06"><b>  Resolving</b></font> package versions...
<font color="#4E9A06"><b>Updating</b></font> `/hdd3/marcello/repos/git/MyJuliaPkg/test/Project.toml`
 <font color="#555753"> [8dfed614] </font><font color="#8AE234">+ Test</font>
<font color="#4E9A06"><b>Updating</b></font> `/hdd3/marcello/repos/git/MyJuliaPkg/test/Manifest.toml`
 <font color="#555753"> [2a0f44e3] </font><font color="#8AE234">+ Base64</font>
 <font color="#555753"> [8ba89e20] </font><font color="#8AE234">+ Distributed</font>
 <font color="#555753"> [b77e0a4c] </font><font color="#8AE234">+ InteractiveUtils</font>
 <font color="#555753"> [56ddb016] </font><font color="#8AE234">+ Logging</font>
 <font color="#555753"> [d6f4376e] </font><font color="#8AE234">+ Markdown</font>
 <font color="#555753"> [9a3f8284] </font><font color="#8AE234">+ Random</font>
 <font color="#555753"> [9e88b42a] </font><font color="#8AE234">+ Serialization</font>
 <font color="#555753"> [6462fe0b] </font><font color="#8AE234">+ Sockets</font>
 <font color="#555753"> [8dfed614] </font><font color="#8AE234">+ Test</font>
<font color="#4E9A06"><b> Activating</b></font> environment at `~/.julia/environments/v1.5/Project.toml`
<font color="#4E9A06"><b> Activating</b></font> new environment at `~/Links/repos/git/MyJuliaPkg/docs/Project.toml`
<font color="#4E9A06"><b>  Resolving</b></font> package versions...
<font color="#4E9A06"><b>Updating</b></font> `/hdd3/marcello/repos/git/MyJuliaPkg/docs/Project.toml`
 <font color="#555753"> [e30172f5] </font><font color="#8AE234">+ Documenter v0.26.1</font>
<font color="#4E9A06"><b>Updating</b></font> `/hdd3/marcello/repos/git/MyJuliaPkg/docs/Manifest.toml`
 <font color="#555753"> [ffbed154] </font><font color="#8AE234">+ DocStringExtensions v0.8.3</font>
 <font color="#555753"> [e30172f5] </font><font color="#8AE234">+ Documenter v0.26.1</font>
 <font color="#555753"> [b5f81e59] </font><font color="#8AE234">+ IOCapture v0.1.1</font>
 <font color="#555753"> [682c06a0] </font><font color="#8AE234">+ JSON v0.21.1</font>
 <font color="#555753"> [69de0a69] </font><font color="#8AE234">+ Parsers v1.0.15</font>
 <font color="#555753"> [2a0f44e3] </font><font color="#8AE234">+ Base64</font>
 <font color="#555753"> [ade2ca70] </font><font color="#8AE234">+ Dates</font>
 <font color="#555753"> [8ba89e20] </font><font color="#8AE234">+ Distributed</font>
 <font color="#555753"> [b77e0a4c] </font><font color="#8AE234">+ InteractiveUtils</font>
 <font color="#555753"> [76f85450] </font><font color="#8AE234">+ LibGit2</font>
 <font color="#555753"> [8f399da3] </font><font color="#8AE234">+ Libdl</font>
 <font color="#555753"> [56ddb016] </font><font color="#8AE234">+ Logging</font>
 <font color="#555753"> [d6f4376e] </font><font color="#8AE234">+ Markdown</font>
 <font color="#555753"> [a63ad114] </font><font color="#8AE234">+ Mmap</font>
 <font color="#555753"> [44cfe95a] </font><font color="#8AE234">+ Pkg</font>
 <font color="#555753"> [de0858da] </font><font color="#8AE234">+ Printf</font>
 <font color="#555753"> [3fa0cd96] </font><font color="#8AE234">+ REPL</font>
 <font color="#555753"> [9a3f8284] </font><font color="#8AE234">+ Random</font>
 <font color="#555753"> [ea8e919c] </font><font color="#8AE234">+ SHA</font>
 <font color="#555753"> [9e88b42a] </font><font color="#8AE234">+ Serialization</font>
 <font color="#555753"> [6462fe0b] </font><font color="#8AE234">+ Sockets</font>
 <font color="#555753"> [8dfed614] </font><font color="#8AE234">+ Test</font>
 <font color="#555753"> [cf7118a7] </font><font color="#8AE234">+ UUIDs</font>
 <font color="#555753"> [4ec0a83e] </font><font color="#8AE234">+ Unicode</font>
Path `..` exists and looks like the correct package. Using existing path.
<font color="#4E9A06"><b>  Resolving</b></font> package versions...
<font color="#4E9A06"><b>Updating</b></font> `/hdd3/marcello/repos/git/MyJuliaPkg/docs/Project.toml`
 <font color="#555753"> [b9db0081] </font><font color="#8AE234">+ MyJuliaPkg v0.1.0 `..`</font>
<font color="#4E9A06"><b>Updating</b></font> `/hdd3/marcello/repos/git/MyJuliaPkg/docs/Manifest.toml`
 <font color="#555753"> [b9db0081] </font><font color="#8AE234">+ MyJuliaPkg v0.1.0 `..`</font>
<font color="#4E9A06"><b> Activating</b></font> environment at `~/.julia/environments/v1.5/Project.toml`
<font color="#06989A"><b>[ Info: </b></font>Running posthooks
<font color="#06989A"><b>[ Info: </b></font>New package is at /home/marcello/Links/repos/git/MyJuliaPkg
</pre>

## CI Workflows
Building with GitHub actions using a self-hosted (i.e. local) runner can only be safely made on a **private** repository.
I will post more details on how to setup [Github Actions](https://docs.github.com/en/) with a self-hosted runner in the GitHub repo as soon as I will have gathered some familiarity with the CI workflows. 
  
