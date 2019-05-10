import java.io.IOException;
import org.apache.hadoop.io.IntWritable; 
import org.apache.hadoop.io.LongWritable; 
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import java.util.*;

// hourly nyc bike data

public class bikeMapper 
		extends Mapper<LongWritable, Text, Text, IntWritable> {
	@Override
	public void map(LongWritable key, Text value, Context context) 
		throws IOException, InterruptedException {

		if (key.get() == 0 ) 
            return;
       	else {
	       	String line = value.toString();
			String[] words = line.split(",");
			
			String out = words[1].substring(1,11) + "T" + words[1].substring(12,14) ;

			context.write(new Text(out), new IntWritable(1));
                
        }
		

	
	}
}


