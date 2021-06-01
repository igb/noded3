#CLEANUP IN CASE
rm /tmp/*.svg

#GENERATE OG SVG WITH D3.js
node voronoi.js


#APPLY COLOR GROUPS OR RANDOM PATTERNS OR WHATEVER
xsltproc fill.xsl /tmp/foo1.svg > /tmp/baz.svg


#SEPARATE COLOR GROUPS INTO DISTINCT SVGS FOR PEN PLOTTING
xsltproc sep-prep.xsl  /tmp/groups.xml > /tmp/separations.sh
sh /tmp/separations.sh


#apply hatches
xsltproc hatch-prep.xsl  /tmp/groups.xml > /tmp/crosshatch-script-gen.sh
sh /tmp/crosshatch-script-gen.sh > /tmp/crosshatch.sh
sh /tmp/crosshatch.sh



#CREATE HATCHES-ONLY SVGS
xsltproc post-prep.xsl  /tmp/groups.xml > /tmp/extract-hatches.sh
sh /tmp/extract-hatches.sh


#create outline obly svg
xsltproc outline.xsl /tmp/baz.svg > /tmp/outline.svg
