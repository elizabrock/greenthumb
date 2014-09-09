$(function(){
  var grid_size = 15;

  var snapToGrid = function(item_value, grid_value){
    var adjusted_position = item_value - grid_value;
    adjusted_position -= (adjusted_position % grid_size)
    if(adjusted_position < 0){
      adjusted_position = 0;
    }
    return adjusted_position;
  }

  var updateShape = function($shape){
    var shape_id = $shape.attr('data-shape-id');
    var top = $shape.css('top');
    var left = $shape.css('left');
    var width = $shape.css('width').replace("px","");
    var height = $shape.css('height').replace("px","");
    var form_params = { shape: { top: top, left: left, width: width, height: height } };
    $.ajax({
      type: "PUT",
      url: 'shapes/' + shape_id,
      data: form_params,
      dataType: 'json'
    });
  }

  var applyDraggability = function($objects){
    $objects.draggable({containment: "#garden-plot", grid: [ grid_size, grid_size ]});
    $objects.resizable({
      grid: grid_size,
      containment: "#garden-plot",
      stop: function(event, ui){
        updateShape(ui.element);
      }
    });
  }

  var $garden_plot = $("#garden-plot");
  applyDraggability($garden_plot.find('.in-garden'));

  $( ".out-of-garden" ).draggable({
    appendTo: "body",
    helper: "clone"
  });

  $garden_plot.droppable({
    drop: function( event, ui ) {

      var classes = ui.draggable[0].classList;
      var gardenId = $('#garden-plot').attr('data-id');

      if ($.inArray('in-garden', classes) !== -1) {
        updateShape(ui.draggable);
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
