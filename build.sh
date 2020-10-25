#
autoreconf -i
./configure
make
make dist
asciidoctor doc/menumaker.asc -o index.html
#