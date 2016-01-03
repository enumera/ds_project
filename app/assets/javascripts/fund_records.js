
$(function () {





 


  $('[data-toggle="tooltip"]').tooltip()

var viewItem = $("#continent").val().toString();
var searchString = $("#search_string").val().toString();
var mapTitle = $("#map_title").val().toString();
var things = $("#things").data('stats');


var items=[];
var maps = [
{"map": Highcharts.maps['custom/world-continents'], "matcher": "hc-key"},
{"map": Highcharts.maps['custom/world'], "matcher": "hc-key"},
{"map": Highcharts.maps['custom/asia'], "matcher": "hc-key"},
{"map": Highcharts.maps['custom/europe'], "matcher": "hc-key"},
{"map": Highcharts.maps['custom/north-america-no-central'], "matcher": "hc-key"}]



var items=[];


       $.each(things, function(i, item){
         // console.log(item);
         if(item.region != "none"){
            items.push(item)
        };
        
       });
       console.log(items);
       // alert(viewItem);
if(viewItem == "Asia"){
    // debugger;
        var mapDataToUse = maps[2]["map"];
        var matcherToUse = maps[2]["matcher"];
    }else if(viewItem == "Europe"){
        var mapDataToUse = maps[3]["map"];
        var matcherToUse = maps[3]["matcher"]
    }else if(viewItem == "North America") {
        var mapDataToUse = maps[4]["map"];
        var matcherToUse = maps[4]["matcher"]
    }else{

        var mapDataToUse = maps[0]["map"];
        var matcherToUse = maps[0]["matcher"]
    };

  

    // Initiate the chart
    $('#container').highcharts('Map', {

        title : {
            text : mapTitle
        },

        // subtitle : {
        //     text : 'Source map: <a href="https://code.highcharts.com/mapdata/custom/world-continents.js">World continents</a>'
        // },

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
            name: 'No. of fund in area',
            states: {
                hover: {
                    color: '#BADA55'
                }
            },
            dataLabels: {
                enabled: true,
                format: '{point.mean}'
            }
        }]
    });

});




