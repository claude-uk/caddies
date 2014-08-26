// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function add_to_mylist_or_apply() {
    //collect entries from editor section
    newvalue = document.getElementById('newvalue').value.trim();
    c = document.getElementById('newcat_id');
    newcat = c.value;
    if (c.selectedIndex != '') {
      //newlabel = c.options[c.selectedIndex].text.substring(6);	//label_with_id version
      newlabel = c.options[c.selectedIndex].text.replace(/\.*\d+$/,'');	//label_plus_id version
      }
    else {
      newlabel = '';
      }
    //alert(newvalue + newcat + newlabel);
    //adding to table
    if (document.getElementById('entry_button').value == "Add to list") {
      //$('#sortable1 tbody').append('<tr><td>2</td><td>fred</td></tr>');
      html = '<tr class="ui-state-default" id="coderow_'
      html += newvalue
      html += '+'
      html += newcat
      html += '"><td>'
      html += newvalue
      html += '</td><td>'
      html += newlabel
      html += '</td><td>'
      html += newcat
      html += '</td><td class="islink"><a href="#" onclick="edit_row(this.parentNode.parentNode.rowIndex); return false;">Edit</a></td>'
      html += '<td class="islink"><a href="#" onclick="remove_from_mylist(this.parentNode.parentNode.id, this.parentNode.parentNode.rowIndex); return false;">Remove</a></td></tr>'
      $('#sortable1 tbody').append(html);
      document.getElementById('newvalue').value = '';
      document.getElementById('newcat_id').selectedIndex = ''
      }
    //else editing rows
    else {	//apply
      //edit cells
      index = document.getElementById('entry_mode').htmlFor;
      document.getElementById('sortable1').rows[index].cells[0].innerHTML = newvalue;
      c = document.getElementById('newcat_id');
      if (c.selectedIndex != '') {
        //document.getElementById('sortable1').rows[index].cells[1].innerHTML = c.selectedIndex;
        document.getElementById('sortable1').rows[index].cells[2].innerHTML = c.value;
        //document.getElementById('sortable1').rows[index].cells[2].innerHTML = c.options[c.selectedIndex].text.substring(6);
        document.getElementById('sortable1').rows[index].cells[1].innerHTML = c.options[c.selectedIndex].text.replace(/\.*\d+$/,'');
        }
      else {
        document.getElementById('sortable1').rows[index].cells[1].innerHTML = '';
        document.getElementById('sortable1').rows[index].cells[2].innerHTML = '';
        }
      //edit tr id
      //alert(document.getElementById('sortable1').rows[index].attributes.id.value)
      trid = document.getElementById('sortable1').rows[index].attributes.id.value
      vals = trid.split('+');
      vals[0] = 'coderow_' + newvalue;
      vals[1] = newcat;
      document.getElementById('sortable1').rows[index].attributes.id.value = vals.join("+");
      //alert(document.getElementById('sortable1').rows[index].attributes.id.value)
      //reset
      set_to_new_mode()
      }
}

function remove_from_mylist(trid, index) {
    //alert('Hooray!');
    trid = '' + trid;
    //alert(trid);
    //keep track of the rows to delete, if they were in the db
    vals = trid.split('+');
    //alert(vals);
    if (vals.length == 3) {
      sep = '';
      if (document.getElementById('deletables').value != '') {
        sep = ',';
        }
      document.getElementById('deletables').value += sep + vals[2];
      }
    document.getElementById('sortable1').deleteRow(index);
}

function edit_row(index) {
    //alert(index);
    set_to_edit_mode();
    document.getElementById('entry_mode').htmlFor = index;
    document.getElementById('newvalue').value = document.getElementById('sortable1').rows[index].cells[0].innerHTML;
    //document.getElementById('newcat_id').selectedIndex = document.getElementById('sortable1').rows[index].cells[1].innerHTML;
    //select by value
    sel = document.getElementById('newcat_id');
    val = document.getElementById('sortable1').rows[index].cells[2].innerHTML;
    for (i=0; i<sel.options.length; i++) {
      if (sel.options[i].value == val) {
	sel.selectedIndex = i;
        }
    }
}

function set_to_edit_mode() {
    //alert('set_to_edit_mode!');
    document.getElementById('entry_mode').innerHTML = 'Edit code';
    document.getElementById('entry_button').value = 'Apply';
    document.getElementById('reset_button').removeAttribute("disabled");
}

function set_to_new_mode() {
    //alert('set_to_new_mode!');
    document.getElementById('entry_mode').innerHTML = 'New code';
    document.getElementById('entry_button').value = 'Add to list';
    document.getElementById('newvalue').value = '';
    document.getElementById('newcat_id').selectedIndex = ''
    document.getElementById('entry_mode').htmlFor = '';
    document.getElementById('reset_button').setAttribute("disabled", "disabled");
}

//for IE
function getText( obj ) {
    return obj.textContent ? obj.textContent : obj.innerText;
}


function remove_from_rdalist(index) {
    alert(index);
    //document.getElementById('sortable1').deleteRow(index);
}

function remove_qirda_fields(link) {
    //alert($(link).value);
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".qirda_fields").hide();
}

function remove_unsaved(link) {
    //alert($(link).value);
    $(link).closest(".qirda_fields").remove();
}

function add_fields(link, content) {
  var new_id = new Date().getTime();
  $(link).up().insert({before: content.replace("new_qi_rda", new_id)});
}

//used in question items
//the separators are nbsp, I read the line as it was built ie with fixed widths
//see id_plus2 in response_domain_all.rb for the allocated widths
function add_to_qi_rda_list() {
    //collect entries from editor section
    c = document.getElementById('newrd_id');
    newrd = c.value;
    si = c.selectedIndex;
    if (si != '') {
      array_id = new Date().getTime();

      //newdata = [];      
      //newdata = c.options[c.selectedIndex].text.split(/\.+/g);
      //newlabel = newdata[newdata.length - 1];
      //newdomainid = newdata[newdata.length - 2];
      //newdomain = newdata[newdata.length - 3];
      //newrdallid = newdata[newdata.length - 4];
      newdata = c.options[c.selectedIndex].text
      newrdallid = newdata.substr(0, 4).trim()
      newdomain = newdata.substr(7, 9).trim()
      newdomainid = newdata.substr(16, 3).trim()
      newlabel = newdata.substr(19).trim()
      
    //alert(newrd + "+++" + newdomain + "+++" + newlabel);
//    html = '<tr class="new_qirda_fields"><td></td><td>';
      html = '<tr class="qirda_fields"><td></td><td>';
      html += '<input id="question_item_qi_rdas_attributes_';
      html += array_id;
      html += '_response_domain_all_id" name="question_item[qi_rdas_attributes][';
      html += array_id;
      html += '][response_domain_all_id]" readonly="readonly" size="6" type="text" value="';
      html += newrdallid;
//    html += "</td><td>";
      html += '" /></td><td>';
      html += newdomain;
      html += "</td><td>";
      html += newdomainid;
      html += "</td><td>";
      html += newlabel;
      html += "</td>";
//    html += '<td><a href="#" onclick="remove_unsaved(this); return false;">Remove</a>'
      html += '<td class="islink"><input id="question_item_qi_rdas_attributes_';
      html += array_id;
      html += '__destroy" name="question_item[qi_rdas_attributes][';
      html += array_id;
      html += '][_destroy]" type="hidden" value="false" /><a href="#" onclick="remove_unsaved(this); return false;">Remove</a>';
      html += "</td></tr>";
      $('#empty').before(html);
    }

}