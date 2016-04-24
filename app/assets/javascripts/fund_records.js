
$(function () {

// var mapWidth = $('#container').css("width");
// alert(mapWidth);
// $('#show_fund_details').css('width', mapWidth);

function collectFund(rowSelected){
    
    $this = rowSelected
    $this.toggleClass('selected');

    // var  selectedRow = $this;
    var td = $this.children('td');
    var fundDetails = [];

       for (var i = 0; i < td.length; ++i) {
        fundDetails.push(td[i].innerText);
        // alert(i + ': ' + td[i].innerText);
        }

    if($this.hasClass('selected')){
        
        $.getJSON("/funds/set_fund_selection/"+fundDetails[0], function(data){
           
        })

            $("table#selected_funds").append('<tr><td style="display:none;">' + fundDetails[1] +'<input type="hidden" name="fund_id"></td><td width="30%"><span class="glyphicon glyphicon-star-empty clickable-div blank-star"></span>' + fundDetails[1] +'</td><td width="25%" class="text-center">' + fundDetails[2] +'</td><td>' + fundDetails[3] +'</td><td width="20%">' + fundDetails[4] +'</td></tr>)')
       
    }else{
         $.getJSON("/funds/remove_fund_selection/"+fundDetails[0], function(data){})
        var tableRow = $("table#selected_funds td").filter(function() {
            return $(this).text() == fundDetails[0];
            }).closest("tr").remove();       
    };  
};

$(document.body).on("click", ".glyphicon-star-empty", function(){
    if($(this).hasClass("blank-star")){
        $(this).removeClass("blank-star");
        $(this).addClass("chosen-star");
   
        // console.log($(this).closest('tr'));
        collectFund($(this).closest('tr'));

    }else{
        $(this).removeClass("chosen-star");
        $(this).addClass("blank-star");
       
        collectFund($(this).closest('tr'));
    };
});



    $(document.body).on("click","#close_fund_panel", function(){
            $('#fund_details_show').removeClass("on_show");
            $('#fund_details_show').slideUp();
            $('#map_container').fadeIn();
    })


$(document.body).on("click", ".fund_details_row a.fund_details_link", function(){
        if($('#fund_details_show').hasClass("on_show")){
            // $('#fund_details_show').removeClass("on_show");
            // $('#fund_details_show').slideUp();
            //  $('#map_container').fadeIn();
            var fundDetails = $(this).attr("value");
          
            updateTable(fundDetails);
        }else{
            var fundDetails = $(this).attr("value");
          
            updateTable(fundDetails);
            $('#fund_details_show').addClass("on_show");
            $('#fund_details_show').slideDown();
            $('.fund_details_text').show();
            $('#map_container').fadeOut();
        };
    });


function updateTable(fundNo){
    console.log(fundNo)
    $.getJSON("/fund_records/"+fundNo, function(data){
        console.log("found data")
        console.log(data)
        $('#fund_name').text(data.fund_name);
        $('#fund_sector').text(data.sector);
        $('#fund_isin').text(data.isin);
      
        $('#rate4').text(data.wr4);
        $('#rate12').text(data.wr12);
        $('#rate26').text(data.wr26);
        $('#decile4').text(data.wd4);
        $('#decile12').text(data.wd12);
        $('#decile26').text(data.wd26);


        $('#decile_1').text(data.d1)
        $('#decile_2').text(data.d2)
        $('#decile_3').text(data.d3)
        $('#decile_4').text(data.d4)
        $('#decile_5').text(data.d5)
        $('#decile_6').text(data.d6)
        $('#decile_7').text(data.d7)
        $('#decile_8').text(data.d8)
        $('#decile_9').text(data.d9)
        $('#decile_10').text(data.d10)
        $('#decile_11').text(data.d11)
        $('#decile_12').text(data.d12)
    })


}


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


  if($("#continent").val() != undefined || $("#continent").val() != null ){
    var viewItem = $("#continent").val().toString();
    var searchString = $("#search_string").val().toString();
    var mapTitle = $("#map_title").val().toString();
    var mapSubTitle = $("#map_subtitle").val().toString();
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
        $('#map_container').highcharts('Map', {

            title : {
                text : mapTitle
            },

            subtitle : {
                text : mapSubTitle
            },

            mapNavigation: {
                enabled: true,
                enableButtons: false,
                enableMouseWheelZoom: false,
                enableTouchZoom: false,
                enableDoubleClickZoomTo: false,
                enableDoubleClickZoom: false
            },
            // colorAxis: {
            //     max: 40,
            //     type: 'logarithmic',
            //     minColor: '#efecf3',
            //     maxColor: '#990041'
            // },

         


             colorAxis: {
                        dataClassColor: 'mean',
                        dataClasses: [{
                            to: -15
                        }, {
                            from: -15,
                            to: -10
                        }, {
                            from: -10,
                            to: -5
                        }, {
                            from: -5,
                            to: 0
                        }, {
                            from: 0,
                            to: 5
                        }, {
                            from: 5,
                            to: 10
                        }, {
                            from: 10
                        }],
                        minColor: '#f2dede',
                        maxColor: '#dff0d8'
                    },

                 colors: ['rgba(242,222,222, 0.8)', 'rgba(242,222,222, 0.8)', 'rgba(242,222,222, 0.8)',
                        'rgba(217,237,247, 0.5)', 'rgba(217,237,247, 0.8)', 'rgba(223,240,216, 0.5)', 'rgba(223,240,216, 0.8)'],



            // colorAxis: {
            //     min: -15,
            //     minColor: '#f2dede',
            //     maxColor: '#dff0d8'

            // },

            series : [{
                data : items,
                mapData: mapDataToUse,
                joinBy: matcherToUse,
                name: 'Mean',
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
    };
});




