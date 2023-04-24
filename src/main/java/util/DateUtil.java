package util;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


// 참조 : WebShop - DateUtil
public class DateUtil {
	
	public static Date convertToDate(String sdate){
			
			SimpleDateFormat sdf =
			new SimpleDateFormat("yyyy-MM-dd"); 
			Date sqlDate = null; 
			
			try {
				// util의 Date
				java.util.Date d = sdf.parse(sdate); // 여기서의 Date는 sql이 아니라 util의 Date를 import 해야 된다고?? why??
				
				// 얘는 sql의 Date
				sqlDate = new Date(d.getTime());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			  
			return sqlDate;
			  
		}

}
