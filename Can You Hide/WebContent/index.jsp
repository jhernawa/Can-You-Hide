<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Can You Hide</title>
<link href="<%=request.getContextPath()%>/CSS/welcome.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/App/app.js"></script>
</head>
<body>
	
	
	<div class="main-box">
		
	
	
		<div class="outer-box">
			<div class="inner-box">
				<h1 class="to">To: Whom It May Concern</h1>
				<br>
				<p>Our Shorezig School of Witchcraft and Wizardry is currently being attacked.</p>
				<p>We need to open the gate to the safe house to evacuate everybody.</p>
				<p>However, we need your help to locate where we should open the gate</p><br>
				<p>Here is the rule:<p>
				
				<div class="list">
				
					<p>1. The black-hat wizard master would turn the statues around our school to be black-hat wizard followers.</p>
					<p>2. The black-hat wizard followers can also turn other statues to be black-hat wizard followers.</p>
					<p>3. Fortunately, the limited skill these black-hat wizards have only allow them to cast spells on the statues around them in 4 directions (n, s, w, e).</p>
					<p>4. The secret spell to open the gate is "posX,posY", where posX is the x coordinate and posY is the y coordinate of the maze (0,0 is the cell at the upper left corner).</p>
					
				</div>
				<br>
				<h4>Hurry!</h4>
				<p>Please help us all! Our destiny is in your hand.</p>
				
				<p><i>P.S: This attack could be our last moment to stand on the ground.. </i></p>	
				
				<form action="<%=request.getContextPath()%>/Controller" method="get">
					<input type="hidden" name="action" value="enter"/>
					<button id="button-fly" type="submit">Fly to Shorezig</button>
				</form>
				
				
				
			</div>
		</div>
	</div>
	
    

    
    
    
    
    
    
    
    
    
</body>
</html>