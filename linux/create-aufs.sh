#!/bin/bash

rm -Rf aufs3-standalone
# clone the aufs repository to the local disk
git clone git://aufs.git.sourceforge.net/gitroot/aufs/aufs3-standalone.git
cd aufs3-standalone
git branch -r
git checkout origin/aufs3.6

# modify what you want

# and after
# create the patch with the directories: fs, include and Documentation

rm -v $(find . -type f -name '*.orig')
grep -qse 'EXPORT_SYMBOL(' aufs3-standalone.patch && \
sed -i-old -e 's|EXPORT_SYMBOL(|EXPORT_SYMBOL_GPL(|' aufs3-standalone.patch
rm -rf ../tmp/linux-3.6
mkdir -p ../tmp/linux-3.6
cp -a fs ../tmp/linux-3.6
cp -a include ../tmp/linux-3.6
cp -a Documentation ../tmp/linux-3.6
rm ../tmp/linux-3.6/include/linux/Kbuild
cd ../tmp
diff -Naur null linux-3.6  | filterdiff | \
sed -e 's|null\(/include/linux/Kbuild\)|linux-3.6-old\1|;s|^--- null.*|--- /dev/null|;\|linux-3.6/include/linux/Kbuild|,${\|@@ -0,0 +1 @@|,$d}' \
| bzip2 > aufs$(sed -ne 's|#define.*AUFS_VERSION.*"\(.*\)"|\1|p'  linux-3.6/include/linux/aufs_type.h).patch.bz2
mv *.bz2 $OLDPWD
cd $OLDPWD
mv *patch* ..
cd ..
rm -rf tmp aufs3-standalone


# the patch is created in ../tmp
# the other patches needed to compile are in the base directory
