# Run Chef on a remote host
# Usage: run-remote.sh parshap@home.parshap.com
host=$1
attributes=$(cat attributes.json)

# Remote directory to copy files to
target=$(ssh $host mktemp -d)

# Build cookbooks
./build.sh

# Copy files to remote host
echo "Copying cookbooks to $host:$target"
tar czf - --exclude='.git' . | \
	ssh $host tar -xzf - --no-same-owner --no-same-permissions -C $target

# Execute on remote host
ssh $host <<EOF
	# Change directory to where files were copied
	cd $target

	# Bootstrap with Ruby and Chef
	./bootstrap.sh

	# Run chef-solo
	./solo.sh build '$attributes'

	# Remove files
	rm -rf $target
EOF
