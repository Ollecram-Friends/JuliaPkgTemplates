function template()
    @eval begin
        using PkgTemplates
        
        Template(; 
        # user=                     # Take default from github.user & github.email
        # dir=                      # Take default from $JULIA_PKG_DEVDIR iff defined
        # authors=                  # Build default from `user` argument or default
        julia=v"1.5",               # Require Julia version 1.5.x

        plugins=[           # Plugins' start

            ProjectFile(;           # Creates a Project.toml
            version=v"0.1.0"                # The initial version of created packages.
            ),      

            SrcDir(;                # Creates a module entrypoint
            #file=                          # Template file for src/<module>.jl
            ), 

            Tests(;                 # Sets up testing for packages
            #file=                          # Template file for runtests.jl
            project=true                    # Create new project for tests (test/Project.toml)
            ),

            Readme(;                # Creates README file with badges for other included plugins
            # file=                         # Template file for the README
            # destination=                  # File destination, rel/to the repository root
            inline_badges=false,            # Badges on the same line as the package name?
            ),

            License(;               # Creates a license file 
            name="ASL",                     # Apache Software License
            path=nothing,                   # Path to a custom license file. 
            # destination=                  # File destination, rel/to the repository root
            ),

            Git(;                   # Creates a Git repository and a .gitignore file
            ignore=["*.jl.cov", "*.jl.*.cov", "*.jl.mem", 
                    "deps/deps.jl", "deps/build.log", "deps/downloads/", "deps/usr/", "deps/src/", 
                    "docs/build/", "docs/site/", 
                    "Manifest.toml"], 
            # name=                         # Take default from github.user 
            # email=                        # Take default from github.email
            # branch=                       # Desired name of the repos's default branch
            ssh=true,                       # Use SSH (vs HTTPS)
            jl=false,                       # Add ".jl" to the git repository URL                   
            manifest=false,                 # Never commit Manifest.toml
            gpgsign=false,                  # No GPG signing of Git commits
            ),

            CompatHelper(;          # Integrates with CompatHelper via GitHub Actions
            # file=                             # Template file for the workflow file
            destination="CompatHelper.yml",     # Destination rel/to .github/workflows
            cron="0 0 * * *",                   # Cron expression for the schedule interval
            ),

            TagBot(;                # Adds GitHub release support via TagBot
            # file=                             # Template file for the workflow file.
            destination="TagBot.yml",           # Destination rel/to .github/workflows
            trigger="JuliaTagBot",              # Trigger username for custom registries
            token=Secret("GITHUB_TOKEN"),       # Name of the token secret to use
            ssh=Secret("DOCUMENTER_KEY"),       # Name of the SSH private key secret to use
            ssh_password=nothing,               # Name of the SSH key password secret to use
            changelog=nothing,                  # Custom changelog template
            changelog_ignore=nothing,           # Issue/pull request labels to ignore in changelog
            gpg=nothing,                        # Name of the GPG private key secret to use
            gpg_password=nothing,               # Name of the GPG private key password secret to use
            registry=nothing,                   # Custom registry, in the format owner/repo
            branches=nothing,                   # Whether not to enable the branches option
            dispatch=nothing,                   # Whether or not to enable the dispatch option
            dispatch_delay=nothing,             # Number of minutes to delay for dispatch events
            ),

            GitHubActions(;         # Integrates your packages with GitHub Actions
            # file=                             # Template file for the workflow file
            destination="ci.yml",               # Destination rel/to .github/workflows
            linux=true,                         # Whether or not to run builds on Linux
            osx=false,                          # Whether or not to run builds on OSX (Mac OS)
            windows=false,                      # Whether or not to run builds on Windows
            x64=true,                           # Whether or not to run builds on 64-bit architecture
            x86=false,                          # Whether or not to run builds on 32-bit architecture
            coverage=true,                      # Whether or not to publish code coverage
            extra_versions=[v"1.2"],            # Extra Julia versions to test
            ),

            Codecov(;           # Sets up code coverage submission from CI to Codecov
            ),
            
            Documenter{GitHubActions}(; # Sets up documentation generation via Documenter.jl
            # make_jl=                          # Template file for make.jl
            # index_md=                         # Template file for index.md
            assets=String[],                    # Extra assets for the generated site
            logo=Logo(),                        # A Logo w documentation logo information
            canonical_url=nothing,              # A function to generate the site's canonical URL
            makedocs_kwargs=Dict{Symbol, Any}(),    # Extra keyword args to be inserted into makedocs
            ),

            # Develop(),          # Adds generated packages to the current environment   

        ],      # Plugins' end

    )       # Template's end        
    end
end