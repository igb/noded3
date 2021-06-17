use_cmyk=false
while getopts :hc opt; do
    case $opt in
	h) echo "use -c to enable CMYK separations"; exit ;;
	c) use_cmyk=true ;;
	:) echo "Missing argument for option -$OPTARG"; exit 1;;
	\?) echo "Unknown option -$OPTARG"; exit 1;;
    esac
done

shift $(( OPTIND - 1 ))




#CLEANUP IN CASE
rm /tmp/*.svg
rm -rf /tmp/c
rm -rf /tmp/m
rm -rf /tmp/y
rm -rf /tmp/k

#GENERATE OG SVG WITH D3.js
node voronoi.js


#APPLY COLOR GROUPS OR RANDOM PATTERNS OR WHATEVER
xsltproc fill.xsl /tmp/foo1.svg > /tmp/baz.svg


#SEPARATE COLOR GROUPS INTO DISTINCT SVGS FOR PEN PLOTTING
xsltproc sep-prep.xsl  /tmp/groups.xml > /tmp/separations.sh
sh /tmp/separations.sh

if $use_cmyk; then

    xsltproc cmyk-separations.xsl /tmp/groups.xml > /tmp/cmyk-gen.sh
    sh /tmp/cmyk-gen.sh > /tmp/cmyk.sh
    sh /tmp/cmyk.sh

    mkdir /tmp/c /tmp/m /tmp/y /tmp/k
    cp /tmp/hatch*-c-*.svg /tmp/c/
    cp /tmp/hatch*-m-*.svg /tmp/m/
    cp /tmp/hatch*-y-*.svg /tmp/y/
    cp /tmp/hatch*-k-*.svg /tmp/k/
    
else

    #apply hatches
    xsltproc hatch-prep.xsl  /tmp/groups.xml > /tmp/crosshatch-script-gen.sh
    sh /tmp/crosshatch-script-gen.sh > /tmp/crosshatch.sh
    sh /tmp/crosshatch.sh


    
    #CREATE HATCHES-ONLY SVGS
    xsltproc post-prep.xsl  /tmp/groups.xml > /tmp/extract-hatches.sh
    sh /tmp/extract-hatches.sh
    

    
fi



#create outline obly svg
xsltproc outline.xsl /tmp/baz.svg > /tmp/outline.svg
