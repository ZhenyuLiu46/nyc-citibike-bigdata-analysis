import java.io.IOException;
import org.apache.hadoop.io.IntWritable; 
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;
public class tempReducer
		extends Reducer<Text, Text, Text, Text> {
	@Override
	public void reduce(Text key, Iterable<Text> values, Context context) 
			throws IOException, InterruptedException {
		String finalValue = ""; 
		for (Text value : values) {
		    finalValue  = value.toString();
		}
		context.write(key, new Text(finalValue)); 
	}
}

