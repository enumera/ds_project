
$(function () {




$(document.body).on("click", ".glyphicon-star-empty", function(){
    if($(this).hasClass("blank-star")){
        $(this).removeClass("blank-star");
        $(this).addClass("chosen-star");

    }else{
        $(this).removeClass("chosen-star");
        $(this).addClass("blank-star");

    };
});


    // Manages the selection of funds by the user

    $(document.body).on("click",'tr', function () {
        $(this).toggleClass('selected');
        var  selectedRow = $(this);
        var td = $(selectedRow).children('td');
        var fundDetails = [];

           for (var i = 0; i < td.length; ++i) {
            fundDetails.push(td[i].innerText);
            // alert(i + ': ' + td[i].innerText);
            }

        if($(this).hasClass('selected')){
     
        $("table#selected_funds").append('<tr><td style="display:none;">' + fundDetails[0] +'</td><td><span class="glyphicon glyphicon-star-empty clickable-div blank-star"></span>' + fundDetails[1] +'</td><td class="text-center">' + fundDetails[2] +'</td><td>' + fundDetails[3] +'</td><td>' + fundDetails[4] +'</td></tr>)')


        }else{
         
            var tableRow = $("table#selected_funds td").filter(function() {
                return $(this).text() == fundDetails[0];
                }).closest("tr").remove();       
        };
    });







$(document.body).on("change", ".sl_group", function(){
    // console.log($(this))
    // alert($(this).val())
    // alert($(this).is(':checked'))


    if($(this).val()!= "1" && $(this).is(':checked')){
        if($(".sl_group[value='1']").is(':checked')){
  
            $(".sl_group[value='1']").attr("checked", false);
        };
    }else if($(this).val()== "1" && $(this).is(':checked')){
            // $(".sl_group").attr("checked", false);
            $(".sl_group[value='2']").attr("checked", false);
            $(".sl_group[value='3']").attr("checked", false);
            $(".sl_group[value='4']").attr("checked", false);
            $(".sl_group[value='5']").attr("checked", false);
            $(".sl_group[value='6']").attr("checked", false);
            $(".sl_group[value='7']").attr("checked", false);
    };
})



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




