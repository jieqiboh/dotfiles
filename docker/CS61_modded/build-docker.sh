#! /bin/bash

cd `dirname $0`

arch="`arch`"
tag=
platform=
while test "$#" -ne 0; do # loop as long as the number of positional parameters != 0
    if test "$1" = "-a" -o "$1" = "--arm" -o "$1" = "--arm64"; then # if the 1st positional param equals "-a"
        if test "`arch`" = "arm64" -o "`arch`" = "aarch64"; then # -o is the OR operator
            platform=linux/arm64
            shift # shifts positional params to the left by 1 pos i.e. $1 gets discarded, value of $1 becomes value of $2, etc.
        else
            echo "\`cs61-build-docker --arm\` only works on ARM64 hosts" 1>&2 # 1 >& 2 means pipe the stdout to stderr
            exit 1 # exit status 1 conventionally means failure / error
        fi
    elif test "$1" = "-x" -o "$1" = "--x86-64" -o "$1" = "--x86_64" -o "$1" = "--amd64"; then
        platform=linux/amd64
        shift
    else
        armtext=
        if test "`arch`" = "arm64" -o "`arch`" = "aarch64"; then
            armtext=" [-a|--arm] [-x|--x86-64]"
        fi
        echo "Usage: cs61-build-docker$armtext" 1>&2
        exit 1
    fi
done
if test -z "$platform" -a \( "$arch" = "arm64" -o "$arch" = "aarch64" \); then # test -z checks if $platform var is empty
    platform=linux/arm64
elif test -z "$platform"; then
    platform=linux/amd64
fi
if test -z "$tag" -a "$platform" = linux/arm64; then
    tag=cs61:arm64
elif test -z "$tag"; then
    tag=cs61:latest
fi

if test $platform = linux/arm64; then
    exec docker build -t "$tag" -f Dockerfile.arm64 --platform linux/arm64 .
else
    exec docker build -t "$tag" -f Dockerfile --platform linux/amd64 .
fi

