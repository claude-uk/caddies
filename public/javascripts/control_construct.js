//javascript for control constructs


$(document).ready(function(){
  $(".parent_select").change(function() {
    //alert('changed1');
    set_sibling_options();
  });
  $("input:checkbox").change(function() {
    //there is redundant code in that I don't need to check the type of the parent in this case, but ok
    set_sibling_options();
  });
});

function set_sibling_options() {
  //needs to work with any construct, selection by class instead of id
  //read parent values
  p = $(".parent_select")[0];
  pid = p.value;
  parent_type = p.options[p.selectedIndex].text.substring(6, 22);	//from-to up to start of next text
  parent_type = parent_type.trim();
  //alert('+++' + parent_type + '+++');

  if (parent_type == 'CcIfthenelse') {
    //nb it is read as checked whether enabled or not
    if ($("input:checkbox").is(':checked')) {
      pid += "_1";
    }
    else {
      pid += "_0";
    }
  }

  //enable or disable checkbox
  if (parent_type == 'CcIfthenelse') {
    //alert('+++#' + parent_type + '#+++');
    $("input:checkbox").removeAttr('disabled');
  }
  else {
    $("input:checkbox").attr('disabled', 'disabled');
  }

  //alert('+++' + pid + '+++');
  
  //set sibling options
  selector = "#all_options > optgroup[label='" + pid + "'] > option"
  //alert('+++' + selector + '+++');
  new_options = $("#all_options > optgroup[label='" + pid + "'] > option").clone();
  //keep the prompt option
  //nb: if the selection is empty, I cannot use replaceWith
  //$(".sib_select>option:not(:first)").replaceWith(new_options);
  $(".sib_select>option:not(:first)").remove();
  $(".sib_select>option").after(new_options);
}

