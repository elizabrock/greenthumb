(function(){
  $(document).ready(init);

  function init(){
    draggable();
    $('#save-garden').on('click',saveGarden);
  }

  function draggable(){
    var shape;
    var color;

    $( ".circle, .rectangle" ).draggable({
      start: function(){
        shape = this.classList[0];
        color = this.classList[1];
      },
      appendTo: "body",
      helper: "clone",
    });

    $( "#garden-plot" ).droppable({
      drop: function( event, element ) {
        var classes = element.draggable[0].classList;
        if ($.inArray('draggable', classes) !== -1) {
          console.log('stuff');
        } else {
          $( '<div class="' + shape + ' ' + color + ' draggable resizable"></div>' ).appendTo( this );
          $('.draggable').draggable({containment: "#garden", grid: [ 15, 15 ]});
          $( ".resizable" ).resizable({
            grid: 30,
            containment: "#garden-plot"
          });
        }
      }
    });
  }

  function saveGarden(event){
    event.preventDefault();
    var gardenId = $('#garden-plot').attr('data-id');
    var circles = $("#garden-plot").children(".circle").toArray();
    var rectangles = $("#garden-plot").children(".rectangle").toArray();
    var shapes = $('#garden-plot').children().toArray();
    
    circles.forEach(function(shape){
      var width = $(shape).css('width');
      var height = $(shape).css('height');
      var top = $(shape).css('top');
      var left = $(shape).css('left');
      var color = $(shape).css('background-color');

      $.ajax({
        type: "POST",
        url: '/gardens/'+gardenId+'/shapes',
        data: { type:"circle", width: width, height: height, top: top, left: left, color: color },
        dataType: 'json',
        error: function(res, message, err) {
          alert(message + " " + err);
        },
        success: function(msg) {
          $('body').prepend('<p>Your garden has been saved!</p>');
        }
      });
    });

    rectangles.forEach(function(shape){
      var width = $(shape).css('width');
      var height = $(shape).css('height');
      var top = $(shape).css('top');
      var left = $(shape).css('left');
      var color = $(shape).css('background-color');

      $.ajax({
        type: "POST",
        url: '/gardens/'+gardenId+'/shapes',
        data: { type:"rectangle", width: width, height: height, top: top, left: left, color: color },
        dataType: 'json',
        error: function(res, message, err) {
          alert(message + " " + err);
        },
        success: function(msg) {
          $('body').prepend('<p>Your garden has been saved!</p>');
        }
      });
    });
  }

})();
