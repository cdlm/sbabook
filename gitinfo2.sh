#!/bin/sh
#
# Extract version info for use by the gitinfo2.sty package.
#
# Modified from gitinfo2's post-xxx-sample.txt file, to make it callable from
# the build system instead of as a git hook, and to make it robust outside of a
# git checkout.

# strict error handling
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   # set -u : exit the script if you try to use an uninitialized variable
set -o errexit   # set -e : exit the script if any statement returns a non-true return value

# Check that we're in a git repo, or bail out
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

# Get the first tag found in the history from the current HEAD
FIRSTTAG=$(git describe --tags --always --dirty='-*' 2>/dev/null)
# Get the first tag in history that looks like a Release
RELTAG=$(git describe --tags --long --always --dirty='-*' --match '[0-9]*.*' 2>/dev/null)
# Format git info as a LaTeX package load
FMT="\
\usepackage[%
        shash={%h},
        lhash={%H},
        authname={%an},
        authemail={%ae},
        authsdate={%ad},
        authidate={%ai},
        authudate={%at},
        commname={%an},
        commemail={%ae},
        commsdate={%ad},
        commidate={%ai},
        commudate={%at},
        refnames={%d},
        firsttagdescribe={$FIRSTTAG},
        reltag={$RELTAG}
    ]{gitexinfo}
"

# Hoover up the metadata
git --no-pager log -1 --date=short --decorate=short --pretty=format:"$FMT" HEAD
