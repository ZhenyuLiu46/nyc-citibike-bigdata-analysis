import java.io.IOException;
import org.apache.hadoop.io.IntWritable; 
import org.apache.hadoop.io.LongWritable; 
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import java.util.*;



public class tempMapper 
		extends Mapper<LongWritable, Text, Text, Text> {
	@Override
	public void map(LongWritable key, Text value, Context context) 
		throws IOException, InterruptedException {

		if (key.get() == 0 ) 
            return;
       	else {
	       	String line = value.toString();
			String[] words = line.split(",");

			if (words[1].contains("CENTRAL")){ //only use nyc central park station
				
				
				 String temp = words[words.length - 12]; //get temperature
				
				String wind = words[words.length - 2];
				String time = words[3].substring(1, 14); // get time
				String precip = words[9]; //get precip
				if (!precip.equals("") && temp.length() == 6 && temp.charAt(2) != '9' && wind.charAt(0) != '9'){
					context.write(new Text(time), new Text(temp.substring(1) + "\t" + precip  + "\t" + wind));
				}
				
			}
        }
	}
}


