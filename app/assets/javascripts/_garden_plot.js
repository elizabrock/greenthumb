$(function(){
  var shape;
  var color;

  $( ".circle, .rectangle" ).draggable({
    start: function(){
      shape = this.classList[0];
      color = this.classList[1];
    },
    appendTo: "body",
    helper: "clone"
  });


  $( "#garden-plot" ).droppable({
    deactivate: function( event, ui ) {
      console.log(ui.position);
    },
    drop: function( event, ui ) {
      var $shape = ui.draggable
      var topPosition = ui.position.top - $('#garden-plot').position().top;
      topPosition -= (topPosition % 15)
      var leftPosition = ui.position.left - $('#garden-plot').position().left;
      leftPosition -= (leftPosition % 15)
      // var zIndex = $('#garden-plot').children().size();

      var classes = ui.draggable[0].classList;
      if ($.inArray('in-garden', classes) !== -1) {
        console.log('stuff');
      } else {
        $( '<div class="' + shape + ' ' + color + ' in-garden" style="top:'+topPosition+'px;left:'+leftPosition+'px;"></div>' ).appendTo( this );
        $('.in-garden').draggable({containment: "#garden-plot", grid: [ 15, 15 ]});
        $( '.in-garden' ).resizable({
          grid: 30,
          containment: "#garden-plot"
        });
      }
 
      // var $dropped = $( '<div class="' + shape + ' ' + color + ' in-garden" style="top:'+topPosition+'px;left:'+leftPosition+'px;"></div>' );
      // $("#garden-plot").append($dropped);
      // $('.in-garden').draggable({containment: "#garden-plot", grid: [ 15, 15 ]});
      // $('.in-garden').resizable({
      //   grid: 30,
      //   containment: "#garden-plot"
      // });

      var gardenId = $('#garden-plot').attr('data-id');
      var width = $shape.css('width');
      var height = $shape.css('height');
      var top = $shape.css('top');
      var left = $shape.css('left');

      var form_params = { circle: { width: width, height: height, top: top, left: left, color: color } };
      $.ajax({
        type: "POST",
        url: 'shapes',
        data: form_params,
        dataType: 'json'
      });
    }
  });
});
