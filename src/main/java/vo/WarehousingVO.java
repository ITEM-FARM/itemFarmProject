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
public class WarehousingVO {
	private String warehousing_state;
	private int product_code;
	private String product_name;
	private String balju_code;
	private Date warehousing_date;
	private int warehousing_quantity;
}
