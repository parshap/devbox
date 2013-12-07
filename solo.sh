# Run chef-solo with given path to cookbooks and json attributes
# Usage: solo.sh /tmp/cookbooks "$(cat attributes.json)"
cookbooks=$(readlink -f $1)
attributes=$2

# Create temp files for solo.rb and solo.json
rb=$(mktemp)
json=$(mktemp)

# Run chef-solo
echo "cookbook_path \"$cookbooks\"" > $rb
echo "$attributes" > $json
sudo chef-solo -c $rb -j $json

# Remove temp files
rm $rb $json
