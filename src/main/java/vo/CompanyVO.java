package vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
@ToString
public class CompanyVO {
	private int company_id;
	private String company_name;
	private String company_pw;
	private double company_commission;
	private char company_status;
}

