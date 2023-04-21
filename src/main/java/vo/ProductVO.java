package vo;

import java.sql.Timestamp;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter // @ToString
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
	 
	 //안전재고-현재재고 저장용(select 시 필요)
	 private int order_quantity;

	 // 은빈: modal에 객체 전달을 위해 toString 재정의 (띄어쓰기 반영 되는지 확인 필요)
	 @Override
		public String toString() {
			String str = "";
			str += "'product_code':" + product_code;
			str += ",'subcategory_name':" + subcategory_name;
			str += ",'company_id':" + company_id;
			str += ",'product_name':" + product_name;
			str += ",'product_cost':" + product_cost;
			str += ",'product_price':" + product_price;
			str += ",'product_stock':" + product_stock;
			str += ",'product_safety':" + product_safety;
			str += ",'product_status':" + product_status;
			str += ",'product_regdate':" + product_regdate;
			str += ",'manager_id':" + manager_id;
			str += ",'order_quantity':" + order_quantity;

			return str;
		}
	 

	 //통합검색 시 필요
	 private String total_select;

}
