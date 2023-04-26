package vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Setter @Getter @ToString
public class WarehousingVO implements Comparable<WarehousingVO>{
	private String warehousing_state;
	private int product_code;
	private String product_name;
	private String balju_code;
	private Date warehousing_date;
	private int warehousing_quantity;
	
	@Override
	public int compareTo(WarehousingVO obj) {
		// 은빈: 입출고 날짜 내림차순, 상품 번호 오름차순 정렬
		int result1 = obj.warehousing_date.compareTo(warehousing_date);
		int result2 = product_code - obj.product_code;
		
		if(result1 == 0) {
			return result2;
		}
		
		return result1;
	}
	
	
}
