# Run Chef on local host
attributes=$(cat attributes.json)

# Build cookbooks
./build.sh

# Run chef-solo
./solo.sh build "$attributes"
