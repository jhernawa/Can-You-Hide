package com.canyouhide;

import java.util.*;

public class Maze {
	
	private final Random r = new Random();
	private final int row = 7;
	private final int col = 7;
	private final int max = 40;
	private final int min = 20;
	private String s;
	private String e;
	private ArrayList<Integer> x;
	private ArrayList<Integer> infected;
	private ArrayList<String> safeSpot;
	private int idxSafeSpot;
	
	String[][] maze;
	private int rowS;
	private int colS;
	boolean canHide;
	public Maze() {
		s = "";
		e = "";
		x = new ArrayList<Integer>();
		infected = new ArrayList<Integer>();
		safeSpot = new ArrayList<String>();
		idxSafeSpot = 0;
		
		maze = new String[row][col];
		rowS = 0;
		colS = 0;
		
		canHide = true;
	}
	
	public Maze(String s, String e, ArrayList<Integer> x)
	{
		this.s = s;
		this.e = e;
		this.x = x;
		
		infected = new ArrayList<Integer>();
		safeSpot = new ArrayList<String>();
		idxSafeSpot = 0;
		
		maze = new String[row][col];
		
		//put s into map
		String[] coorS = s.split(",");
		rowS = Integer.parseInt(coorS[0]);
		colS = Integer.parseInt(coorS[1]);
		
		maze[rowS][colS] = "s";
		
		//put x into map
		for(int i = 0 ; i < x.size() ; i+=2)
		{
			maze[x.get(i)][x.get(i+1)] = "x";
		}
		
		canHide = true;
		
		
	}
	public void generateMaze(){
		
		HashSet<String> set = new HashSet<String>();
		
		//generate random amount of x
		int amountX = r.nextInt((max-min)+1) + min;
		x = new ArrayList<Integer>();
		System.out.println("amountX: " + amountX);
		//generate random coordinate of s
		int x_coorS = r.nextInt(row);
		int y_coorS = r.nextInt(col);
		
		s = x_coorS + "," + y_coorS;
		set.add(s);
		
		//put s to maze
		maze[x_coorS][y_coorS] = "s";
		rowS = x_coorS;
		colS = y_coorS;
		
		//generate random coordinate of x(s)
		ArrayList<Integer> availableSpotRow = new ArrayList<Integer>();
		ArrayList<Integer> availableSpotCol = new ArrayList<Integer>();
		
		for(int i = 0 ; i < row ; i++)
		{
			for(int j = 0 ; j < col ; j++)
			{
				if(i == rowS && j == colS) continue;
				
				availableSpotRow.add(i);
				availableSpotCol.add(j);
			}
		}
		
		int getSpot = 0;
		while(getSpot != amountX)
		{
			int idx = r.nextInt(availableSpotRow.size());
			
			x.add(availableSpotRow.get(idx));
			x.add(availableSpotCol.get(idx));
			
			availableSpotRow.remove(idx);
			availableSpotCol.remove(idx);
			
			getSpot++;
			
			
		}
		
		
	}
	
	public void solve(boolean isExistE)
	{
		int[] dirR = {0, 0, -1, 1};
		int[] dirC = {-1, 1, 0, 0};
		
		LinkedList<Integer> rows = new LinkedList<Integer>();
		LinkedList<Integer> cols = new LinkedList<Integer>();
		
		boolean[][] marked = new boolean[row][col];
		
		marked[rowS][colS] = true;
		rows.add(rowS);
		cols.add(colS);
	
		int x_coorE = 0;
		int y_coorE = 0;
		if(isExistE)
		{
			System.out.println("masuk k check e");
			String[] coorE = e.split(",");
			x_coorE = Integer.parseInt(coorE[0]);
			y_coorE = Integer.parseInt(coorE[1]);
			maze[x_coorE][y_coorE] = "e";
			System.out.println("e_x: " + x_coorE);
			System.out.println("e_y: " + y_coorE);
		}
		while(rows.size() != 0)
		{
			int currR = rows.remove(0);
			int currC = cols.remove(0);
			
			if((isExistE) && (currR == x_coorE && currC == y_coorE))
				canHide = false;
			
			infected.add(currR);
			infected.add(currC);
			
			for(int i = 0 ; i < 4 ; i++)
			{
				int nextR = currR + dirR[i];
				int nextC = currC + dirC[i];
				
				if(nextR < 0 || nextR >= row) continue;
				if(nextC < 0 || nextC >= col) continue;
				if(marked[nextR][nextC] || maze[nextR][nextC] == null)
				{
					System.out.println("nextR: " + nextR + ", nextC: " + nextC);
					if(marked[nextR][nextC]) System.out.println("marked true");
					if(maze[nextR][nextC] == null) System.out.println("cell empty");
					continue;
				}
				
				
				
				
				marked[nextR][nextC] = true;
				rows.add(nextR);
				cols.add(nextC);
			}
		}
		
		
		if(!isExistE)
		{
			for(int i = 0 ; i < row ; i++)
			{
				for(int j = 0 ; j < col ; j++)
				{
					int currR = i;
					int currC = j;
					
					if(marked[currR][currC] || maze[currR][currC] != null) continue;
					
					boolean validCell = true;
					for(int k = 0 ; k < 4 ; k++)
					{
						int nextR = currR + dirR[k];
						int nextC = currC + dirC[k];
						
						if(nextR < 0 || nextR >= row) continue;
						if(nextC < 0 || nextC >= col) continue;
						if(marked[nextR][nextC]) validCell = false;
					}
					
					if(validCell)
					{
						String spot = currR + "," + currC;
						safeSpot.add(spot);
					}
					else
						validCell = true;
						
					
				}
			}
			
			if(safeSpot.size() == 0) 
				canHide = false;
			else
			{
				idxSafeSpot = r.nextInt(safeSpot.size());
				canHide = true;
			}
		}
		
		
	}

	public ArrayList<String> getSafeSpot() {
		return safeSpot;
	}

	public void setSafeSpot(ArrayList<String> safeSpot) {
		this.safeSpot = safeSpot;
	}

	public int getIdxSafeSpot() {
		return idxSafeSpot;
	}

	public void setIdxSafeSpot(int idxSafeSpot) {
		this.idxSafeSpot = idxSafeSpot;
	}

	public boolean isCanHide() {
		return canHide;
	}

	public void setCanHide(boolean canHide) {
		this.canHide = canHide;
	}

	public String getS() {
		return s;
	}

	public void setS(String s) {
		this.s = s;
	}

	public String getE() {
		return e;
	}

	public void setE(String e) {
		this.e = e;
	}
	
	public ArrayList<Integer> getX() {
		return x;
	}

	public void setX(ArrayList<Integer> x) {
		this.x = x;
	}

	public ArrayList<Integer> getInfected() {
		return infected;
	}

	public void setInfected(ArrayList<Integer> infected) {
		this.infected = infected;
	}

	
	
	
	/*public static void main(String[] args)
	{
		
		MazeGenerator maze = new MazeGenerator();
		maze.generateMaze();
		
		System.out.println("s: " + maze.getS());
		for(int i = 0 ; i < maze.getX().size() ; i+=2)
		{
			System.out.println("x: " + maze.getX().get(i) + ", y: " + maze.getX().get(i+1) + " at " + i);
		
		}
		
		
		
	}*/
	
}
