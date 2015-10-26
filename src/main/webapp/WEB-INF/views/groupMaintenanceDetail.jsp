<html lang="en">

	<meta http-equiv="Content-Style-Type" content="text/css">
    <meta http-equiv="Content-Script-Type" content="text/javascript">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <script type="text/javascript" src="/ermsweb/resources/js/validation.js"></script>
    
    <!-- General layout Style -->
    <link href="/ermsweb/resources/css/layout.css" rel="stylesheet" type="text/css">

    <!-- Kendo UI API -->
    <link rel="stylesheet" href="/ermsweb/resources/css/kendo.common.min.css">
    <link rel="stylesheet" href="/ermsweb/resources/css/kendo.rtl.min.css">
    <link rel="stylesheet" href="/ermsweb/resources/css/kendo.default.min.css">
    <link rel="stylesheet" href="/ermsweb/resources/css/kendo.dataviz.min.css">
    <link rel="stylesheet" href="/ermsweb/resources/css/kendo.dataviz.default.min.css">
    <link rel="stylesheet" href="/ermsweb/resources/css/kendo.mobile.all.min.css">

    <!-- jQuery JavaScript -->
    <script src="/ermsweb/resources/js/jquery.min.js"></script>

    <!-- Kendo UI combined JavaScript -->
    <script src="/ermsweb/resources/js/kendo.all.min.js"></script>

    <!-- <head>Enquiry Loan Sub-Participation Ratio</head> -->

 	<script>
	 	var objPastToPager = null; // This value will be used to pass the value to another list

	 	var initialLoad = true; // Nothing
 			$(document).ready(
 				function(){
 				/* Control and initialize the menu bar of header
 				 (8 options of menu)
 				*/
				$("#menu1").kendoMenu({
	        		animation: {open: {effects: "slideIn:down"}}
	        	});
				$("#menu2").kendoMenu({
	        		animation: {open: {effects: "slideIn:down"}}
	        	});
				$("#menu3").kendoMenu({
	        		animation: {open: {effects: "slideIn:down"}}
	        	});
				$("#menu4").kendoMenu({
	        		animation: {open: {effects: "slideIn:down"}}
	        	});
				$("#menu5").kendoMenu({
	        		animation: {open: {effects: "slideIn:down"}}
	        	});
				$("#menu6").kendoMenu({
	        		animation: {open: {effects: "slideIn:down"}}
	        	});
				$("#menu7").kendoMenu({
	        		animation: {open: {effects: "slideIn:down"}}
	        	});

				/* Get the action type - view for directing to the view mode on this page */
				/* Replacing the button, label from update to view */
				/* Maker action -> */
				
				
				var xhttp = new XMLHttpRequest();
				var url = "http://lxdapp25:8080/ERMSCore/groupDetail/getRecord?rmdGroupId="+getURLParameters("rmdGroupId")+"&userId="+getURLParameters("userId");
				
				/* For Testing -> Get parameters from list page (could be implemented by Kendo)  */
				xhttp.onreadystatechange=function(e) {    
					if (xhttp.readyState == 4 && xhttp.status == 200) {
				     	
				    	var obj = JSON.parse(xhttp.response);
				     	if(new RegExp("action\=view").test($(location).attr('href'))){
				     		
				     		document.getElementById("groupType").innerHTML = checkUndefinedElement(obj.groupTypeDesc);		     	
				     		document.getElementById("groupName").innerHTML = checkUndefinedElement(obj.rmdGroupDesc);
				     		document.getElementById("extKey1").innerHTML = checkUndefinedElement(obj.externalKey1);
				     		document.getElementById("extKey2").innerHTML = checkUndefinedElement(obj.externalKey2);
				     		document.getElementById("extKey3").innerHTML = checkUndefinedElement(obj.externalKey3);
				     		document.getElementById("extKey4").innerHTML = checkUndefinedElement(obj.externalKey4);
				     		document.getElementById("extKey5").innerHTML = checkUndefinedElement(obj.externalKey5);

				     	}else{

				     		if(new RegExp("action\=update").test($(location).attr('href'))){
					     		document.getElementById("groupType").innerHTML = checkUndefinedElement(obj.groupTypeDesc);		     	
					     		document.getElementById("groupName").innerHTML = checkUndefinedElement(obj.rmdGroupDesc);
					     		document.getElementById("extKey1").value = checkUndefinedElement(obj.externalKey1);
					     		document.getElementById("extKey2").value = checkUndefinedElement(obj.externalKey2);
					     		document.getElementById("extKey3").value = checkUndefinedElement(obj.externalKey3);
					     		document.getElementById("extKey4").value = checkUndefinedElement(obj.externalKey4);
					     		document.getElementById("extKey5").value = checkUndefinedElement(obj.externalKey5);
					     	}
				     	}

				     	document.getElementById("createdBy").innerHTML = checkUndefinedElement(obj.createBy);
				     	document.getElementById("createdAt").innerHTML = checkUndefinedElement(obj.createDt);
				     	document.getElementById("updateBy").innerHTML = checkUndefinedElement(obj.lastUpdateBy);
				     	document.getElementById("updateAt").innerHTML = checkUndefinedElement(obj.lastUpdateDt);
				     	document.getElementById("verifiedBy").innerHTML = checkUndefinedElement(obj.verifyBy);
				     	document.getElementById("verifiedAt").innerHTML = checkUndefinedElement(obj.verifyDt);
				     	document.getElementById("status").innerHTML = checkUndefinedElement(obj.crStatus);
				    }
				}
				/* End Testing */
				
				xhttp.open("GET", url, true);
				xhttp.send();
				
 					if(new RegExp("action\=view").test($(location).attr('href'))){
 						$("#pageTitle").html("Maintenance - Group Detail Maintenance - View	Group Detail");
 						$("#group_type_label").html("<label id=\"groupType\"></label>");
 						$("#group_name_label").html("<label id=\"groupName\"></label>");
 						$("#checkEXTKey1").html("<label id=\"extKey1\"></label>");
 						$("#checkEXTKey2").html("<label id=\"extKey2\"></label>");
 						$("#checkEXTKey3").html("<label id=\"extKey3\"></label>");
 						$("#checkEXTKey4").html("<label id=\"extKey4\"></label>");
 						$("#checkEXTKey5").html("<label id=\"extKey5\"></label>");
 						
 						if(new RegExp("update").test($(location).attr('href'))){
 							$("#buttonType").html("<button id=\"updateBtn\" style=\"background:blue; color:white\" type=\"button\" data-role=\"button\" class=\"k-button\" role=\"button\" aria-disabled=\"false\" tabindex=\"0\" onclick=\"toUpdate()\">Update</button><label>    </label><button id=\"backBtn\" onclick=\"toBack()\" type=\"button\" data-role=\"button\" class=\"k-button\" role=\"button\" aria-disabled=\"false\" tabindex=\"0\">Back</button>");
 						}else{
 							$("#buttonType").html("<button id=\"backBtn\" onclick=\"toBack()\" type=\"button\" data-role=\"button\" class=\"k-button\" role=\"button\" aria-disabled=\"false\" tabindex=\"0\">Back</button>");
 						}
 					}else{
 						/* Get the action type - update for directing to the update mode on this page. */
 						/* Replacing the button, label from view to update */
	
 						if(new RegExp("action\=update").test($(location).attr('href'))){
 							$("#pageTitle").html("Maintenance - Group Detail Maintenance - Update Group Detail");
 							$("#group_type_label").html("<label id=\"groupType\"></label>");
 							$("#group_name_label").html("<label id=\"groupName\"></label>");
 							$("#checkEXTKey1").html("<input id=\"extKey1\" type=\"text\" />");
 							$("#checkEXTKey2").html("<input id=\"extKey2\" type=\"text\" />");
 							$("#checkEXTKey3").html("<input id=\"extKey3\" type=\"text\" />");
 							$("#checkEXTKey4").html("<input id=\"extKey4\" type=\"text\" />");
 							$("#checkEXTKey5").html("<input id=\"extKey5\" type=\"text\" />");
 							$("#buttonType").html("<button id=\"submitBtn\" style=\"background:blue; color:white\" type=\"button\" data-role=\"button\" class=\"k-button\" role=\"button\" aria-disabled=\"false\" tabindex=\"0\" onclick=\"toSubmit()\">Update</button><label>     </label><button id=\"saveBtn\" style=\"background:blue; color:white\" type=\"button\" data-role=\"button\" class=\"k-button\" role=\"button\" aria-disabled=\"false\" tabindex=\"0\" onclick=\"toSave()\">Save</button><label>     </label><button id=\"backBtn\" onclick=\"toBack()\" type=\"button\" data-role=\"button\" class=\"k-button\" role=\"button\" aria-disabled=\"false\" tabindex=\"0\">Back</button>");
 						}
 					}
        	     	/* 
        	     		Delete / Clean rows for refresh the table by delete all of rows
        	     	 */
        	     	var oRows = document.getElementById('listTable').getElementsByTagName('tr');
        	     	var iRowCount = oRows.length;

        	     	for (var i = 0; i < iRowCount; i++) {
    	                 		$('#tabRow'+i).remove();
                 	};
                 	
                 	 /* Open spinner while getting the data from back-end */

        	     	 // server configuation  //
					var getMemberURL = "http://lxdapp25:8080/ERMSCore/groupDetail/getMember?rmdGroupId="+getURLParameters("rmdGroupId")+"&userId="+getURLParameters("userId");
					
					var dataSource = new kendo.data.DataSource({
						transport: {
							read: {
					   		  	type: "get",
							    url: getMemberURL,
							    dataType: "json"
/* 			                        data: {
		                            keywd: "test"
		                        } */
							}
						},
/* 			                change: function(e) {
 	  						openModal();
  		        	     	var oRows = document.getElementById('listTable').getElementsByTagName('tr');
  		        	     	var iRowCount = oRows.length;

  		        	     	for (var i = 0; i < iRowCount+1; i++) {
  	        	            	$('#tabRow'+i).remove();
  		                 	};
  		                 	var response = e.response;
					          
					       	for (var i = 0; i < response.length; i++) {
					       		$('#list tr:last').before('<tr style=\"font-size:13px;\" id="tabRow'+i+'"> <td>'+checkUndefinedElement(response[i].ccdId)+'&nbsp;&nbsp;</td> <td>'+checkUndefinedElement(response[i].clientCptyName)+'&nbsp;&nbsp;</td> <td>'+checkUndefinedElement(response[i].accountNo)+'&nbsp;&nbsp;</td> <td>'+checkUndefinedElement(response[i].subAcc)+'&nbsp;&nbsp;</td> <td>'+checkUndefinedElement(response[i].accountName)+'&nbsp;&nbsp;</td> <td>'+checkUndefinedElement(response[i].accountBizUnit)+'&nbsp;&nbsp;</td> </tr>');
					        };        	
					        $("#countRow").text("No. of Record : " +response.length);	 
	                 	}, */
	                 	requestEnd: function(e) {
					        var response = e.response; // responses content
					        /* handle to display the table list */  
					       	for (var i = 0; i < response.length; i++) {
					       		$('#list tr:last').before('<tr style=\"font-size:13px;\" id="tabRow'+i+'"> <td>'+checkUndefinedElement(response[i].ccdId)+'&nbsp;&nbsp;</td> <td>'+checkUndefinedElement(response[i].legalPartyEngName)+'&nbsp;&nbsp;</td> <td>'+checkUndefinedElement(response[i].acctId)+'&nbsp;&nbsp;</td> <td>'+checkUndefinedElement(response[i].subAcctId)+'&nbsp;&nbsp;</td> <td>'+checkUndefinedElement(response[i].accName)+'&nbsp;&nbsp;</td> <td>'+checkUndefinedElement(response[i].accBizUnit)+'&nbsp;&nbsp;</td> </tr>');
					        };        
					        $("#countRow").text("No. of Record : " +response.length);	 
					     // enable serverPaging so take and skip are sent as request parameters
						}/* ,
     	  					serverPaging: true,
     	  					pageSize: 5,
     	  					pageNumber: 3 */
					});
					
					openModal();								
					dataSource.fetch();
					closeModal();
        	     	// end //
	        	 $("#resetBtn").kendoButton(); // Reset button event
	        	 $("#exportBtn").kendoButton(); // Export button event
	        	}
 			);
	
	

	/* Action - Update button */
	function toUpdate(){ /* Direct me to update page */
		window.location = "groupMaintenanceDetail?action=update&rmdGroupId="+getURLParameters("rmdGroupId");
	}

	/* Action - View button */
	function toView(){ /* Direct me to view page */
		var updateBtn = document.getElementById("submitBtn");
	}

	/* Action - Back button */
	function toBack(){
		window.history.back();
	}

	/* Send to submit */
	function toSubmit(){
		var xmlhttp = new XMLHttpRequest();
		var url = "http://lxdapp25:8080/ERMSCore/groupDetail/submit?rmdGroupId="+getURLParameters("rmdGroupId")+"&userId="+getURLParameters("userId")+"&externalKey1="+checkUndefinedElement(extKey1)+"&externalKey2="+checkUndefinedElement(extKey2)+"&externalKey3="+checkUndefinedElement(extKey3)+"&externalKey4="+checkUndefinedElement(extKey4)+"&externalKey5="+checkUndefinedElement(extKey5);
		
		xmlhttp.onreadystatechange = function() {
		    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			      var response = xmlhttp.response;
			      var obj = JSON.parse(response);
			      window.sessionStorage.setItem('message', obj.message);
		    }
		}		
		xmlhttp.open("POST", url, true);
		xmlhttp.send();
			        	 
		window.location.href = "groupMaintenanceList";
	}
	
	/* Send to submit */
	function toSave(){
		var xmlhttp = new XMLHttpRequest();
		var url = "http://lxdapp25:8080/ERMSCore/groupDetail/save?rmdGroupId="+getURLParameters("rmdGroupId")+"&userId="+getURLParameters("userId")+"&externalKey1="+checkUndefinedElement(extKey1)+"&externalKey2="+checkUndefinedElement(extKey2)+"&externalKey3="+checkUndefinedElement(extKey3)+"&externalKey4="+checkUndefinedElement(extKey4)+"&externalKey5="+checkUndefinedElement(extKey5);
		
		xmlhttp.onreadystatechange = function() {
		    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			      var response = xmlhttp.response;
			      var obj = JSON.parse(response);
			      window.sessionStorage.setItem('message', obj.message);
		    }
		}		
		xmlhttp.open("POST", url, true);
		xmlhttp.send();
			        	 
		window.location.href = "groupMaintenanceList";
	}
	
	/* Handle underfined / null element */
	function checkUndefinedElement(element){
		if(element === null || element === "undefined"){
			return "";
		}else{
			return element;
		}
	}
	/* Open spinner while getting the data from back-end*/
	function openModal() {
	     document.getElementById('modal').style.display = 'block';
	     /* document.getElementById('modal2').style.display = 'block'; */
	}
	
	/* Close spinner when all the data have been received*/
	function closeModal() {
	    document.getElementById('modal').style.display = 'none';
	    /* document.getElementById('modal2').style.display = 'none'; */
	}
	/* The method which is used for capturing the parameters from URL */
	/* Return  : a Parameter  */
	/* Receive : Parameter Name */
	
	function getURLParameters(paramName){
		var sURL = window.document.URL.toString();
		if(sURL.indexOf("?") > 0){
			var arrParams = sURL.split("?");
			var arrURLParams = arrParams[1].split("&");
			var arrParamNames = new Array(arrURLParams.length);
			var arrParamValues = new Array(arrURLParams.length)
		}
		var i = 0;
		for(i = 0; i < arrURLParams.length; i++){
			var sParam = arrURLParams[i].split("=");
			arrParamNames[i] = sParam[0];
			if(sParam[1] != ""){
				arrParamValues[i] = unescape(sParam[1]);
			}else{
				arrParamValues[i] = "No Value";
			}
		}

		for(i = 0; i < arrURLParams.length; i++){
			if(arrParamNames[i] == paramName){
				return arrParamValues[i];
			}
		}
		return "No Parameters Found";
	}
	function displayFilterResults() {
		  // Gets the data source from the grid.
		  var dataSource = $("#MyGrid").data("kendoGrid").dataSource;
		  
		  // Gets the filter from the dataSource
		     var filters = dataSource.filter();
		     
		     // Gets the full set of data from the data source
		     var allData = dataSource.data();
		     
		     // Applies the filter to the data
		     var query = new kendo.data.Query(allData);
		     var filteredData = query.filter(filters).data;
		     
		     // Output the results
		     $('#FilterCount').html(filteredData.length);
		     $('#TotalCount').html(allData.length);
		     $('#FilterResults').html('');
		     $.each(filteredData, function(index, item){
		       $('#FilterResults').append('<li>'+item.Site+' : '+item.Visitors+'</li>')
		     });
		}

    </script>

	<body>

		<!-- <script type="text/javascript" src="/ermsweb/resources/js/header.js"></script> -->
		<%-- <%@include file="header.jsp"%> --%>
		<div id="pageTitle" style="background-color:pink; width:1000">
		</div>
		<br>

		<table id="listTable" width:"500" style=" overflow-y :scroll" >
			<tr>
				<td colspan="4" style="background-color:#393052;color:white; width:500; font-size:13px">Group Details</td>
			</tr>
			<tr>
				<td width="166" style="font-size:13px; background-color:#B5A2C6">Group Type.</td>
				<td width="333" style="font-size:13px; background-color:#E7E3EF"><div id="group_type_label"><label></label></div></td>
				
			</tr>
			<tr>
				<td width="166" style="font-size:13px; background-color:#B5A2C6">Group Name.</td>
				<td width="333" style="font-size:13px; background-color:#E7E3EF"><div id="group_name_label"><label></label></div></td>
			</tr>
			<tr>
				<td width="166" style="font-size:13px; background-color:#B5A2C6">External Key ID #1</td>
				<td width="333" style="font-size:13px; background-color:#E7E3EF">
					<div id="checkEXTKey1"/>
				</td>
				
			</tr>
			<tr>
				<td width="166" style="font-size:13px; background-color:#B5A2C6">External Key ID #2</td>
				<td width="333" style="font-size:13px; background-color:#E7E3EF">
					<div id="checkEXTKey2"/>
				</td>
				
			</tr>
			<tr>
				<td width="166" style="font-size:13px; background-color:#B5A2C6">External Key ID #3</td>
				<td width="333" style="font-size:13px; background-color:#E7E3EF">
					<div id="checkEXTKey3"/>
				</td>
				
			</tr>
			<tr>
				<td width="166" style="font-size:13px; background-color:#B5A2C6">External Key ID #4</td>
				<td width="333" style="font-size:13px; background-color:#E7E3EF">
					<div id="checkEXTKey4"/>
				</td>
				
			</tr>
			<tr>
				<td width="166" style="font-size:13px; background-color:#B5A2C6">External Key ID #5</td>
				<td width="333" style="font-size:13px; background-color:#E7E3EF">
					<div id="checkEXTKey5"/>
				</td>
				
			</tr>
			<tr>
				<td><br></td>
			</tr>
			<tr>
			<td></td>
				
				<td align="right">
					<div id="buttonType">
						<button id="submitBtn"  style="background:blue; color:white" type="button">Submit</button>
						<button id="exportBtn"  style="background:blue; color:white" type="button">Save</button>
						<button id="resetBtn" type="button">Back</button>
					</div>
					</td>
			</tr>
			<tr></tr>
			<tr></tr>
		</table>
		<br>
		
		<div style="overflow-y: scroll; overflow-y: hidden; width:1000px;"><table id="list" width="1000" >
					<tr style="background-color:#082439; color:white">
						<td colspan="15">
							<div style="font-size:13px">Group Member</div>
						</td>
					</tr>
					<tr style="background-color:#BDCFE7; font-size:13px;">
						<td width="166">CCD ID&nbsp;</td>
						<td width="166">Client/Counterparty&nbsp;</td>
						<td width="166">Account No.&nbsp;</td>
						<td width="166">Sub Acc&nbsp;</td>
						<td width="166">Account_Name&nbsp;</td>
						<td width="166">Acc - Biz Unit&nbsp;</td>
					</tr>
					<tr>
						<td colspan="8">
							<div id="modal" align="center" style="display:none;">
					            <img id="loader" src="/ermsweb/resources/images/ajax-loader.gif" />
					        </div>
						</td>
					</tr>					
				</table>
					<br>
			</div>
			<div style="font-size: 13px" id="countRow"></div>
		<br>
<!-- 	<div style="width:1000" id='MyGrid'>
		<div id="modal2" align="center" style="display:none;">
		<div style="background-color:grey; color:white">Result</div>
	            <img id="loader2" src="/ermsweb/resources/images/ajax-loader.gif" />
	    </div>
		</div> -->
		<table border="0" style="background-color:#B5D5AB">
			<tr>
				<td width="195.5" style="font-size:13px"><b>Created By</b></td>
				<td width="195.5" style="font-size:13px"><label id="createdBy"></label></td>
				<td width="195.5" style="font-size:13px"></td>
				<td width="195.5" style="font-size:13px"><b>Created At</b></td>
				<td width="195.5" style="font-size:13px"><label id="createdAt"></label></td>
			</tr>
			<tr>
				<td width="195.5" style="font-size:13px"><b>Updated By</b></td>
				<td width="195.5" style="font-size:13px"><label id="updateBy"></label></td>
				<td width="195.5" style="font-size:13px"></td>
				<td width="195.5" style="font-size:13px"><b>Updated At</b></td>
				<td width="195.5" style="font-size:13px"><label id="updateAt"></label></td>
			</tr>
			<tr>
				<td width="195.5" style="font-size:13px"><b>Verified By</b></td>
				<td width="195.5" style="font-size:13px"><label id="verifiedBy"></label></td>
				<td width="195.5" style="font-size:13px"></td>
				<td width="195.5" style="font-size:13px"><b>Verified At</b></td>
				<td width="195.5" style="font-size:13px"><label id="verifiedAt"></label></td>
			</tr>
			<tr>
				<td width="195.5" style="font-size:13px"><b>Status</b></td>
				<td width="195.5" style="font-size:13px"><label id="status"></label></td>
				<td width="195.5" style="font-size:13px"></td>
				<td width="195.5" style="font-size:13px"></td>
				<td width="195.5" style="font-size:13px"></td>
			</tr>
		</table>
	</body>
</html>	