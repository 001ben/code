var dataset = [ 5, 10, 15, 20, 25 ];
var w = 500;
var h = 50;

var svg = d3
  .select('body')
  .append('svg')
  .attr('width', w)
  .attr('height', h);

svg.selectAll('circle')
  .data(dataset)
  .enter()
  .append('circle')
  .attr('cx', (d,i) => i*50 + 25)
  .attr('cy', h/2)
  .attr('r', d => d);
