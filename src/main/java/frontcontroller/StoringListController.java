package frontcontroller;

import java.util.Map;

public class StoringListController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		return "/storing/storing_list.jsp";
	}

}
