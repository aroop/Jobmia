// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var sectionInUse = "";
function getBrowserWidth()
{
	if (navigator.userAgent.indexOf("MSIE") > 0)
		return(document.body.offsetWidth);
	else
		return window.outerWidth;
}

function getBrowserHeight()
{
	if (navigator.userAgent.indexOf("MSIE") > 0)
		return(document.documentElement.clientHeight);
	else
		return(window.outerHeight);
}

function launch(file, name, width, height, showMenus, showScrollbars)
{
	var X = getBrowserWidth() / 2;
	var Y = getBrowserHeight() / 2;
	if (showMenus == null)
		showMenus="no";
	if (showScrollbars == null)
		showScrollbars="yes";
	if (width == null)
		width = getBrowserWidth() - 100;
	if (height == null)
		height = getBrowserHeight() - 100;

	var string= "top=" + (window.screenTop + (Y - (height/2))) + ",left=" + (window.screenLeft + (X - (width/2)))  + ",width=" + width + ",height=" + height + ",toolbar=no,scrollbars=" + showScrollbars + ",directories=no,menubar=" + showMenus + ",resizable=yes,dependent=yes";
	if (name != null)
		name = name.replace(" ", "_");
	else
		name = "newWindow";

	var hwnd = window.open(file, name, string);
	if (window.focus)
		hwnd.focus();

}

function checkAll(container, check) {
  var objects = $(container).getElementsByTagName("input"); //all input objects
  for (i=0; i<objects.length;i++) { //start for loop
    if (objects[i].getAttribute("type")=="checkbox"){
      objects[i].checked = check;
    }
  }
} 

function check_box_selected(checkBox, message) {
  if (!checkBox.checked){
    alert(message); 
    return false;
  }
  return true;
}

function section_mouseover(field) {
	if (sectionInUse == ""){
		$(field).className = "resume_section_hover";
	}
}

function section_mouseout(field) {
	if (sectionInUse == ""){
		$(field).className = "resume_section";
	}
}

function entry_mouseover(field, entry_id) {
	if (sectionInUse == ""){
		$(field).className = "entry_multi_hover";
		$('removeEntrylink_'+entry_id).style.visibility="visible";
	}
}

function entry_mouseout(field, entry_id) {
	if (sectionInUse == ""){
		$(field).className = "entry_multi";
		$('removeEntrylink_'+entry_id).style.visibility="hidden";
	}
}

function setDefaultText(choose_field, text_field, message, focus_object){
	if ($(choose_field).value == "Other"){
		$(text_field).value =message;
		$(text_field).focus();
		$(text_field).select();
	} else {
		$(text_field).value = $(choose_field).value;
		$(focus_object).focus();
		$(focus_object).select();
	}
}

function changeHiddenValue(choose_field, hidden_field){
	$(hidden_field).value = $(choose_field).value;
}

function shouldSubmitRequest(field){
	if ($(field).value == ""){
		return false;
	} else {
		return true;
	}
}

function reorderSections(){
	if(sectionInUse == ""){
		sectionInUse = "move";
		$("reorderSectionsLink").lastChild.nodeValue = "Done with re-ordering";		
	  collapseSections();
	  changeElementsClass("container", "div", "resume_section", "resume_move_section");
		Sortable.create("container", 
				{onUpdate:function(){new Ajax.Request('/resumes/1/order_section', {method: 'post', asynchronous:true, evalScripts:true, parameters:Sortable.serialize("container")});}, tag:'div'});
	} else {
		$("reorderSectionsLink").lastChild.nodeValue = "Re-order Sections";
		sectionInUse = "";
		changeElementsClass("container", "div", "resume_move_section", "resume_section");
		expandSections();
		Sortable.destroy("container");
	}
}

function collapseSections() {
	var root = $("container");
	var divs = root.getElementsByTagName("div");
	var i;

	for (i = 0; i < divs.length; i++) {
		if(divs[i].className != "resume_section") continue;
		if(divs[i].style.height == "") {
			divs[i].expr = divs[i].offsetHeight-10;
			divs[i].style.height = divs[i].offsetHeight;
			divs[i].style.overflow = "hidden";
		}
	 	divs[i].style.height = "30px";
	 }
}

function expandSections() {
	var root = $("container");
	var divs = root.getElementsByTagName("div");
	var i;
	
	for (i = 0; i < divs.length; i++) {
		if(divs[i].className != "resume_section") continue;
			divs[i].style.overflow = "";
			divs[i].style.height = divs[i].expr-10+"px";
			divs[i].style.height = null;
			divs[i].expr = "";
	}
}

function changeElementsClass(container, tag, from, to){
		var root = $(container);
		var divs = root.getElementsByTagName(tag);
		var i;
	  for (i = 0; i < divs.length; i++) {
			if(divs[i].className != from) {
				continue;
			} else {
				divs[i].className=to;
			}
		 }	
}

function reorderEntries(section, section_id){
	if(sectionInUse == ""){
		sectionInUse = "move";
		$('entryReorder'+section_id).lastChild.nodeValue = "Save Placement";		
	  collapseEntries(section);
	  changeElementsClass(section, "div", "entry_multi", "entry_multi_move");
	  disableFields(section);
		Sortable.create(section, 
				{onUpdate:function(){
					new Ajax.Request('/resumes/1/order_entries', 
						{method: 'post', asynchronous:true, evalScripts:true, parameters:Sortable.serialize(section)}
					);
				}, 
				tag:'div'});
	} else {
		sectionInUse = "";
		enableFields(section);
		$('entryReorder'+section_id).lastChild.nodeValue = "Re-order Entries";		
		changeElementsClass(section, "div", "entry_multi_move", "entry_multi");
		expandEntries(section);
		Sortable.destroy(section);
	}
}

function disableFields(container){
	var root = $(container);
	var texts = root.getElementsByTagName("input");
	var labels = root.getElementsByTagName("label");
	for (i = 0; i < texts.length; i++) {
		if(texts[i].type != "text") continue;
		texts[i].disabled="disabled";
	}
	for (i = 0; i < labels.length; i++) {
		labels[i].style.cursor = "move";
	}
}

function enableFields(container){
	var root = $(container);
	var texts = root.getElementsByTagName("input");
	var labels = root.getElementsByTagName("label");
	for (i = 0; i < texts.length; i++) {
		if(texts[i].type != "text") continue;
		texts[i].disabled="";
	}
	for (i = 0; i < labels.length; i++) {
		labels[i].style.cursor = "default";
	}	
}

function collapseEntries(section) {
	var root = $(section);
	var divs = root.getElementsByTagName("div");
	var i;

	for (i = 0; i < divs.length; i++) {
		if(divs[i].className != "entry_multi") continue;
		if(divs[i].style.height == "") {
			divs[i].expr = divs[i].offsetHeight-10;
			divs[i].style.height = divs[i].offsetHeight;
			divs[i].style.overflow = "hidden";
		}
	 	divs[i].style.height = "65px";
	 }
}

function expandEntries(section) {
	var root = $(section);
	var divs = root.getElementsByTagName("div");
	var i;
	
	for (i = 0; i < divs.length; i++) {
		if(divs[i].className != "entry_multi") continue;
			divs[i].style.overflow = "";
			divs[i].style.height = divs[i].expr-10+"px";
			divs[i].style.height = null;
			divs[i].expr = "";
	}
}

function setAttachType(id) {
 clearAttachType();
 $('resumeopt_att').checked="checked";
 $(id).className = "current";
 $('resume_type').value = id;
}

function clearAttachType() {
 $("doc").className = "";
 $("pdf").className = "";
 $("rtf").className = "";
 $("html").className = "";
 $("txt").className = "";
 $('resume_type').value = "";
}

//Methods used in Friends module
function addContact(element){
	var id = $(element).id;
	var liContact = $li($(element).title);
	liContact.id = 'selected_'+id;
	liContact.observe('click', removeContactFromSelection);
	$('selected-list-ul').appendChild(liContact);
	$('selected_contacts_info').style.display = "none";
	if (($('contacts_list').select('input[type=checkbox]').size()+1) == $('selected-list-ul').select('li').size())
		$('select_all_checkbox').checked = "checked";
}

function removeContact(element){
	var id = $(element).id;
	$('selected_'+id).remove();
	$('select_all_checkbox').checked = "";
	if ($('selected-list-ul').select('li').size() == 1)
		$('selected_contacts_info').style.display = "block";
}

function addAllContacts(){
	$('selected_contacts_info').style.display = "none";
	$('contacts_list').select('input[type=checkbox]').each(function(element) {
		element.checked = "checked";
		setContactStyle(element);
		var id = $(element).id;
		var liContact = $li($(element).title);
		liContact.id = 'selected_'+id;
		liContact.observe('click', removeContactFromSelection);
		$('selected-list-ul').appendChild(liContact);
	});	
}

function removeAllSelectedContacts(){
	$('contacts_list').select('input[type=checkbox]').each(function(element) {
		if (element.checked){
			removeContact(element);
			element.checked = "";
			setContactStyle(element);
		}
	});
	$('selected_contacts_info').style.display = "block";
}

function setContactStyle(element){
	var id = $(element).id;
	$('li_'+id)[$(id).checked? 'addClassName' : 'removeClassName']('hilite');
}

function removeContactFromSelection(){
	var id = $(this).id.gsub("selected_", "");
	$(id).checked = "";
	removeContact(id);
	setContactStyle(id);
}

function enableField(field, fieldType){
	$(field).removeClassName('fieldSpan');
	$(field).addClassName('fieldSpanEnabled');
	if (fieldType == 'a'){
		$(field).removeClassName('field_textArea');
	} else{
		$(field).removeClassName('field_text');		
	}	
}

function disableField(field, fieldType){
	$(field).removeClassName('fieldSpanEnabled');
	$(field).addClassName('fieldSpan');
	if (fieldType == 'a'){
		$(field).addClassName('field_textArea');
	} else{
		$(field).addClassName('field_text');		
	}
}

function showSectionTools(toolsID){
	if (sectionInUse == ""){
		$(toolsID).style.display = "block";
	}
}

function hideSectionTools(toolsID){
	$(toolsID).style.display = "none";
}

function event_mouseover(field) {
	if ($(field).className != "event_selected"){
		$(field).className = "event_teaser_hover";
	}
}

function event_mouseout(field) {
	if ($(field).className != "event_selected"){
		$(field).className = "event_teaser";
	}
}

function event_selected(field){
	$("events").select('div').each(function(element) {
		element.className = "event_teaser";
	});	
	$(field).className = "event_selected";
	var id = $(field).id.gsub("event", "");
	new Ajax.Request('/resumes/get_event_info/'+id, {asynchronous:true, evalScripts:true}); 
	return false;
}

function show_status(text){
	$("status").firstChild.nodeValue = text;
	$("status").style.top = (document.viewport.getHeight() - 50)+"px";
	$("status").style.visibility="visible";
}

function hide_status(){
	$("status").style.visibility="hidden";
	$("status").firstChild.nodeValue = "&nbsp;";
}