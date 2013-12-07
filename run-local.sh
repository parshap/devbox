# Run Chef on local host
attributes=$(cat attributes.json)

# Clean build files
rm -rf ./build

# Build cookbooks
./build.sh

# Run chef-solo
./solo.sh build "$attributes"
