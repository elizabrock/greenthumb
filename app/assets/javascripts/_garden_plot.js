$(function(){
  var shape;
  var color;

  $( ".circle, .rectangle" ).draggable({
    appendTo: "body",
    helper: "clone"
  });


  $( "#garden-plot" ).droppable({
    deactivate: function( event, ui ) {
      console.log(ui.position);
    },
    drop: function( event, ui ) {
      var $shape = ui.draggable
      var gardenId = $('#garden-plot').attr('data-id');
      var type = $shape.attr('data-type')
      var color = $shape.attr('data-color')
      var width = $shape.css('width').replace("px","");
      var height = $shape.css('height').replace("px","");
      var top = $shape.css('top');
      var left = $shape.css('left');

      var topPosition = ui.position.top - $('#garden-plot').position().top;
      topPosition -= (topPosition % 15)
      var leftPosition = ui.position.left - $('#garden-plot').position().left;
      leftPosition -= (leftPosition % 15)
      if(topPosition < 0){
        topPosition = 0;
      }
      if(leftPosition < 0){
        leftPosition = 0;
      }

      var classes = ui.draggable[0].classList;
      if ($.inArray('in-garden', classes) !== -1) {
        console.log('stuff');
      } else {
        $( '<div class="' + type.toLowerCase() + ' ' + color + ' in-garden" style="top:'+topPosition+'px;left:'+leftPosition+'px"></div>' ).appendTo( this );
        $('.in-garden').draggable({containment: "#garden-plot", grid: [ 15, 15 ]});
        $('.in-garden').resizable({
          grid: 30,
          containment: "#garden-plot"
        });
      }

      var form_params = { shape: { type: type, width: width, height: height, top: topPosition, left: leftPosition, color: color } };
      console.log(form_params);
      $.ajax({
        type: "POST",
        url: 'shapes',
        data: form_params,
        dataType: 'json'
      });
    }
  });
});
