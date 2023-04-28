package vo;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UnstoringDetailVO implements Serializable{
	
	private String unstoring_code; // 주문번호
	private int product_code; // 상품번호
	private int unstoring_quantity; // 주문한 상품수량
	private String product_name; // 주문한 상품명
	
	// 용희 : 주문건 상세조회 페이지에서 '주문자 정보'를 주기 위해 필요했음.
	private String customer_name; // 주문자 성함
	private String customer_address; // 주문자 주소
	private String tracking_number; // 송장번호 (일단 String으로 할까?? 나중에 long이나 double, 맞는 거롤 바꾸고)
	private String unstoring_state; // 출고상태
	private Timestamp unstoring_date;
	
	private Date order_register; // 엑셀 업로드를 위해 추가
	
	// ★ 끝날 때 되서 든 생각이지만 unstoring VO 그냥 하나만 있었어도 됐을 듯. 
	// 괜히 나누니까 개피곤하네

}
