<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Can You Hide</title>
<link href="<%=request.getContextPath()%>/CSS/main.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/App/app.js"></script>
</head>
<body>
<%@ page import="java.util.ArrayList" %>
	
	<div class="main">
		<p class="title"> Can you help us find the right spot? </p>
	
		<div class="container">
		    
			<div class="container-left">
			    <div class="outer" id="maze">
					 <%
					 	StringBuilder str = new StringBuilder();
					 		      for(int i = 0; i < 7; i++)
					 		      {
					 		        	str.append("<div class=\"row\" id=\"row-\"" + i + "\">");
					 		        	
					 		        	for(int j = 0 ; j < 7 ; j++)
					 		        	{
		
					 		        		
					 		        		str.append("<div class=\"cell\" id=\"cell-" + i + "-" + j + "\">");
					 		        	    str.append("<div class=\"text\" id=\"text-" + i + "-" + j + "\"></div>");		
					 		        		str.append("</div>");
					 		        	}
					 		        	
					 		        	str.append("</div>");
					 		      }
					 %>
				  	<%=str.toString()%>
		    	</div>
		    </div>    
	
	
			<div class="container-right">
				<div class="container-right-above">
					<p class="time-remaining"><strong>Time Remaining:<strong></p>
					
					<div class="timer">
				    	<p id="countdown"></p>
				    </div>
				    
				    <div class="description-box">
				    	<p id="description"></p>
				    </div>
			    </div>
	    		
			    <div class="container-right-below">
				   <div class="yes-no-button">
				     	<div class="button-yes">
				     		<img id="yes-button" width="150px" height="50" onclick="handleYesButton()" src="<%=request.getContextPath()%>/Assets/button-yes.png"></img>
						    <!--  <button id="yes-button" onclick="handleYesButton()" ></button><br/> -->
						    <div id="user-answer"></div>
						</div>
					    
					    <div class="button-no">
					    	<img id="no-button" width="150px" height="50" onclick="handleNoButton()" src="<%=request.getContextPath()%>/Assets/button-no.png"></img>
					    	<!--  <button id="no-button" onclick="handleNoButton()">no</button> -->
					    </div>
					    
				    </div>
				  
				   <div class="restart-button-container">
						<div class="restart-button">	
						    <form action="<%= request.getContextPath() %>/Controller?" method="get">
						    	<input type="hidden" name="action" value="regenerate">
						    	<button id="restart" type="submit"></button>
						    </form>
					    </div>
				   </div>
				    
				</div> 
				
						  
			</div>
			 
			
    </div>
    
    
    <script>	
    
    var JSONMazeObject;
    var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){	
		if(xhr.readyState == 4 && xhr.status == 200)
		{
			var data = xhr.responseText;
			//alert(data);
		
			JSONMazeObject = eval('(' + data +')');
			
			//Put s into the cell
			var coorS = JSONMazeObject.s;
			coorS = coorS.split(",");
			
			putLetter("witch-right.png", coorS[0], coorS[1]);
			
			//Put x into the cells
			var listX = JSONMazeObject.x;
			for(var i = 0 ; i < listX.length ; i+=2)
		    {	    	
		    	putLetter("statue.jpg", listX[i], listX[i+1]);
		   	
		    }
		    
			//putLetter function
		    function putLetter(fileName, posX, posY)
		    {
		    	  var currCell_element = document.getElementById("text-" + posX + "-" + posY);
		    	  /*if(letter == "s")
		    	  		currCell_element.style.color= "#dbb42c";
		    	  else
		    	  		currCell_element.style.color= "white";*/
		    	  
		    	  console.log(fileName);
		    	  var str = '<img class="cell-image" width="40px" height="40px" src="/Can_You_Hide/Assets/' + fileName + '"></img>';
		    	  console.log(str);
		    	  currCell_element.innerHTML = str;
		    }
			
			
		}
	};
	var url = "<%= request.getContextPath() %>" + "/Controller?action=generate";
	xhr.open("GET", url, true);
	xhr.send(null);
    
	
    
    
  	//start count down
  	/*var tryMeClick = false;
  	var delay = 0;
  	var clock = 4;
	var countdown_element = document.getElementById("countdown");
	countdown_element.innerHTML = clock;
	
	for(var i = 0 ; i <= 25 ; i++)
	{
		
		setTimeout(function(){
			getTime();
		}, delay);
			
		delay = delay + 1000;
		
		
		
	}
	
	function getTime()
	{
		countdown_element.innerHTML = clock;
		clock = clock-1;
		if(clock == 0)
		{
			alert("test test");
		}
		
	}*/
	
	var tryMeClick = false;
	var delay = 0;
	var clock = 5;
	var countdown_element = document.getElementById("countdown");
	countdown_element.innerHTML = clock;

	function getTime(){
	  console.log(clock);
	  countdown_element.innerHTML = clock;
	  clock = clock - 1;

	  if(clock != 0 && !tryMeClick){
	    setTimeout(getTime, 1000);
	  }

	  if(clock == 0){
	    alert("Clock reaches 0");
	  }
	}

	setTimeout(getTime, 1000);
	
	
	
    </script>
    	
    
    
    <script>   
    function handleYesButton()
	{
		var userAnswerElement = document.getElementById("user-answer");
    	var str = '<div class="cast-field"><p class="cast-field-top"><i>Spell your cast!</i></p>'; 
    	str += '<div class="cast-field-below"><input id="answer" type="text">';
    	str += '<img id="cast-button" onclick="renderAndSolve()" src="/Can_You_Hide/Assets/enter-button.png"></img>';
    	//str += '<button id="cast-button" onclick="renderAndSolve()"> Go </button></div>';
    	str += '</div></div>'
    	userAnswerElement.innerHTML = str;
    		
	}
	
	function renderAndSolve()
	{
		//break time out
		tryMeClick = true;

		//render
		var positionStr = document.getElementById("answer").value;
		var position = positionStr.split(",");
		
		var currCell_element = document.getElementById("text-" + position[0] + "-" + position[1]);
		currCell_element.style.color="#e71414";
		var str = '<img class="cell-image" width="40px" height="40px" src="/Can_You_Hide/Assets/' + "gate.jpg" + '"></img>';
    	currCell_element.innerHTML = str;
		
		//solve
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){	
			if(xhr.readyState == 4 && xhr.status == 200)
    		{
    			var data = xhr.responseText;
    			//alert(data);
    		
    			var JSONInfectedObject = eval('(' + data +')');
    			
    			//Put s into the cells
    			var listInfected = JSONInfectedObject.infected;
    			var delay = 500;
    			for(var i = 0 ; i < listInfected.length ; i+=2)
    		    {	    	
    		    	putLetter("witch-right.png", listInfected[i], listInfected[i+1]);
    		    	
    		    }
    		    
    			//putLetter function
    		    function putLetter(letter, posX, posY)
    		    {
    		    	  window.setTimeout(function(){
          		    	  appear(letter, posX, posY);
          		      }, delay)
          		      
          		      delay = delay + 200;
    		    }
    			
				//animation effect
    			function appear(fileName, posX, posY)
  		    	{
    				var currCell_element = document.getElementById("text-" + posX + "-" + posY);
      		    	/*currCell_element.style.color="#dbb42c";*/
      		    	var str = '<img class="cell-image" width="40px" height="40px" src="/Can_You_Hide/Assets/' + fileName + '"></img>';
      		    	currCell_element.innerHTML = str;
  		    	}
    			
    		  	//check if user is alive or dead
    		  	setTimeout(function(){
    		  		var descriptionElement = document.getElementById("description");
        			descriptionElement.innerHTML = "";
        			if(JSONInfectedObject.canHide == true)
        				descriptionElement.innerHTML = "You are, indeed, our hero!";
        			else
        				descriptionElement.innerHTML = "We got caught!";
    		  	}, delay);
    		  			
    			
    		}
			
			
		};
		
		s = JSONMazeObject.s;
		x = JSONMazeObject.x;
		var url = "<%= request.getContextPath() %>" + "/Controller?action=solve&e=" + positionStr + "&s=" + s + "&x=" + x;
		xhr.open("GET", url, true);
		xhr.send(null);
		
		
		
	}
	
    	
    	
    </script>
    
    
    
    <script>
    	function handleNoButton()
    	{
    		//solve
    		var xhr = new XMLHttpRequest();
    		xhr.onreadystatechange = function(){	
    			if(xhr.readyState == 4 && xhr.status == 200)
        		{
        			var data = xhr.responseText;
        			//alert(data);
        		
        			var JSONInfectedObject = eval('(' + data +')');
        			
        			//Put s into the cells
        			var listInfected = JSONInfectedObject.infected;
        			var delay = 500;
        			for(let i = 0 ; i < listInfected.length ; i+=2)
        		    {	
        				
        		    	putLetter("witch-right.png", listInfected[i], listInfected[i+1]);
        		    	
        		    }
        		    
        			//putLetter function
        		    function putLetter(fileName, posX, posY, i)
        		    {
        		          
            		      window.setTimeout(function(){
            		    	  appear(fileName, posX, posY);
            		      }, delay)
            		      
            		      delay = delay + 200;	      
            		
        		    }
        		    
  					//animation effect
        		    function appear(fileName, posX, posY)
      		    	{
        		    	var currCell_element = document.getElementById("text-" + posX + "-" + posY);
	      		    	//currCell_element.style.color="#dbb42c";
	      		    	var str = '<img class="cell-image" width="40px" height="40px" src="/Can_You_Hide/Assets/' + fileName + '"></img>';
	      		    	currCell_element.innerHTML = str;
					
      		    	}
  	    
        		    
        		  	//check if user is alive or dead
        		  	setTimeout(function(){
        		  		var descriptionElement = document.getElementById("description");
            			descriptionElement.innerHTML = "";
            			if(JSONInfectedObject.canHide == true)
            			{
            				var safeSpot = JSONInfectedObject.safeSpot;
            				descriptionElement.innerHTML = "I just opened the gate for us at " + safeSpot;
            				safeSpot = safeSpot.split(",");
            				var currCell_element = document.getElementById("text-" + safeSpot[0] + "-" + safeSpot[1]);
    	      		    	/*currCell_element.style.color="yellow";
    	      		    	currCell_element.innerHTML = "";*/
    	      		    	var str = '<img class="cell-image" width="40px" height="40px" src="/Can_You_Hide/Assets/' + "gate.jpg" + '"></img>';
    	      		    	currCell_element.innerHTML = str;
            			}
            			else
            				descriptionElement.innerHTML = "This is our last final goodbye";
        		  	}, delay);
        		  		
        		}
    			
    			
    		};
    		
    		s = JSONMazeObject.s;
    		x = JSONMazeObject.x;
    		var url = "<%= request.getContextPath() %>" + "/Controller?action=solve" + "&s=" + s + "&x=" + x;
    		xhr.open("GET", url, true);
    		xhr.send();
    	}
    </script>
    
   
    

    
    
    
    
    
    
    
    
    
</body>
</html>