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
	
	// (일단 스트링으로 하고 나중에 상황봐서 Date로)
	private String order_register; // 주문일자 
	private String cancel_register; // 취소일자 
	
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
	
	// String.format 메소드를 써야돼서 String 타입으로 지정하였음. => (정정) 
	private double net_profit_margin; // d2. 순이익률 = (순이익/순매출) * 100(%)

	// e. 커미션??
}
