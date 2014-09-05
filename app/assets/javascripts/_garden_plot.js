$(function(){
  var shape;
  var color;

  $( ".circle, .rectangle" ).draggable({
    start: function(){
      shape = this.classList[0];
      color = this.classList[1];
      console.log(this.classList);
    },
    appendTo: "body",
    helper: "clone",
  });

  $( "#garden-plot" ).droppable({
    drop: function( event, ui ) {
      var $shape = ui.draggable
      var $dropped = $( '<div class="' + shape + ' ' + color + '"></div>' )
      $dropped.appendTo( this );
      $dropped.draggable({containment: "#garden-plot", grid: [ 15, 15 ]});
      $dropped.resizable({
        grid: 30,
        containment: "#garden-plot"
      });

      var gardenId = $('#garden-plot').attr('data-id');
      var width = $shape.css('width');
      var height = $shape.css('height');
      var top = $shape.css('top');
      var left = $shape.css('left');

      var form_params = { circle: { width: width, height: height, top: top, left: left, color: color } };
      console.log(form_params);
      $.ajax({
        type: "POST",
        url: 'shapes',
        data: form_params,
        dataType: 'json'
      });
      console.log('after post');
    }
  });
});
