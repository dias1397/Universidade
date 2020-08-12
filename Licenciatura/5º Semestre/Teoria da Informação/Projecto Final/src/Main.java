import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;
import joptsimple.OptionException;
import joptsimple.OptionParser;
import joptsimple.OptionSet;

public class Main
{/*
	public ArrayList<Integer> readUncompressed(File file )throws IOException
	{
		BufferedReader br = new BufferedReader(new FileReader(file));
		ArrayList<Integer> bitmap = new ArrayList<>();

		try 
		{
			//int cont=0;
			String line = br.readLine();
			int remove;

			if (line.equals("P1"))
				line = br.readLine();

			while(line.charAt(0)=='#')
				line = br.readLine();
			
			String[] size = line.split(" ");
			System.out.println(size[0]);

			for(; (line = br.readLine()) != null; )
			{
				for(byte b : line.getBytes())
				{
					String interger = Integer.toBinaryString(b);
					if(interger.equals("110000"))
						bitmap.add(0);
					else if(interger.equals("110001"))
						bitmap.add(1);
					//	cont++;
				}
			}
			/*for(int i=0; i<bitmap.size(); i++)
		    {
		    	if(0==i%512)
		        	System.out.println();
		    	System.out.print(bitmap.get(i));
		    }*//*
		} 
			finally 
		{
			br.close();
		}

		return bitmap;
	}*/

	public Values readFile(File file)throws IOException
	{
		ArrayList<Integer> code = new ArrayList<>();
		Scanner scan = new Scanner(file);

		scan.nextLine();
		
		String str=null;
		while((str=scan.nextLine()).charAt(0) == '#')	// salta uma linha
			;	
		
		while(scan.hasNextInt())
			code.add(scan.nextInt());

		return new Values(code,Integer.parseInt(str.split(" ")[0]));
	}

	public void writeFile(ArrayList<Integer> decode, File file, int x, int y)throws IOException
	{
		BufferedWriter bw = new BufferedWriter(new FileWriter(file));

		bw.write("P1");
		bw.newLine();

		// Write comentarios

		bw.write(x + " " + y);
		bw.newLine();

		for(int i=0; i<decode.size(); i++)
		{
			bw.write(decode.get(i).toString() + " ");
			if(i%100==0 && i!=0){
				bw.newLine();
			}
		}
		bw.flush();
		bw.close();
	}

	public double log2(double x)
	{
		return Math.log10(x)/Math.log10(2.0);
	}

	public double entropia(ArrayList<Integer> dados)
	{
		int 	cont0 = 0,
				cont1 = 0;
		double entropia, px, py;

		for (int i=0; i<dados.size(); i++)
		{
			if (dados.get(i).equals(0))
				cont0++;
			if (dados.get(i).equals(1))
				cont1++;
		}
		px = cont0/(double)dados.size();
		py = cont1/(double)dados.size();

		entropia = (double) -((px*log2(px))+(py*log2(py)));
		return entropia;
	}

	public static void main(String[] args)
	{
		OptionParser parser = new OptionParser();
        parser.accepts("compress", "Compress the file on path and show its entropy").withRequiredArg().ofType(String.class).describedAs("Path of file");
        parser.accepts("decompress", "Decompress the file on path").withRequiredArg().ofType(String.class).describedAs("Path of file");
        parser.accepts("h", "show help" ).forHelp();
        
        Main body = new Main();
		LZW lzw = new LZW();
		
		File compressed = new File("compress");
		File new_decompressed = new File("decompress.pbm");
        
        try
        {
        	OptionSet options = parser.parse(args);
        	
        	if (options.has("compress"))
            {
            	//System.out.println(options.valueOf("comment"));
            	
    			String path = (String) options.valueOf("compress");
    			
    			try 
    			{
    				File file = new File(path);
    				Values file_read = body.readFile(file);
    				
    				ArrayList<Integer> code = new ArrayList<>();
    	        	
    	        	code = lzw.compress(file_read.getCode());
    				body.writeFile(code, compressed, file_read.getDimension(), file_read.getDimension());
    				
    				double ent = body.entropia(file_read.getCode());
    				System.out.println("\nEntropy: "+ent);
    				System.out.println("File Compressed");
    			}
    			catch(FileNotFoundException e)
    			{
    				System.out.println("\nFile not Found");
    			}
    			catch(IOException e)
    			{
    				System.out.println("\nProblem on writing");
    			}
    			
    			
            }
            else if(options.has("decompress"))
            {
            	String path = (String) options.valueOf("decompress");
            	
            	try
            	{
            		File file = new File(path);
        			Values file_read = body.readFile(file);
        			
        			ArrayList<Integer> code = new ArrayList<>();
                	
                	code = lzw.compress(file_read.getCode());
        			body.writeFile(code, compressed, file_read.getDimension(), file_read.getDimension());
        			
                	code = lzw.decompress(file_read.getCode());	
        			body.writeFile(code, new_decompressed, file_read.getDimension(), file_read.getDimension());
        			System.out.println("\nFile Decompressed");
            	}
            	catch(FileNotFoundException e)
            	{
            		System.out.println("\nFile not Found");
            	}
            	catch(IOException e)
    			{
    				System.out.println("\nProblem on writing");
    			}
            	
            }
        }
        catch(OptionException e)
        {
        	try
			{
        		System.out.println("\nCommand not found.\n");
				parser.printHelpOn( System.out );
			}
			catch (IOException e1)
			{
				System.out.println("Help doens't work");
			}
        }
        
	}
}

