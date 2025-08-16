#!/bin/bash

# Exit immediately on error
set -e

# Step 1: Clean local manifests
rm -rf .repo/local_manifests/
echo "==========================="
echo " Local manifests cleaned ✅"
echo "==========================="

# Step 2: Initialize repo
repo init -u https://github.com/Lunaris-AOSP/android -b 16 --git-lfs
echo "=================="
echo " Repo init success ✅"
echo "=================="

# Step 3: Clone local manifests
git clone -b lunaris https://github.com/MaheshTechnicals/local_manifests_miatoll .repo/local_manifests
echo "============================"
echo " Local manifests cloned ✅"
echo "============================"

# Step 4: Sync sources
/opt/crave/resync.sh
echo "============="
echo " Repo sync success ✅"
echo "============="

# Step 5: Export build info
export BUILD_USERNAME=mahesh
export BUILD_HOSTNAME=crave
echo "======================"
echo " Export vars done ✅"
echo "======================"

# Step 6: Setup build environment
source build/envsetup.sh
echo "====================="
echo " Envsetup success ✅"
echo "====================="

# Step 7: Lunch target
lunch lineage_miatoll-bp2a-user
echo "====================="
echo " Lunch target set ✅"
echo "====================="

# Step 8: Clean intermediates
make installclean
echo "====================="
echo " Installclean done ✅"
echo "====================="

# Step 9: Start build
m lunaris
echo "====================="
echo " Build started 🚀"
echo "====================="

