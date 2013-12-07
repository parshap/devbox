# Run Chef on local host
attributes=$(cat attributes.json)

# Bootstrap with Ruby and Chef
./bootstrap.sh

# Build cookbooks
./build.sh

# Run chef-solo
./solo.sh build "$attributes"
