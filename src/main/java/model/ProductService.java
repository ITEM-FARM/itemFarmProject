package model;

import java.util.List;

import vo.ProductVO;

public class ProductService {
	ProductDAO dao = new ProductDAO();
	
	//이솔: product 상품명, 상품코드 톻합검색
	public List<ProductVO> productSelect(String selectValue,String valueType, int comId){
		return dao.productSelect(selectValue, valueType, comId);	
	}
	
	// 은빈: 특정 기업의 전체 상품 조회
	public List<ProductVO> productList(int comID, String cond) {
		return dao.productList(comID, cond);
	}
	
	// 은빈: 상품 정보 수정
	public String productModify(ProductVO product) {
		int result = dao.productModify(product);
		return result > 0 ? "정보를 수정했습니다." : "정보 수정에 실패했습니다.";
	}
	
	// 은빈: 상품 등록
	public String productInsert(ProductVO product) {
		int result = dao.productInsert(product);
		return result > 0 ? "등록에 성공했습니다." : "등록에 실패했습니다.";
	}
}
