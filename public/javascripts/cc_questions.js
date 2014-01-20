//javascript for cc_questions

$(document).ready(function(){
  //alert("hello");
  //set up initial qitem/qgrid menus
  //alert(document.getElementById('cc_question_question_reference_type_questionitem').checked);
  if (document.getElementById('cc_question_question_reference_type_questionitem').checked == false){
    document.getElementById('qitem_id').value = 0;
    document.getElementById('qitem_id').disabled = true;
  }
  else {
    document.getElementById('qitem_id').value = document.getElementById('cc_question_question_reference_id').value;
    document.getElementById('qitem_id').disabled = false;
  }

  //alert(document.getElementById('cc_question_question_reference_type_questiongrid').checked);
  if (document.getElementById('cc_question_question_reference_type_questiongrid').checked == false){
    document.getElementById('qgrid_id').value = 0;
    document.getElementById('qgrid_id').disabled = true;
  }
  else {
    document.getElementById('qgrid_id').value = document.getElementById('cc_question_question_reference_id').value;
    document.getElementById('qgrid_id').disabled = false;
  }
  
  //manage radio button changes: enables/disables menus without changing values
  $("input[name='cc_question[question_reference_type]']").change(function() {
    if (document.getElementById('cc_question_question_reference_type_questionitem').checked == false){
      document.getElementById('qitem_id').disabled = true;
    }
    else {
      document.getElementById('qitem_id').disabled = false;
    }

    if (document.getElementById('cc_question_question_reference_type_questiongrid').checked == false){
      document.getElementById('qgrid_id').disabled = true;
    }
    else {
      document.getElementById('qgrid_id').disabled = false;
    }
  });

  //tranfer menu value to hidden value on (before) submit
  $("form").submit(function(){
    //alert("submitting");
    if (document.getElementById('qitem_id').disabled == false){
      document.getElementById('cc_question_question_reference_id').value = document.getElementById('qitem_id').value;
    }
    else if (document.getElementById('qgrid_id').disabled == false){
      document.getElementById('cc_question_question_reference_id').value = document.getElementById('qgrid_id').value;
    }
    //return false;	//if stop at that
  });

});



