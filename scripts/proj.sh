echo "creating proj structure"

mkdir res
mkdir doc
mkdir src
mkdir scripts

echo "proj structure created"

echo "init zk"
zk init "doc/"
touch doc/log.md
