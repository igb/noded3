rm /tmp/group*.svg
node voronoi.js
xsltproc fill.xsl /tmp/foo1.svg > /tmp/baz.svg
xsltproc sep-prep.xsl  /tmp/groups.xml > /tmp/separations.sh
sh /tmp/separations.sh
