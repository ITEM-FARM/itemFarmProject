package vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class StatisticsVO {
	
	// for 카테고리별
	private String order_subcategory_name; 
	private String cancel_subcategory_name;
	
	// for 상품별
	private String order_product_name;
	private String cancel_product_name;
	private int order_product_code;
	private int cancel_product_code;
	
	// for 일별 
	private String order_register; // 주문일자 
	private String cancel_register; // 취소일자 
	
	// 공통
	private int order_count; // a1. 주문수량
	private int order_amount; // a2. 주문금액
	
	private int cancel_count; // b1. 취소수량
	private int cancel_amount; // b2. 취소금액
	
	private int revenue_count; // c1. 순매출 수량 = a1 - b1
	private int revenue_amount; // c2. 순매출 금액 = a2 - b2
	
	private int order_cost; // 주문원가
	private int cancel_cost; // 취소원가
	
	private int total_cost; // 판매원가 (=총 원가)
	
	private double net_profit; // d1. 순이익금액 = c2 * (1-e)
	private double net_profit_margin; // d2. 순이익률 = (순이익/순매출) * 100(%)

	private double commission;
}
