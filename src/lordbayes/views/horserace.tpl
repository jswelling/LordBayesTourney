<h1>Horserace</h1>

<label for="sel_horserace_tournament">Which Tournament?</label>
<select id="sel_horserace_tournament">
<option value=-1>All</option>
{% for id, name in tourneyDict | dictsort %}
<option value={{id}}>{{name}}</option>
{% endfor %}
</select>

<div>
<table id="horserace_table"></table>
<div id="horserace_pager"></div>
  <button id="horserace_go_btn">Go!</button>
</div>
  <img id="horseraceImage" src="data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs=" width="640" height="480" alt="" />
<script>
var selTourney = $('#sel_horserace_tournament');
selTourney.select().change( function()
{
	$('#horserace_table').trigger('reloadGrid');
});
var goBtn = $('#horserace_go_btn');
goBtn.button().click( function()
		      {
			checkboxData = {};
			$('#horserace_table').jqGrid('getRowData').forEach(element => {
			  var thisId = element.id;
			  checkboxData[thisId] = $('#horserace_checkbox_' + thisId)[0].checked;
			});
			jsonData = {
			  tourney: selTourney.val(),
			  checkboxes: checkboxData
			};
			console.log(jsonData);
			$.ajax({type:'POST',
				url:'horserace_go',
				data:JSON.stringify(jsonData),
				contentType: "application/json; charset=utf-8",
				dataType: "json"
			       })
			  .done( function(data) {
			    $('#horseraceImage').attr('src', data['image']);
			  })
			  .fail(function(jqxhr, textStatus, error) {
			    alert('Error: '+jqxhr.responseText);
			  });
		      });
 
jQuery("#horserace_table").jqGrid({
   	url:'json/horserace.json',
	datatype: "json",
   	colNames:['Id','Name','BearPit', 'Estimate','Notes', 'Include'],
   	colModel:[
   		{name:'id',index:'id', width:55},
   		{name:'name',index:'name', width:100},
   		{name:'bearpit',index:'estimate',width:55},
   		{name:'estimate',index:'estimate',width:55},
   		{name:'notes',index:'notes', width:100},
		{sortable:false, name:'exclude', index:'id', width:100,
		 formatter: function(cellvalue, options, rowobject){
		   return '<input type="checkbox" id="horserace_checkbox_'+cellvalue+'" checked>';
		 }
		}
   	],
   	rowNum:10,
   	rowList:[10,20,30],
   	pager: '#horserace_pager',
   	sortname: 'id',
    viewrecords: true,
    sortorder: "desc",
    caption:"Score Estimates",
    postData:{tourney: function(){return selTourney.val();}}
});
jQuery("horserace_table").jqGrid('navGrid','#horserace_pager',{edit:false,add:false,del:false});

function horserace_checkbox_change(chkbox) { alert(chkbox.checked); }
</script>