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
public class ProductVO {

	 private int product_code;
	 private String subcategory_name;
	 private int company_id;
	 private String product_name;
	 private int product_cost;
	 private int product_price;
	 private int product_stock;
	 private int product_safety;
	 private char product_status;
	 private Timestamp product_regdate;
	 private String manager_id;
	 
}
