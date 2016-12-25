//var dataset = [...new Array(25).keys()].map(i=>Math.round(i*Math.random()*15+15));
var dataset = [15, 21, 21, 45, 51, 37, 92, 65, 93, 55, 130, 144, 66, 162, 163, 239, 157, 164, 110, 65, 183, 147, 243, 121, 198]

d3.select('body').selectAll('div')
  .data(dataset)
  .enter()
  .append('div')
  .attr('class', 'bar')
  .style('height', d => d + 'px');
