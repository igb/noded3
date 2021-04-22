var fs = require('fs');
var svg_to_png = require('svg-to-png');

eval(fs.readFileSync('style.js', 'utf8'));
eval(fs.readFileSync('colorbrewer.js', 'utf8'));
eval(fs.readFileSync('ntc.js', 'utf8'));


const D3Node = require('d3-node')
const d3n = new D3Node()      // initializes D3 with container element


var swatches = [Blues, Greens, Greys, Oranges, Purples, Reds, BuGn, BuPu, GnBu, OrRd, PuBu, PuBuGn, PuRd, RdPu, YlGn, YlGnBu, YlOrBr, YlOrRd, BrBG, PiYG, PRGn, PuOr, RdBu, RdGy, RdYlBu, RdYlGn, Spectral,Paired, Set3 ];



var swatch =  swatches[Math.floor(Math.random() * (swatches.length))]; 


var linkStrokeColor = swatch[Math.floor(Math.random() * (swatch.length))];
var linkStrokeOpacity = "1.0";

var polygonFillColor = swatch[Math.floor(Math.random() * (swatch.length))];
var polygonStrokeColor = swatch[Math.floor(Math.random() * (swatch.length))];
while (polygonFillColor == polygonStrokeColor) {
    polygonStrokeColor = swatch[Math.floor(Math.random() * (swatch.length))];
}
var polygonStrokeWidth = Math.floor(Math.random() * (6) + 1) + "px";
var sitesFillColor, sitesStrokeColor  = swatch[Math.floor(Math.random() * (swatch.length))];
var sitesFillOpacity, sitesStrokeOpacity = "1.0";




function convertRgbToHex(rgb) { 

    var hex = Number(rgb).toString(16);
    if (hex.length < 2) {
	hex = "0" + hex;
    }
    return hex.toUpperCase();
};

function getHexFromRgbString(rgbString) {
    var color = rgbString.substr(4, rgbString.length - 5).split(",");
    return "#" + convertRgbToHex(color[0]) + convertRgbToHex(color[1]) + convertRgbToHex(color[2]);  
}


function getColorDescription(color) {
    var hex = getHexFromRgbString(color);
    return ntc.name(hex)[1].toLowerCase().replace(/ /g, "-") + "-colored (" + hex  + ")";
}


var linksDescription = "";

if ( Math.floor(Math.random() * (2)) == 0  ) {
    linkStrokeOpacity = "0.0";
    sitesFillOpacity, sitesStrokeOpacity = "0.0";
   
   
    
} else {
    linksDescription = " This particular tessellation shows the " + getColorDescription(sitesStrokeColor) + " points (or 'sites') around which the voronoi tiles are formed with edges, drawn in a " + getColorDescription(linkStrokeColor)+ " stroke, connecting each point to it's closest neighbors."  
	}






var height = 800;
var width = 1100;


var svg = d3n.createSVG(height,width)

    svg.append('g') // create SVG w/ 'g' tag and width/height


const d3 = d3n.d3;

/*var svg = d3n.svgString() // output: <svg width=10 heig

var svg = d3.select(document.body).append('svg')
    .attr('xmlns', 'http://www.w3.org/2000/svg')
        .attr('height', height)
    .attr('width', width);
*/
var style = getStyle(linkStrokeColor, linkStrokeOpacity, polygonFillColor, polygonStrokeColor, polygonStrokeWidth, sitesFillColor, sitesStrokeColor, sitesFillOpacity, sitesStrokeOpacity);



svg.append('style').text(style);
//var cellNo = Math.floor(Math.random() * 1000 ) +  10;

var cellNo = 180; 

var description = "A voronoi tessellation, consisting of " + cellNo +  " cells, drawn upon a " + getColorDescription(polygonFillColor) + " field. The cell borders are drawn in a " + getColorDescription(polygonStrokeColor) + " stroke." + linksDescription;


var sites = d3.range(cellNo)
    .map(function(d) { return [Math.random() * width, Math.random() * height]; });

var voronoi = d3.voronoi()
    .extent([[-1, -1], [width + 1, height + 1]]);

var polygon = svg.append("g")
    .attr("class", "polygons")
  .selectAll("path")
  .data(voronoi.polygons(sites))
  .enter().append("path")
    .call(redrawPolygon);

var link = svg.append("g")
    .attr("class", "links")
  .selectAll("line")
  .data(voronoi.links(sites))
  .enter().append("line")
    .call(redrawLink);

var site = svg.append("g")
    .attr("class", "sites")
  .selectAll("circle")
  .data(sites)
  .enter().append("circle")
    .attr("r", 2.5)
    .call(redrawSite);


function redrawPolygon(polygon) {
    polygon
	.attr("d", function(d) { return d ? "M" + d.join("L") + "Z" : null; });
}

function redrawLink(link) {
    link
	.attr("x1", function(d) { return d.source[0]; })
	.attr("y1", function(d) { return d.source[1]; })
	.attr("x2", function(d) { return d.target[0]; })
	.attr("y2", function(d) { return d.target[1]; });
}

function redrawSite(site) {
    site
	.attr("cx", function(d) { return d[0]; })
	.attr("cy", function(d) { return d[1]; });
}






fs.writeFile("/tmp/foo1.svg", svg.node().outerHTML, function(err) {
	if(err) {
	    return console.log(err);
	}
	
    }); 





svg_to_png.convert("/tmp/foo1.svg", "/tmp/") // async, returns promise 
    .then( function(){
	    console.log(description.substr(0, 420));
	});





console.log(d3n.svgString())
