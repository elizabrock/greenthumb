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

    $( "#garden" ).droppable({
      drop: function( event, element ) {
        var classes = element.draggable[0].classList;
        if ($.inArray('draggable', classes) !== -1) {
          console.log('stuff');
        } else {
          $( '<div class="' + shape + ' ' + color + ' draggable resizable"></div>' ).appendTo( this );
          $('.draggable').draggable({containment: "#garden", grid: [ 15, 15 ]});
          $( ".resizable" ).resizable({
            grid: 30,
            containment: "#garden"
          });
        }
      }
    });
  }

  function saveGarden(event){
    event.preventDefault();
    var circles = $("#garden").children(".circle").toArray();
    var rectangles = $("#garden").children(".rectangle").toArray();
    circles.forEach(function(){
      g
    });
    rectangles.forEach(function(){

    })
  }

})();
