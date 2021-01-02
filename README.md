# JuliaPkgTemplates
Code assisting the creation of a Julia package project GitHub repository based on Julia Pkg &amp; PkgTemplates 

This project contains Julia reusable [code](mytemplate.jl) showing how to exploit functionality implemented by the [PkgTemplates.jl] Julia project. By cloning this public project you should be able to reuse the **template()** function with minimal tailoring, if any, for the purpose of creating new Github projects where you intend to develop a Julia package. CI/CD capabilities are enabled through [Github Actions](https://docs.github.com/en/free-pro-team@latest/actions.  

After cloning this project, just start the Julia REPL and type the following 

<pre>               <font color="#4E9A06"><b>_</b></font>
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

<font color="#4E9A06"><b>julia&gt; </b></font>t = template()
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