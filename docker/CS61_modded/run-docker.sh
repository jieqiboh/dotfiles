#! /bin/bash

maindir=""
destdir=cs61-lectures

fresh=
verbose=false
arch="`arch`"
tag=
platform=
while test "$#" -ne 0; do
    if test "$1" = "-f" -o "$1" = "--fresh"; then
        fresh=1
        shift
    elif test "$1" = "-V" -o "$1" = "--verbose"; then
        verbose=true
        shift
    elif test "$1" = "-a" -o "$1" = "--arm" -o "$1" = "--arm64"; then
        if test "$arch" = "arm64" -o "$arch" = "aarch64"; then
            platform=linux/arm64
            shift
        else
            echo "\`cs61-run-docker --arm\` only works on ARM64 hosts" 1>&2
            exit 1
        fi
    elif test "$1" = "-x" -o "$1" = "--x86-64" -o "$1" = "--x86_64" -o "$1" = "--amd64"; then
        platform=linux/amd64
        shift
    else
        armtext=
        if test "$arch" = "arm64" -o "$arch" = "aarch64"; then
            armtext=" [-a|--arm] [-x|--x86-64]"
        fi
        echo "Usage: cs61-run-docker [-f|--fresh]$armtext [-V|--verbose]" 1>&2
        exit 1
    fi
done
if test -z "$platform" -a \( "$arch" = "arm64" -o "$arch" = "aarch64" \); then
    platform=linux/arm64
elif test -z "$platform"; then
    platform=linux/amd64
fi
if test -z "$tag" -a "$platform" = linux/arm64; then
    tag=cs61:arm64
elif test -z "$tag"; then
    tag=cs61:latest
fi


vexec () {
    if $verbose; then
        echo "$@"
    fi
    exec "$@"
}

if stat --format %i / >/dev/null 2>&1; then
    statformatarg="--format"
else
    statformatarg="-f"
fi
myfileid=`stat $statformatarg %d:%i "${BASH_SOURCE[0]}" 2>/dev/null`

dir="`pwd`"
subdir=""
while test "$dir" != / -a "$dir" != ""; do
    thisfileid=`stat $statformatarg %d:%i "$dir"/cs61-run-docker 2>/dev/null`
    if test -n "$thisfileid" -a "$thisfileid" = "$myfileid"; then
        maindir="$dir"
        break
    fi
    subdir="/`basename "$dir"`$subdir"
    dir="`dirname "$dir"`"
done

if test -z "$maindir" && expr "${BASH_SOURCE[0]}" : / >/dev/null 2>&1; then
    maindir="`dirname "${BASH_SOURCE[0]}"`"
    subdir=""
fi

ssharg=
sshenvarg=
if test -n "$SSH_AUTH_SOCK" -a "`uname`" = Darwin; then
    ssharg=" --mount type=bind,src=/run/host-services/ssh-auth.sock,target=/run/host-services/ssh-auth.sock"
    sshenvarg=" -e SSH_AUTH_SOCK=/run/host-services/ssh-auth.sock"
fi

if test -n "$maindir" -a -z "$fresh"; then
    existing_image="`docker ps -f status=running -f ancestor=$tag -f volume=/host_mnt"$maindir" --no-trunc --format "{{.CreatedAt}},{{.ID}}" | sort -r | head -n 1`"
    if test -n "$existing_image"; then
        created_at="`echo $existing_image | sed 's/,.*//'`"
        image="`echo $existing_image | sed 's/^.*,//'`"
        image12="`echo $image | head -c 12`"
        echo "* Using running container $image12, created $created_at" 1>&2
        echo "- To start a new container, exit then \`cs61-run-docker -f\`" 1>&2
        echo "- To kill this container, exit then \`docker kill $image12\`" 1>&2
        vexec docker exec -it$sshenvarg $image /bin/bash
    fi
fi

netarg=
if test `uname` = Darwin; then
    if ! netstat -n -a -p tcp | grep '\.6169[  ].*LISTEN' >/dev/null; then
        netarg="$netarg "'--expose=6169/tcp -p 6169:6169/tcp'
    fi
    if ! netstat -n -a -p tcp | grep '\.12949[ 	].*LISTEN' >/dev/null; then
        netarg="$netarg "'--expose=12949/tcp -p 12949:12949/tcp'
    fi
elif test -x /bin/netstat; then
    if ! netstat -n -a -p tcp | grep '\.6169[  ].*LISTEN' >/dev/null; then
        netarg="$netarg "'--expose=6169/tcp -p 6169:6169/tcp'
    fi
    if ! netstat -n -l -t | grep ':12949[ 	]' >/dev/null; then
        netarg="$netarg "'--expose=12949/tcp -p 12949:12949/tcp'
    fi
fi

if test -n "$maindir"; then
    vexec docker run -it --platform $platform --rm --privileged --cap-add=SYS_PTRACE --cap-add=NET_ADMIN --security-opt seccomp=unconfined -v "$maindir":/home/cs61-user/$destdir$ssharg -w "/home/cs61-user/$destdir$subdir" $netarg$sshenvarg $tag
else
    vexec docker run -it --platform $platform --rm --privileged --cap-add=SYS_PTRACE --cap-add=NET_ADMIN --security-opt seccomp=unconfined $netarg$sshenvarg $tag
fi
