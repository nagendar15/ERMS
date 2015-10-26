<%@taglib prefix="kendo" uri="http://www.kendoui.com/jsp/tags"%>
<%@taglib prefix="shared" tagdir="/WEB-INF/tags"%>

<script src="/ermsweb/resources/js/ermsresources.js"></script>

<!DOCTYPE html>

<shared:header></shared:header>
<style>
           
	#loginForm {
		width: 100%;
		font-size: 80%;
	    }
    #loginForm h2 {
        border-bottom: 3px solid #8C435A;
        font-size: 2.4em;
        font-weight: strong;
        padding: 6px;
        margin: 0;
        color: #8C435A;
    }
    #loginForm ul {
        list-style-type: none;
    }
    #loginForm ul li {
        margin: 10px;
    }
    #loginForm ul label {
       
        display: inline-block;
        width: 90px;
        text-align: left;
    }
    #loginForm label {
        display: block;
        margin-bottom: 10px;
    }
    #loginForm .buttons {
        margin-top: 25px;
    }
    #loginForm .k-button {
        width: 100px;
    }
    .invalid {
    color: red;
	}
	select{
	background-color: #ffffff;
    border: 1px solid #cccccc;
    width: 170px;
	}
	#child-panel
            {
                margin-left: 20px;
                text-align: center;
            }
            #child-panel li
            {
                margin-right: 10px;
                margin-bottom: 10px;
                list-style: none;
                
            }
            #child-panel .k-block{
            background-color:#FFFFFF;
            }
            #loginForm > div{
            padding-left: 20%;
		    position: absolute;
		    width: 60%;
		    padding-top: 10%;
            }
            #tableheader{
             background-color: #7A0802;
    color: #fff;
    font-size: 21px;
    font-weight: 600;
    text-align: left;
            }
            #loginForm .k-button{
            	background-color:#7A0802;
            	color:#FFFFFF;
            }
            #loginForm .buttons{
            	 margin-right: -22%;
            }
	  
        </style>  
<body>

<div id="loginForm">
    <h2><img src="/ermsweb/resources/images/logo.png"></img>Enterprise Risk Management Systems</h2>
    <div id="login">
		<ul id="child-panel">            
		    <li>
		        <div class="k-block">
				<div class="k-header" id="tableheader">Login</div>
				<ul>
				<li>
				    <label for="username" class="required">User Name</label>
				    <input type="text" id="username" name="username" class="k-textbox" placeholder="e.g. user name" required  data-username-msg="Please Enter User Name"/>
				</li>
				<li>
				    <label for="password" class="required">Password</label>
				    <input type="password" id="password" name="password" class="k-textbox" placeholder="password" required min="1"/> 
				</li>
				<li>
				    <label for="domain" class="required">Domain</label>
				    <select id="domain">
				    <option value="HKDM">HKDM</option>
				    <option value="BOCI">BOCI</option>
				    <option value="BOCIS1">BOCIS1</option>
					</select>
				</li>				
				<li class="buttons">
				    <button class="k-button btnSave" id="save">Login</button>
				    <div class="status"></div>
				</li>
			    </ul>
			</div>
		    </li>           
		</ul>
    </div>
</div>

<script>
/* ermsresource.init({
	 	  filePath : '/ermsweb/resources/messages/'
	});
ermsresource.load('erms', function(){ 
	  domain = ermsresource.get('erms.domains', 'erms');
	  var select = $("#domain")[0];
	  var values=domain.split(",");
	  $.each(values, function(index, value) {
		  select.add(new Option(value));
	  });
	});  */
	

var validator;

var crudServiceBaseUrl = "http://lxdapp25:8080/ERMSCore/login";
//var crudServiceBaseUrl = "https://vrest.io/i/ermsweb/m/SP/ERMSMock/login"
var redirecturl = "http://lxdapp25:8080/ermsweb/index";
var dataSource = new kendo.data.DataSource({
	  batch: true,
	  transport: {
		create: {
		  cache: false,
		  type: "post",
	      url: crudServiceBaseUrl,
	      dataType: "json",
	      
	    },
	    parameterMap: function(data) {
	      return { models: kendo.stringify(data.models) };
	    }
	  },
	  schema: {
	    model: { status: "action" }
	  },
	  requestEnd: function(e) {
	
          var response = e.response;

         if(response.action=="success"){
 	       window.sessionStorage.setItem('username',response.username);
 	       window.sessionStorage.setItem('domain',$("#domain").val());
 	       window.sessionStorage.setItem('userId',response.userId);
 	       window.sessionStorage.setItem('lastLogin',response.lastLogin);
 	       window.sessionStorage.setItem('userRole',response.userRole);
        	window.location.href = redirecturl;
         }else{
        	 $(".status").text("Oops! There is invalid data in the form.").addClass("invalid");
         }
      }
	});
	
	validator = $("#loginForm").kendoValidator().data("kendoValidator");

	$("#save").on("click", function() {
		if (validator.validate()) {
			var un= $("#username").val();
			var ps=$("#password").val();
			var dm=$("#domain").val();
			dataSource.add( { username: un,password:ps,domain:dm} );
			dataSource.sync();
		}
	});
</script>  

</body>
</html>