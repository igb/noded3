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






var height = 594;
var width = 840;


var svg = d3n.createSVG(height,width)

    svg.append('g') // create SVG w/ 'g' tag and width/height


const d3 = d3n.d3;

var style = getStyle(linkStrokeColor, linkStrokeOpacity, polygonFillColor, polygonStrokeColor, polygonStrokeWidth, sitesFillColor, sitesStrokeColor, sitesFillOpacity, sitesStrokeOpacity);



svg.append('style').text(style);


var cellNo = 10; 

var description = "A voronoi tessellation, consisting of " + cellNo +  " cells, drawn upon a " + getColorDescription(polygonFillColor) + " field. The cell borders are drawn in a " + getColorDescription(polygonStrokeColor) + " stroke." + linksDescription;


var sites = d3.range(cellNo)
    .map(function(d) { return [Math.random() * width, Math.random() * height]; });


var test_sites = [
  [ 630.8595602048953, 510.33697385158604 ],
  [ 730.2801760670303, 479.19585434192595 ],
  [ 390.14775487422423, 413.27429799546627 ],
  [ 807.5905665163081, 94.70238667837747 ],
  [ 71.01538985563799, 278.18564832326115 ],
  [ 250.20764719769087, 190.77187716549125 ],
  [ 605.7404646536893, 230.06084932543465 ],
  [ 162.92975522845606, 476.7370246852805 ],
  [ 641.4883050641192, 310.99555562317454 ],
  [ 119.18467534622178, 580.3487864531318 ]
];

sites = test_sites;

var voronoi = d3.voronoi()
    .extent([[-1, -1], [width + 1, height + 1]]);


/*
console.log(voronoi.polygons(sites));
console.log(voronoi.links(sites));
console.log(sites);
*/
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

//coloring partitions
var links =  voronoi.links(sites);
var processed = new Array(sites.length);
var adjList = new Array(sites.length);
var colorGroups = new Array(sites.length);



console.log(sites);
console.log(links);


adjList.fill(-1);
colorGroups.fill(-1);
//  वहगत् ूप ो्रोमालमब तगेू
// BUILD THE ADJACENCY LIST

for (i = 0; i < sites.length; i++) {
    var site = sites[i];

    for (j = 0; j <links.length; j++) {
	if ( site == (links[j].source)) {
	    if (adjList[i] == -1) {
		adjList[i] = new Array();
	    }

	    adjList[i].push(links[j].target);
	}
    }
}



// group non-adacent sites/nodes/vertices

var colorGroupId = 0;
var edges = new Array();
var connectedNodes = new Array();

for (i = 0; i < sites.length; i++) {
    if (colorGroups[i]==-1) {
	colorGroupId++;
	colorGroups[i]=colorGroupId;

	var site = sites[i];

	
	for(var n = 0; n < adjList[i].length; n++) {
	    edges[n] = adjList[i][n]; 
	}

	for (j = 0; j < sites.length; j++) {
	    
	    if (j != i && colorGroups[j] == -1) {

		// is an edge of any sites seen so far
		var uncoloredSite = sites[j];

		// check to see if this as-of-yet uncolored site is
		// connected to sites in the current color group
		var isConnectedToColorGroup = false;
		for (k = 0; k < edges.length; k++) {
		    if(uncoloredSite == edges[k]) {
			isConnectedToColorGroup=true;
		    }
		}


		// we should now know if this node is connected
		// ...if it is NOT connected then...
		if (!isConnectedToColorGroup) {
		      
			// add this unconnected site to the current color group
			colorGroups[j]=colorGroupId;
			// get this new site's adjacent vertices to the "edge"
			// list in order to make sure 
			for(l=0; l < adjList[j].length; l++) {
			    edges.push(adjList[j][l]);
			}
		}
		

	    }

	}

    }

}



for (var i = 0; i <colorGroups.length; i++) {
    console.log(colorGroups[i]);
}





fs.writeFile("/tmp/foo1.svg", svg.node().outerHTML, function(err) {
	if(err) {
	    return console.log(err);
	}
	
    }); 









// console.log(d3n.svgString())
