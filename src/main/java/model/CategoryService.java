package model;

import java.util.List;

import vo.CategoryVO;

public class CategoryService {
	CategoryDAO dao = new CategoryDAO();
	
	public List<CategoryVO> categoryList() {
		return dao.categoryList();
	}
	
	public List<CategoryVO> subcategoryList() {
		return dao.subcategoryList();
	}
}
