$(function(){
  var snapToGrid = function(item_value, grid_value){
    var adjusted_position = item_value - grid_value;
    adjusted_position -= (adjusted_position % 15)
    if(adjusted_position < 0){
      adjusted_position = 0;
    }
    return adjusted_position;
  }

  var applyDraggability = function($objects){
    $objects.draggable({containment: "#garden-plot", grid: [ 15, 15 ]});
    $objects.resizable({grid: 30, containment: "#garden-plot" });
  }

  var $garden_plot = $("#garden-plot");
  applyDraggability($garden_plot.find('.in-garden'));

  $( ".out-of-garden" ).draggable({
    appendTo: "body",
    helper: "clone"
  });

  $garden_plot.droppable({
    deactivate: function( event, ui ) {
      console.log(ui.position);
    },
    drop: function( event, ui ) {

      var classes = ui.draggable[0].classList;
      var shape_id;
      var gardenId = $('#garden-plot').attr('data-id');

      if ($.inArray('in-garden', classes) !== -1) {
        var $shape = ui.draggable;
        shape_id = $shape.attr('data-shape-id');
        var top = $shape.css('top');
        var left = $shape.css('left');

        console.log('A shape moved.');
        $shape.css('top', top + 'px');
        $shape.css('left', left + 'px');
        var form_params = { shape: { top: top, left: left } };
        $.ajax({
          type: "PUT",
          url: 'shapes/' + shape_id,
          data: form_params,
          dataType: 'json'
        });
      } else {
        var $shape = $('<div class="in-garden"></div>');
        var type = ui.draggable.attr('data-type')
        var color = ui.draggable.attr('data-color')
        var top = snapToGrid(ui.position.top, $garden_plot.position().top);
        var left = snapToGrid(ui.position.left, $garden_plot.position().left);
        $shape.css('top', top + 'px');
        $shape.css('left', left + 'px');
        $shape.addClass(type.toLowerCase());
        $shape.addClass(color);

        $shape.appendTo(this);
        applyDraggability($shape);

        var form_params = { shape: { type: type, top: top, left: left, color: color } };
        $.ajax({
          type: "POST",
          url: 'shapes',
          data: form_params,
          dataType: 'json'
        });
      }
    }
  });
});
