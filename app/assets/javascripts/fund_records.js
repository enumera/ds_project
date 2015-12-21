
$(function () {

var items=[];
var maps = [
{"map" : Highcharts.maps['custom/world-continents'], "matcher": "hc-key"},
{"map": Highcharts.maps['custom/world'], "matcher": "hc-key"},
{"map" : Highcharts.maps['custom/asia'], "matcher": "hc-key"},
{"map" : Highcharts.maps['custom/europe'], "matcher": "hc-key"},
{"map" : Highcharts.maps['custom/north-america'], "matcher": "hc-key"}]

var mapDataToUse = maps[0]["map"];
var matcherToUse = maps[0]["matcher"]

$.getJSON("/", function(data){
       $.each(data, function(i, item){
         console.log(item);
         items.push(item)
        
       });
       console.log(items);
    // });



 // debugger;
    // Prepare demo data
    // var data = [
    //     {
    //         "hc-key": "eu",
    //         "value": 0
    //     },
    //     {
    //         "hc-key": "oc",
    //         "value": 1
    //     },
    //     {
    //         "hc-key": "af",
    //         "value": 2
    //     },
    //     {
    //         "hc-key": "as",
    //         "value": 3
    //     },
    //     {
    //         "hc-key": "na",
    //         "value": 4
    //     },
    //     {
    //         "hc-key": "sa",
    //         "value": 5
    //     }
    // ];

    // Initiate the chart
    $('#container').highcharts('Map', {

        title : {
            text : 'Highmaps basic demo'
        },

        subtitle : {
            text : 'Source map: <a href="https://code.highcharts.com/mapdata/custom/world-continents.js">World continents</a>'
        },

        mapNavigation: {
            enabled: true,
            buttonOptions: {
                verticalAlign: 'bottom'
            }
        },

        colorAxis: {
            min: 0
        },

        series : [{
            data : items,
            mapData: mapDataToUse,
            joinBy: matcherToUse,
            name: 'Funds in D1 and WR4 > 0',
            states: {
                hover: {
                    color: '#BADA55'
                }
            },
            dataLabels: {
                enabled: true,
                format: '{point.count}'
            }
        }]
    });
  });
});




