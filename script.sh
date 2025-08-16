# Clean only local manifests (don't delete build/)
rm -rf .repo/local_manifests &&

# Initialize repo
repo init -u https://github.com/Lunaris-AOSP/android -b 16 --git-lfs &&

# Clone local manifests
git clone -b lunaris https://github.com/MaheshTechnicals/local_manifests_miatoll .repo/local_manifests &&

# Sync sources
/opt/crave/resync.sh &&

# Setup build environment
source build/envsetup.sh &&

# Lunch target
lunch lineage_miatoll-bp2a-user &&

# Clean intermediates
make installclean &&

# Start build
m lunaris
