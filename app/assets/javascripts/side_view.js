$(function(){
  'use strict';

  var $sideView = $('#side-view'),
  $garden = $sideView.find('table'),
  $leftButton = $('#rotate_left'),
  $rightButton = $('#rotate_right'),
  $viewName = $sideView.find('h2 > span'),
  viewNames = ['Front', 'Right', 'Rear', 'Left'];

  $sideView.on('click', 'button', rotateSideView);

  function rotateSideView(){
    var view = $viewName.data('view');
    var direction = $(this).data('direction');
    switch(direction){
      case 'left':
        --view;
        break;
      case 'right':
        ++view;
        break;
    }

    var minView = 0,
    maxView = viewNames.length - 1;
    view = view < minView ? maxView :
      view > maxView ? minView : view;

    var gardenCssRotation = 'rotateX(60deg) rotateZ(' + view * 30 + 'deg)';
    console.log(gardenCssRotation);
    $garden.css({
      '-webkit-transform': gardenCssRotation,
      transform: gardenCssRotation
    });

    var viewName = viewNames[view];

    $viewName.data('view', view);
    $viewName.text(viewName);
  }

});
