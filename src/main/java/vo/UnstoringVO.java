package vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UnstoringVO {
	// 용희 : 출고VO (순서는 '주문건 등록 페이지'에 맞췄음)
	// 참조 : EmpVO

	private String unstoring_code; // 주문번호
	private String customer_name; // 주문자 성함
	private String customer_address; // 주문자 주소
	private Date order_register; // 주문일자
	private Date unstoring_date; // 출고일자
	private String unstoring_memo; // 주문메모
	private String manager_id; // 출고담당자
	private String tracking_number; // 송장번호 (일단 String으로 할까?? 나중에 long이나 double, 맞는 거롤 바꾸고)
	private String unstoring_state; // 출고상태

}
