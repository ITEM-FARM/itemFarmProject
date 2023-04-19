package vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor

public class StoringVO {
	private String balju_code;
	private String manager_id;
	private String storing_code;
	private Date storing_date;
	private String storing_id;
	private String storing_memo;
}
