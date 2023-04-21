package vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter @ToString
public class BaljuVO {
	
	 //[태영] 발주와 발주detail table이 같이 쓰는 친구
	 private String balju_code;
	 
	 //[태영] 발주 table에 들어갈 친구
	 private String manager_id;
	 private Timestamp balju_date;
	 private String balju_memo;
	 
	 //[태영] 발주 detail table에만 들어가는 친구
	 private int product_code;
	 private int balju_quantity;
}
