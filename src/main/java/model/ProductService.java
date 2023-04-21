package model;

import java.util.List;

import vo.ProductVO;

public class ProductService {
	ProductDAO dao = new ProductDAO();
	
	//이솔: product 상품명, 상품코드 톻합검색
	public List<ProductVO> productSelect(String selectValue,String valueType){
		return dao.productSelect(selectValue, valueType);
		
	}
}
