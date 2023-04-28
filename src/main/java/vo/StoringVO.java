package vo;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor

public class StoringVO {
	//storingList
	private String storing_code;
	private String manager_id;
	private Timestamp storing_date;
	private String storing_memo;
	
	//storingDetail
	private int product_code;
	private String balju_code;
	private int storing_quantity;
	private String product_name;
	
	
	
}
