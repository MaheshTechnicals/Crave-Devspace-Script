#!/bin/bash
set -e  # exit immediately on error

# Step 1: Clean local manifests (don't remove build/)
rm -rf .repo/local_manifests

# Step 2: Initialize repo
repo init -u https://github.com/Lunaris-AOSP/android -b 16 --git-lfs

# Step 3: Clone local manifests
git clone -b lunaris https://github.com/MaheshTechnicals/local_manifests_miatoll .repo/local_manifests

# Step 4: Sync sources (loop until build/envsetup.sh exists)
MAX_RETRIES=3
for i in $(seq 1 $MAX_RETRIES); do
    echo ">>> Repo sync attempt $i of $MAX_RETRIES..."
    /opt/crave/resync.sh || true

    if [ -f build/envsetup.sh ]; then
        echo ">>> build/envsetup.sh found! Proceeding..."
        break
    fi

    if [ "$i" -eq "$MAX_RETRIES" ]; then
        echo "❌ build/envsetup.sh not found after $MAX_RETRIES attempts. Exiting."
        exit 1
    fi

    echo "⚠️ build/envsetup.sh missing, retrying sync..."
    sleep 5
done

# Step 5: Setup build environment
source build/envsetup.sh

# Step 6: Lunch target
lunch lineage_miatoll-bp2a-user

# Step 7: Clean intermediates
make installclean

# Step 8: Start build
m lunaris
