package vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
public class CompanyVO implements Serializable{
	private int company_id;
	private String company_name;
	private String company_pw;
	private double company_commission;
	private char company_status;
	
	@Override
	public String toString() {
		String str = "";
		str += "'company_id' : " + company_id;
		str += ",'company_name' : " + company_name;
		str += ",'company_pw' : " + company_pw;
		str += ",'company_commission' : " + company_commission;
		str += ",'company_status' : " + company_status;

		return str;
	}

}
