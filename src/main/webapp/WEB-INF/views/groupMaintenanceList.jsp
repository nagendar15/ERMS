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
	 			/* alert("Current Role : " + window.parent.getRole()); */
		        $(document).ready(function () {
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
	
		        	var objPastToPager = null;
		        	var initialLoad = true;
		        	
		        	document.getElementById("groupName").value = checkUndefinedElement(sessionStorage.getItem("groupName"));
		        	document.getElementById("groupType").value = checkUndefinedElement(sessionStorage.getItem("groupType"));
		        	document.getElementById("ccdId").value = checkUndefinedElement(sessionStorage.getItem("ccdId"));
		        	document.getElementById("cmdClientId").value = checkUndefinedElement(sessionStorage.getItem("cmdClientId"));
		        	document.getElementById("clientCptyName").value = checkUndefinedElement(sessionStorage.getItem("clientCptyName"));
		        	document.getElementById("accountNo").value = checkUndefinedElement(sessionStorage.getItem("accountNo"));
		        	document.getElementById("subAcc").value = checkUndefinedElement(sessionStorage.getItem("subAcc"));
		        	document.getElementById("accName").value = checkUndefinedElement(sessionStorage.getItem("accName"));
		        	document.getElementById("accBizUnit").value = checkUndefinedElement(sessionStorage.getItem("accBizUnit"));
		        	document.getElementById("returnMessage").innerHTML = "Result : " + checkUndefinedElement(sessionStorage.getItem("message"));
	
		        	submitButtonEvent();
		        	
					sessionStorage.setItem("groupName","");
		        	sessionStorage.setItem("groupType","");
		        	sessionStorage.setItem("ccdId","");
		        	sessionStorage.setItem("cmdClientId","");
		        	sessionStorage.setItem("clientCptyName","");
		        	sessionStorage.setItem("accountNo","");
		        	sessionStorage.setItem("subAcc","");
		        	sessionStorage.setItem("accName","");
		        	sessionStorage.setItem("accBizUnit","");
		        	sessionStorage.setItem("message","");
		        	
		        	$("#submitBtn").kendoButton({
		        		click: function(e) {
							submitButtonEvent();
			            }
			       	});
		
			       	$("#resetBtn").kendoButton();
			       	$("#exportBtn").kendoButton();
	        	}
	        );
	
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
		/* Open spinner while getting the data from back-end*/
		function openModal() {
		     document.getElementById('modal').style.display = 'block';
		     document.getElementById('modal2').style.display = 'block';
		}
	
		/* Close spinner when all the data have been received*/
		function closeModal() {
		    document.getElementById('modal').style.display = 'none';
		    document.getElementById('modal2').style.display = 'none';
		}
		// View - V, Update - E, Discard - D, Verify - A, Returned - R //
		/* Get action type from database and to be replaced image icon */
		function replacedByIconOfDetails(groupId, action_types, group_type, group_name, extKey1, extKey2, extKey3, extKey4, extKey5, userId){
			
			var returnImgHTML = "";
							
			if(new RegExp("V").test(action_types)){ 
				if(new RegExp("E").test(action_types) ){
					returnImgHTML += " <a target=\"main_frame\" href=\"groupMaintenanceDetail?action=view|update&rmdGroupId="+groupId+"&userId="+userId+"\"><img src=\"/ermsweb/resources/images/bg_view.png\" width=\"20\" height=\"20\"/></a> ";
					returnImgHTML += " <a target=\"main_frame\" href=\"groupMaintenanceDetail?action=update&rmdGroupId="+groupId+"&userId="+userId+"\"><img src=\"/ermsweb/resources/images/bg_update.png\" width=\"20\" height=\"20\"/></a> ";
				}else{
					returnImgHTML += " <a target=\"main_frame\" href=\"groupMaintenanceDetail?action=view&rmdGroupId="+groupId+"&userId="+userId+"\"><img src=\"/ermsweb/resources/images/bg_view.png\" width=\"20\" height=\"20\"/></a> ";
				}
			}
			return returnImgHTML;
		}
		function replacedByIconOfCR(crId, action_types, group_type, group_name, extKey1, extKey2, extKey3, extKey4, extKey5, userId){
			
			var returnImgHTML = "";
			
			if(new RegExp("V").test(action_types)){ 
				if(new RegExp("E").test(action_types)){
					returnImgHTML += " <a target=\"main_frame\" href=\"groupMaintenanceChangeRequest?action=view|update&crId="+crId+"&userId="+userId+"\"><img src=\"/ermsweb/resources/images/bg_view.png\" width=\"20\" height=\"20\"/></a> ";
					returnImgHTML += " <a target=\"main_frame\" href=\"groupMaintenanceChangeRequest?action=update&crId="+crId+"&userId="+userId+"\"><img src=\"/ermsweb/resources/images/bg_update.png\" width=\"20\" height=\"20\"/></a> ";
				}else{
					returnImgHTML += " <a target=\"main_frame\" href=\"groupMaintenanceChangeRequest?action=view&crId="+crId+"&userId="+userId+"\"><img src=\"/ermsweb/resources/images/bg_view.png\" width=\"20\" height=\"20\"/></a> ";			
				}
			}
			
			if(new RegExp("A").test(action_types)){ 
				returnImgHTML += " <a target=\"main_frame\" href=\"groupMaintenanceChangeRequest?action=verify&crId="+crId+"&userId="+userId+"\"><img src=\"/ermsweb/resources/images/bg_update.png\" width=\"20\" height=\"20\"/></a> ";
			}	
			return returnImgHTML;
		}
		
		/* Handle underfined / null element */
		function checkUndefinedElement(element){
			if(element === null || element === "undefined"){
				return "";
			}else{
				return element;
			}
		}
	
		function expandCriteria(){
			var filterBody = document.getElementById("filterBody").style.display;
			if(filterBody == "block"){
				document.getElementById("filterBody").style.display = "none";
				document.getElementById("filterTable").innerHTML = "(+) Filter Criteria";
			}else{
				document.getElementById("filterBody").style.display = "block";
				document.getElementById("filterTable").innerHTML= "(-) Filter Criteria";
			}
		}
		function submitButtonEvent(){
	
			document.getElementById("tableScope1").style.display = "block";
			document.getElementById("tableScope2").style.display = "block";
			
	     	/* Delete / Clean rows for refresh the table by delete all of rows */
	     	var oRows = document.getElementById('listTable').getElementsByTagName('tr');
	     	var iRowCount = oRows.length;
	
	     	for (var i = 0; i < 15; i++) {
	        	$('#tabRow'+i).remove();
	     	};
	     	
	     	var getDetailURL = "http://lxdapp25:8080/ERMSCore/groupDetail/getDetails?groupType="+document.getElementById('groupType').value+"&groupName="+document.getElementById('groupName').value+"&ccdId="+document.getElementById('ccdId').value+"&cmdClientId="+document.getElementById('cmdClientId').value+"&clientCptyName="+document.getElementById('clientCptyName').value+"&accountNo="+document.getElementById('accountNo').value+"&subAcc="+document.getElementById('subAcc').value+"&accName="+document.getElementById('accName').value+"&accBizUnit="+document.getElementById('accBizUnit').value+"&userId="+window.sessionStorage.getItem("userId");
	    	
	    	/* Open spinner while getting the data from back-end */
	    	var dataSource = new kendo.data.DataSource({
	    		transport: {
	    			read: {
	    	   		  	type: "GET",
	    			    url: getDetailURL,
	    			    dataType: "json"
	    	        	/*  data: {
	    	                 keywd: "test"
	    	            }  */
	    			}
	    		},
	    		requestEnd: function(e) {
	    	        var response = e.response; // responses content
	    	        console.log(response.length);
	    	        /* handle to display the table list */  
	    	       	for (var i = 0; i < response.length; i++) {
	    	       		$('#list tr:last').before('<tr style=\"font-size:13px;\" id="tabRow'+i+'"> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].groupTypeDesc)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].rmdGroupDesc)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey1)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey2)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey3)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey4)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey5)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey6)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey7)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey8)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey9)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey10)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].lastUpdateDt)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].lastUpdateBy)+'&nbsp;&nbsp;</td> <td colspan=\"2\" style="border-bottom: solid 1px black;">'+replacedByIconOfDetails(checkUndefinedElement(response[i].rmdGroupId), checkUndefinedElement(response[i].action), checkUndefinedElement(response[i].groupTypeDesc), checkUndefinedElement(response[i].rmdGroupDesc), checkUndefinedElement(response[i].externalKey1), checkUndefinedElement(response[i].externalKey2), checkUndefinedElement(response[i].externalKey3), checkUndefinedElement(response[i].externalKey4), checkUndefinedElement(response[i].externalKey5), checkUndefinedElement(window.sessionStorage.getItem("userId")))+'&nbsp;&nbsp;</td> </tr>');
	    	        };        
	    	        $("#countRow").text("No. of Record : " +response.length);	 
	    	    },
	    		serverPaging: true, // enable serverPaging so take and skip are sent as request parameters
	    		serverFiltering: true,
	    		serverPaging: true
	    	});   
	    	
	    	$("#pager1").kendoPager({
	    	  dataSource: dataSource,
	    	  info: false
	    	});
	
	    	dataSource.read();        	                 	
	
	    	/* List style 2 */
	    	var oRows = document.getElementById('listTable').getElementsByTagName('tr');
	     	var iRowCount = oRows.length;
	
	     	for (var i = 0; i < iRowCount; i++) {
	             		$('#tabRow'+i).remove();
	     	};
	
	    	var getDetailURL = "http://lxdapp25:8080/ERMSMock/groupDetail/getDetailsChangeRequest";  // models = ?function=xxx&id=xxx
	    	 	
	    	/* Open spinner while getting the data from back-end */
	     	
	     	var dataSource2 = new kendo.data.DataSource({
	        	transport: {
	        		read: {
	           		  	type: "get",
	        		    url: getDetailURL,
	        		    dataType: "json"
	                	/*  data: {
	                         keywd: "test"
	                    }  */
	        		}
	        	},
				/* pageSize:2, */
	        	requestEnd: function(e) {
	                var response = e.response; // responses content
	                /* handle to display the table list */  
	               	for (var i = 0; i < response.length; i++) {
	               		$('#list2 tr:last').before('<tr style=\"font-size:13px;\" id="tabRow'+i+'"> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].groupTypeDesc)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].rmdGroupDesc)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey1)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey2)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey3)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey4)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey5)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey6)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey7)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey8)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey9)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].externalKey10)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].crDt)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].crBy)+'&nbsp;&nbsp;</td> <td style="border-bottom: solid 1px black;">'+checkUndefinedElement(response[i].status)+'&nbsp;&nbsp;</td> <td colspan=\"2\" style="border-bottom: solid 1px black;">'+replacedByIconOfCR(checkUndefinedElement(response[i].crId), checkUndefinedElement(response[i].action), checkUndefinedElement(response[i].groupTypeDesc), checkUndefinedElement(response[i].groupTypeDesc), checkUndefinedElement(response[i].externalKey1), checkUndefinedElement(response[i].externalKey2), checkUndefinedElement(response[i].externalKey3), checkUndefinedElement(response[i].externalKey4), checkUndefinedElement(response[i].externalKey5), checkUndefinedElement(window.sessionStorage.getItem("userId")))+'&nbsp;&nbsp;</td> </tr>');
	                };        
	                $("#countRow2").text("No. of Record : " +response.length);	 
	            },
	        	serverPaging: true // enable serverPaging so take and skip are sent as request parameters
	        });   
	
	        $("#pager2").kendoPager({
	          	dataSource: dataSource2,
	          	info: false
	        });
	
	        dataSource2.read();
	    	 
	    	 window.sessionStorage.setItem('groupName',document.getElementById("groupName").value)
	    	 window.sessionStorage.setItem('groupType',document.getElementById("groupType").value)
	    	 window.sessionStorage.setItem('ccdId',document.getElementById("ccdId").value)
	    	 window.sessionStorage.setItem('cmdClientId',document.getElementById("cmdClientId").value)
	    	 window.sessionStorage.setItem('clientCptyName',document.getElementById("clientCptyName").value)
	    	 window.sessionStorage.setItem('accountNo',document.getElementById("accountNo").value)
	    	 window.sessionStorage.setItem('subAcc',document.getElementById("subAcc").value)
	    	 window.sessionStorage.setItem('accName',document.getElementById("accName").value)
	    	 window.sessionStorage.setItem('accBizUnit',document.getElementById("accBizUnit").value)
		}
	
	    </script>
	
		<body>
			<!-- <script type="text/javascript" src="/ermsweb/resources/js/header.js"></script> -->
			<%-- <%@include file="header.jsp"%> --%>
			<div id="returnMessage"></div>
			<div style="background-color:pink; width:1060">Group Detail Maintenance</div>
			<br>
			<table id="listTable" width="1060" style="background-color:#DBE5F1; overflow-x:scroll; border-bottom" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="6" style="background-color:#8DB4E3; width:1060">
					<b><div id="filterTable" onclick="expandCriteria()">(+) Filter Criteria</div></b></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tbody id="filterBody" style="display: block">
					<tr>
						<td>Group Name.</td>
						<td><input id="groupName" name="groupName" type="text"/></td>
						<td>Group Type.</td>
						<td><input id="groupType" name="groupType" type="text"/></td>
						<td>CCD ID.</td>
						<td><input id="ccdId" name="ccdId" type="text"/></td>
						<td></td>
					</tr>
					<tr><td><br></td></tr>
					<tr>
						<td>CMD Client ID.</td>
						<td><input id="cmdClientId" name="cmdClientId" type="text"/></td>
						<td>Client/Counterparty Name.</td>
						<td><input id="clientCptyName" name="clientCptyName" type="text"/></td>
						<td>Account No.</td>
						<td><input id="accountNo" name="accountNo" type="text"/></td>
						<td></td>
					</tr>
					<tr><td><br></td></tr>
					<tr>
						<td>Sub - Acc.</td>
						<td><input id="subAcc" name="subAcc" type="text"/></td>
						<td>Account Name.</td>
						<td><input id="accName" name="accName" type="text"/></td>
						<td>Acc - Biz Unit.</td>
						<td><input id="accBizUnit" name="accBizUnit" type="text"/></td>
						<td></td>
					</tr>
					<tr><td><br></td></tr>
					<tr><td><br></td></tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td>
							<button id="submitBtn"  style="background:blue; color:white" type="button">Submit</button>
							<button id="resetBtn" type="button">Reset</button>
							<button id="exportBtn" type="button">Export</button>
						</td>
					</tr>
				</tbody>
			</table>
			<br>
			<div style="overflow-x: scroll; width:1060px; display: none" id="tableScope1">
					<table id="list" width="1060" cellpadding="0" cellspacing="0">
						<tr style="background-color:#5A2727; color:white">
							<td colspan="16">
								Result
							</td>
						</tr>
						<tr style="background-color:#B54D4D; font-size:13px; color:white;">
							<td width="40">&nbsp;Group_Type&nbsp;</td>
							<td width="40">&nbsp;Group_Name&nbsp;</td>
							<td width="40">&nbsp;External_Key_ID_1&nbsp;</td>	
							<td width="40">&nbsp;External_Key_ID_2&nbsp;</td>	
							<td width="40">&nbsp;External_Key_ID_3&nbsp;</td>
							<td width="40">&nbsp;External_Key_ID_4&nbsp;</td>
							<td width="40">&nbsp;External_Key_ID_5&nbsp;</td>
							<td width="40">&nbsp;External_Key_ID_6&nbsp;</td>
							<td width="40">&nbsp;External_Key_ID_7&nbsp;</td>
							<td width="40">&nbsp;External_Key_ID_8&nbsp;</td>
							<td width="40">&nbsp;External_Key_ID_9&nbsp;</td>
							<td width="40">&nbsp;External_Key_ID_10&nbsp;</td>
							<td width="40">&nbsp;last_update&nbsp;</td>
							<td width="40">&nbsp;Updated_by&nbsp;</td>
							<td width="40">&nbsp;action&nbsp;</td>
							<td width="40">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
				<div id="pager1"></div>
				<br>
				<div style="overflow-x: scroll; width:1060px; display: none" id="tableScope2">
						<table id="list2" width="1060" cellpadding="0" cellspacing="0">
							<tr style="background-color:#5A2727; color:white">
								<td colspan="17">
									Result
								</td>
							</tr>
							<tr style="background-color:#B54D4D; font-size:13px; color:white;">
								<td width="40">&nbsp;Group_Type&nbsp;</td>
								<td width="40">&nbsp;Group_Name&nbsp;</td>
								<td width="40">&nbsp;External_Key_ID_1&nbsp;</td>	
								<td width="40">&nbsp;External_Key_ID_2&nbsp;</td>	
								<td width="40">&nbsp;External_Key_ID_3&nbsp;</td>
								<td width="40">&nbsp;External_Key_ID_4&nbsp;</td>
								<td width="40">&nbsp;External_Key_ID_5&nbsp;</td>
								<td width="40">&nbsp;External_Key_ID_6&nbsp;</td>
								<td width="40">&nbsp;External_Key_ID_7&nbsp;</td>
								<td width="40">&nbsp;External_Key_ID_8&nbsp;</td>
								<td width="40">&nbsp;External_Key_ID_9&nbsp;</td>
								<td width="40">&nbsp;External_Key_ID_10&nbsp;</td>
								<td width="40">&nbsp;last_update&nbsp;</td>
								<td width="40">&nbsp;Updated_by&nbsp;</td>
								<td width="40">&nbsp;status&nbsp;</td>
								<td width="40">&nbsp;action&nbsp;</td>
								<td width="40">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
				
				<div style="font-size: 13px" id="countRow2"></div>
				<div id="pager2"></div>
				<br/></br>
		</body>
	</html>	