#! /bin/bash
JAVA_VERSION="11"
JDKS=($(ls -dr /lib/jvm/java-$JAVA_VERSION-openjdk-amd64/))
if [ "${#JDKS[@]}" -lt "1" ]; then
    cmd="sudo apt install openjdk-$JAVA_VERSION-jdk"
    echo $cmd
    $cmd
fi
cmd="export JAVA_HOME=${JDKS[0]}"
echo $cmd
$cmd
export PATH=$JAVA_HOME/bin:$ANDROID_HOME/cmdline-tools/tools/bin:$PATH

WD=$(dirname "$(readlink -f "$0")")
echo "change directory to $WD"
cd $WD
DEV_TOOLS=$(realpath ../DevTools)
ANDROID=$DEV_TOOLS/Android
( [ -d $ANDROID ] || ! echo "$ANDROID cannot be found" ) || exit 1
cd android
PROP=local.properties
[[ -f $PROP.backup ]] || mv $PROP $PROP.backup
cat > $PROP << EOF
sdk.dir=$ANDROID
ndk.dir=$ANDROID/ndk-bundle
org.gradle.configureondemand=true
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.workers.max=$(($(nproc)-1))
EOF
./gradlew build
