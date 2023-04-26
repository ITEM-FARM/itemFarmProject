package model;

import java.util.List;

import vo.WarehousingVO;

public class WarehousingService {
	WarehousingDAO dao = new WarehousingDAO();
	
	public List<WarehousingVO> warehousingList(int comID, String cond) {
		return dao.warehousingList(comID, cond);
	}
}
