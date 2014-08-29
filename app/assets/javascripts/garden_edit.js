(function(){
  'use strict';

  $(document).ready(init);

  function init(){

    $('.category_dropdown').change(function(){
      // render the varieties
      var category = $('.category_dropdown :selected').val();
      var url = "/categories/"+category+"/varieties";

      $.ajax({ url: url,
        type: "GET",
        dataType: "json",
        success: function(varieties){
            if(varieties.length) {
              $('#varieties_list').empty();
              varieties.forEach (function(variety){
                var variety_link = $("<a>");
                $(variety_link).attr("href", "#").append(variety.name);
                $('#varieties_list').append(variety_link);
              });
            }
            else {
              $('#varieties_list').append("<p>No varieties exist</p>")
            }
          }})
        });

  }

})();
