WD=$(dirname "$(readlink -f "$0")")
echo "change directory to $WD"
cd $WD
cd android
./gradlew clean
cd ..
rm build -rf
rm build_ -rf
