import java.util.ArrayList;

public class Values
{
	private ArrayList<Integer> code;
	private int dimension;
	
	public Values(ArrayList<Integer> code, int dimension)
	{
		this.code=code;
		this.dimension=dimension;
	}
	
	public ArrayList<Integer> getCode()
	{
		return code;
	}
	
	public int getDimension()
	{
		return dimension;
	}
}
