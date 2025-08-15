rm -rf .repo/local_manifests build &&

repo init -u https://github.com/Lunaris-AOSP/android -b 16 --git-lfs &&

git clone -b lunaris https://github.com/MaheshTechnicals/local_manifests_miatoll .repo/local_manifests &&

/opt/crave/resync.sh &&

source build/envsetup.sh &&

lunch lineage_miatoll-bp2a-user &&

make installclean &&

m lunaris
