import java.io.IOException;
import org.apache.hadoop.io.IntWritable; 
import org.apache.hadoop.io.LongWritable; 
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import java.util.*;


public class bikeMapperInfo 
		extends Mapper<LongWritable, Text, Text, IntWritable> {
	@Override
	public void map(LongWritable key, Text value, Context context) 
		throws IOException, InterruptedException {

		if (key.get() == 0 ) 
            return;
       	else {
	       	String line = value.toString();
			String[] words = line.split(",");
			
			String startTime = words[1].substring(1,11) + "T" + words[1].substring(12,14) + "T";
			String tripDuration = words[0];
			String startStationID = words[3];
			String startStationName = words[4];
			String startStationlatitude = words[5];
			String startStationlongitude = words[6];
			String endStationID = words[7];
			String endStationName = words[8];
			String endStationLatitude = words[9];
			String endStationLongtitude = words[10];
			String userType = words[words.length - 3];
			String birthYear = words[words.length - 2];
			String gender = words[words.length - 1];

			context.write(new Text(startTime + "\t" + tripDuration + "\t" + startStationID + "\t" 
				+ startStationName + "\t" + startStationlatitude + "\t" +  startStationlongitude 
				+ "\t" + endStationID + "\t" + endStationName + "\t" + endStationLatitude + "\t" + endStationLongtitude 
				+ "\t" + userType + "\t" + birthYear + "\t" + gender), new IntWritable(1));
                
        }

	
	}
}


