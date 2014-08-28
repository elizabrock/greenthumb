(function(){
  'use strict';

  $(document).ready(init);

  function init(){
    // $.ajax(url: "/categories/categoryid/varieties".done (html) ->
    //   $("#results").append html

    $('.category_dropdown').change(function(){
      // render the varieties
      var category = $('.category_dropdown :selected').val();
      var url = "/categories/"+category+"/varieties";

      $.ajax({ url: url,
        type: "GET",
        dataType: "json",
        success: function(varieties){
            $('#varieties_list').empty();

            varieties.forEach (function(variety){
              var variety_link = $("<a>");
              $(variety_link).attr("href", "#").append(variety.name);
              $('#varieties_list').append(variety_link);
            });
          }})
        });

  }

})();
