$(document).ready( function() {
  $("#my_tree").treeview();
  $("#my_tree2").treeview();

  /*
  //works as far as showing menu
  $("a").contextMenu('myMenu', function(event) {
    //event.preventDefault();
  });
  */
  
  /*
  //try bindings
  $("a").contextMenu('myMenu', {bindings: {
      'view': function(t) { alert('view requested');}
      }});
  */
  
  /*
  //try event info
  $("a").contextMenu('myMenu', {bindings: {
      'view': function(event) { alert(event);}
      }});
  */
  
  //try open
  $("a").contextMenu('myMenu', {bindings: {
      'view': function(event) { window.open(event, '_self');},
      'edit': function(event) { window.open(event + "/edit", '_self');}
      }});
  
});
