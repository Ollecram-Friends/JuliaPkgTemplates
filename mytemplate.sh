#!/bin/bash
#=

#|-------------------------------------------------------------------------|
#|                                                                         |
#| See https://docs.julialang.org/en/v1/manual/faq/#man-scripting          |
#| for an explanation of the mixed BASH-JULIA code present in this file.   |
#|                                                                         |
#| !! PLS  D O  N O T    R E M O V E   or  C H A N G E  lines  2 and 38 !! |                                                        |
#|                                                                         |
#|-------------------------------------------------------------------------|

# 1. Check that one argument was supplied
if [ $# -eq 0 ];
then echo "Error: one argument with the name of the Julia Pkg must be supplied" && exit 1;
elif [ $# -gt 1 ];
then echo "Error: too many arguments. Only the name of the Julia Pkg must be supplied" && exit 1;
fi

# 2. Check that JULIA_PKG_DEVDIR variable is defined
if [ -z ${JULIA_PKG_DEVDIR+x} ]; 
then echo "Error: JULIA_PKG_DEVDIR is unset" && exit 1;
else echo "JULIA_PKG_DEVDIR is set to '$JULIA_PKG_DEVDIR'";
fi

# 3. Check that JuliaPkgTemplates exists as a directory under JULIA_PKG_DEVDIR
if [ ! -d "$JULIA_PKG_DEVDIR/JuliaPkgTemplates" ]; 
then echo "Error: local clone of JuliaPkgTemplates not found under $JULIA_PKG_DEVDIR" && exit 1;
else echo "JuliaPkgTemplates local clone found under '$JULIA_PKG_DEVDIR'";
fi

# 4. Change directory to JULIA_PKG_DEVDIR/JuliaPkgTemplates
cd "$JULIA_PKG_DEVDIR/JuliaPkgTemplates"

# 5. Start the Julia REPL to interpret and execute what follows line 38

exec julia --color=yes --startup-file=no "${BASH_SOURCE[0]}" "$@"
=#

# ------------------ Put any Julia code below this line ------------------- 

# A. Show the variables passed as arguments to the Julia REPL 
@show ARGS

# B. Create repository for the new package under JULIA_PKG_DEVDIR  
include("mytemplate.jl")
t=template()
t(ARGS[1])

# C. Create a file named `BEFORE_1st_PUSH` at the root of the new 
#    repository, as a marker that no 'git push' was executed yet.
#    This is done to implement robustness in the `firstpush.sh` script
using Dates
dateTime = Dates.format(now(), "yyyy-mm-dd HH:MM:SS")
record = "Created by JuliaPkgTemplates/mytemplate.sh on " * dateTime * "\n"
path = "../" * ARGS[1] * "/BEFORE_1st_PUSH"
open(path, "w") do io
    print(io, record)
end
 