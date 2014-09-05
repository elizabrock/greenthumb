(function(){
  'use strict';

  $(document).ready(init);

  function init(){

    $('.category_dropdown').change(function(){
      // render the varieties
      var category = $('.category_dropdown :selected').val();
      var url = "/api/categories/"+category+"/varieties";
      $.ajax({ url: url,
        type: "GET",
        dataType: "html",
        success: function(html){
          $('#varieties_list').replaceWith(html);
        }
      });
    });
  }
})();
