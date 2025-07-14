#!/bin/bash
REPO_URL="ssh://aur@aur.archlinux.org/minecraft-technic-launcher.git"
if [[ $1 ]];then
    UPDATED=$(echo $1 | sed s/\"//g)
    SHA256=$(curl "https://launcher.technicpack.net/launcher4/${UPDATED}/TechnicLauncher.jar" | sha256sum | sed s/"  -"//g)
    git clone $REPO_URL repo
    cd repo
    cat ../PKGBUILD.template | sed s/CM_V/${UPDATED}/g | sed s/CM_S/${SHA256}/g > ./PKGBUILD
    makepkg --printsrcinfo > .SRCINFO
    git add .
    git commit -m "version 4.${UPDATED}"
    git push
    cd ..
    rm -rf repo
    echo "\"$UPDATED\"" > version
fi
