package com.canyouhide;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * Servlet implementation class MazeSolver
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private Maze maze;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());

		String action = request.getParameter("action");
		
		if(action != null)
		{
			//enter game
			if(action.equals("enter"))
			{
				response.sendRedirect(request.getContextPath() + "/game.jsp");
			}
			//regenerate maze
			else if(action.equals("regenerate"))
			{
				response.sendRedirect(request.getContextPath() + "/game.jsp");
			}
			//generate maze
			else if(action.equals("generate"))
			{
				HashMap<String, Object> map = new  HashMap<String, Object>();
				maze = new Maze();
				maze.generateMaze();
				
				map.put("s", maze.getS());
				map.put("x", maze.getX());
				
				generateJSON(response, map);
			}
			
			//solve maze
			else if(action.equals("solve"))
			{
						
				String coorE = request.getParameter("e");
				String coorS = request.getParameter("s");
				String coorX = request.getParameter("x");
				
				//initialize the maze
				ArrayList<Integer> coorX_Int = new ArrayList<Integer>();
				String[] coorX_str = coorX.split(",");
				for(int i = 0 ; i < coorX_str.length ; i++)
				{
					coorX_Int.add(Integer.parseInt(coorX_str[i]));
				}
				
				maze = new Maze(coorS, coorE == null ? "": coorE , coorX_Int);
				
				//yes-button solve
				if(coorE != null && coorS != null && coorX != null)
				{
								
					//solve maze
					maze.solve(true);
					ArrayList<Integer> infected = maze.getInfected();
					
					//response as JSON
					HashMap<String, Object> map = new  HashMap<String, Object>();
					
					map.put("s", maze.getS());
					map.put("x", maze.getX());
					map.put("e", maze.getE());
					map.put("canHide", maze.isCanHide());
					map.put("infected", infected);
					
					System.out.println("INFECTED CELLS: " + infected);
					
					generateJSON(response, map);
				}
				//no-button solve
				else
				{
					//solve maze
					maze.solve(false);
					ArrayList<Integer> infected = maze.getInfected();
					
					//response as JSON
					HashMap<String, Object> map = new  HashMap<String, Object>();
					
					map.put("s", maze.getS());
					map.put("x", maze.getX());
					if(maze.getSafeSpot().size() != 0)
						map.put("safeSpot", maze.getSafeSpot().get(maze.getIdxSafeSpot()));
					map.put("canHide", maze.isCanHide());
					map.put("infected", infected);
					
					System.out.println("INFECTED CELLS: " + infected);
					
					generateJSON(response, map);
				}
				
				
			}
			
			
			
			
		}
		
	}

	private void generateJSON(HttpServletResponse response, HashMap<String, Object> map) throws IOException
	{
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(new Gson().toJson(map));
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
			
		
	}

}
