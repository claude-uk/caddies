//javascript for code_schemes


//not sure if still required, don't know where it is used
//  $(document).ready(function() {
//    $("input#autocomplete").autocomplete({
//    source: document.getElementById('catmenu').value.split(",")
//    });
//  });

//was in application.js
$(document).ready(function(){
  //alert("hello");
  $( "#sortable1 tbody" ).sortable({axis: "y",}).disableSelection();
  document.getElementById('newvalue').value = '';
  document.getElementById('newcat_id').value = '';
  document.getElementById('deletables').value = '';
  //$("#edit_code_scheme_2").on('submit', function() {
  //$('#sortable1').on('change', function(event){
  $('#code_scheme_submit').click(function(event){
    //var series = $("#sortable1 tbody").sortable('serialize',{key:'string'});
    var series = $("#sortable1 tbody").sortable('serialize');
    document.getElementById('code_table').value = series;
    //alert(series);
  });
});

