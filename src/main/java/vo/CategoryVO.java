package vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Setter @Getter @ToString
public class CategoryVO {
	private String category_code;
	private String category_name;
	private String subcategory_name;
}
