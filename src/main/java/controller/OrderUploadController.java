package controller;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import frontcontroller.CommonInterface;
import model.UnstoringService;
import util.DateUtil;
import vo.CompanyVO;
import vo.ManagerVO;
import vo.UnstoringDetailVO;
import vo.UnstoringVO;

public class OrderUploadController implements CommonInterface {
	
	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		HttpSession session = request.getSession();
		UnstoringService service = new UnstoringService();
		
		
		// ordersInsert 를 하여 그 리턴값(아마도 배열, 왜냐면 executeBatch)을 얻어서 세션에 저장하자. 제대로 입력됐는지 
		int chk_insert = excelFileRead(request, service);
		request.setAttribute("chk_insert", chk_insert); // distpatch니까 세션이 아니라 리퀘스트에 저장하여 보여주기
		
		
		String page = "/unstoring/unstoring_insert.jsp";
		return page;
		
	}
	
	
	
	// 1. getFile : 업로드한 파일 얻기
	public static String getFile(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String fileName = null; 
		// uploads 폴더 안에 있는 파일에 대한 경로를 지정하기 위한 코드들
		String encoding = "utf-8";
		String currentPath = request.getServletContext().getRealPath("uploads"); // getRealPath() : uploads에 대한 절대 경로 얻기
		System.out.println(currentPath);
		File currentDirPath = new File(currentPath); // new File(경로) : 경로에 해당하는 새 파일 객체를 생성????
		
		DiskFileItemFactory factory = new DiskFileItemFactory(); // 업로드 관련 클래스 (1)
		factory.setRepository(currentDirPath); // setRepository() : 파일을 저장할 디렉토리를 설정합니다. (책 611)
		factory.setSizeThreshold(1024 * 1024); // setSizeThreshold() : 최대 업로드 가능한 파일 크기를 설정합니다.
		ServletFileUpload upload = new ServletFileUpload(factory); // 업로드 관련 클래스 (1)
		try {
			List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(new ServletRequestContext(request));
//			List items = upload.parseRequest( request); // parseRequest() : 전송된 매개변수를 List 객체로 얻습니다. (다만 타입이 여러가지일 수 있어서 generics를 지정하진 않은 듯)
			for (int i = 0; i < items.size(); i++) {
				FileItem fileItem = (FileItem) items.get(i);

				if (fileItem.isFormField()) { // input type이 file이 아닌 것
					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
				} else { // 즉, <input type="file"/> 인 놈들
					System.out.println("input 태그 이름 getFieldName:" + fileItem.getFieldName());
					System.out.println("선택한 파일 이름 getName:" + fileItem.getName());
					System.out.println("파일의 사이즈 getSize:" + fileItem.getSize() + "bytes");

					if (fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");
						}
						fileName = currentDirPath + "\\" + fileItem.getName().substring(idx + 1); // 파일의 이름만 짤라내기 위한 작업 (getName 후 substring)
						File uploadFile = new File(fileName);
						fileItem.write(uploadFile);
					} // end if
				} // end if 
			} // end for
		} catch (Exception e) {
			e.printStackTrace();
		}
		session.setAttribute("fileName", fileName);
		
		return fileName;
	}
	
	
	// 2. 1에서 얻은 엑셀파일을 읽는 메소드
	public static int excelFileRead(HttpServletRequest request, UnstoringService service) {
		UnstoringVO vo1 = null;
		UnstoringDetailVO vo2 = null;
		List<UnstoringDetailVO> list = new ArrayList<>();
		int rows = 0; // 사용자가 입력한 엑셀 row 수만큼 for문을 돌려서 '주문번호(PK)'를 만들기 위해서 여기다 선언함.
		
		// # service 작업을 위한 사전작업들
		HttpSession session = request.getSession();
		int company_id = (int) session.getAttribute("comId"); // (1) 세션으로부터 Company 정보 받고 
		ManagerVO managerUser = (ManagerVO) session.getAttribute("managerUser"); 
		String magID = managerUser.getManager_id(); // (2) 세션으로부터 manager_id 정보 받고
		String unstoring_code = createUnstroingCode(company_id, magID); // (3) 주문번호 만들기
		
		// # 엑셀파일 Read
		try {
			String path = getFile(request);
			System.out.println(path);
			// 경로에 있는 파일을 읽음.
			 
			XSSFWorkbook workbook = new XSSFWorkbook(new FileInputStream(path));

			int rowNo = 0;
//			int cellIndex = 0;

			XSSFSheet sheet = workbook.getSheetAt(0); // 0 번째 시트를 가져온다
														// 만약 시트가 여러개 인 경우 for 문을 이용하여 각각의 시트를 가져온다
			rows = sheet.getPhysicalNumberOfRows(); // 사용자가 입력한 엑셀 Row수를 가져온다
			System.out.println("rows "+rows);
			for (rowNo = 1; rowNo < rows; rowNo++) {
//				System.out.println(rowNo);
				XSSFRow row = sheet.getRow(rowNo);
//				System.out.println(row);
				if (row != null) {
					//int cells = row.getPhysicalNumberOfCells(); // 해당 Row에 사용자가 입력한 셀의 수를 가져온다
					//for (cellIndex = 0; cellIndex <= cells; cellIndex++) {
						String customer_name =  row.getCell(0).getStringCellValue() + ""; // 셀의 값을 가져온다
						String customer_address =  row.getCell(1).getStringCellValue() + ""; // 셀의 값을 가져온다
						double product_code = row.getCell(2).getNumericCellValue();
						double unstoring_quantity =  row.getCell(3).getNumericCellValue(); // 셀의 값을 가져온다
						String order_register =  row.getCell(4).getStringCellValue() + ""; // 셀의 값을 가져온다
						
						// index를 이용하여 "진짜로 DB에 넣을 주문번호를 생성" 
						// => for문 이후에 if문으로 '만약 이게 서로 같다면' 체크 후 
						// => (1) 즉, 1명의 주문자가 여러가지를 주문한 경우라면 : vo2가 여러개 (vo1도 1개만 세팅하게끔 설정해주기. 왜냐면 출고 테이블엔 insert가 1번밖에 안되니까 PK라서)
						// => (2) 각기 다른 주문자라면 : 그냥 하면 됨.
						// 일단 포기..
						
						
						// VO를 만들어서 세팅해서 넘기기만 하면 된다!
						// VO 만들고 List에 넣어서 DAO에 보내
						// DAO에선 다시 for문으로 addBatch, executeBatch하여 insert
						vo1 = new UnstoringVO();
						vo2 = new UnstoringDetailVO();
						
						// 걍 detailVO 에 다 박아도 되겠다. 귀찮으니까
					    // (정정) 동일한 주문번호에 대해 1번만 insert 해야 하는 '출고 테이블'은 vo1에
						//                       여러번 insert 해야 하는 '출고 디테일 테이블'은 vo2에
						vo1.setUnstoring_code(unstoring_code);
						vo1.setCustomer_name(customer_name);
						vo1.setCustomer_address(customer_address);
						vo1.setOrder_register(DateUtil.convertToDate(order_register)); 
						
						vo2.setProduct_code((int)product_code);   
						vo2.setUnstoring_quantity((int)unstoring_quantity); 
						list.add(vo2);
						
						
						// 이 부분을 왜 주석처리 했냐면.. => 이건 cell의 데이터 타입을 확인하고 그에 따라 value값을 저장해주는 작업인데(switch-case)니까
						// 근데 우린 서식 정해주고, 그에 따라 입력하는 거니까 굳이 이 작업이 필요 없는 거지.
						// 그냥 단순히 정해진 타입에 갖다 박으면 되는 거임!!
						/* 
						String value = "";
						if (cell == null) { // 빈 셀 체크
							continue;
						} else {
							// 타입 별로 내용을 읽는다
							switch (cell.getCellType()) {
							case XSSFCell.CELL_TYPE_FORMULA:
								value = cell.getCellFormula();
								break;
							case XSSFCell.CELL_TYPE_NUMERIC:
								value = cell.getNumericCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_STRING:
								value = cell.getStringCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_BLANK:
								value = cell.getBooleanCellValue() + "";
								break;
							case XSSFCell.CELL_TYPE_ERROR:
								value = cell.getErrorCellValue() + "";
								break;
							}
						}*/
						
						//System.out.println(rowNo + "번 행 : " + cellIndex + "번 열 값은: " + value);
					//}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// ★ 1개인 vo1은 VO로, 여러개인 vo2는 List로
		int result = service.ordersInsert(list, vo1, magID);
		
		return result;
	}
	
	
	//
	public static String createUnstroingCode(int company_id, String magID) {
		String unstoring_code = null;
		char j;
//		List<String> strList = new ArrayList<>();
		
		////////////////////////////주문번호 만들기 ////////////////////////////
		// 등록일을 위한 현재 날짜 가져오기
		LocalDateTime now = LocalDateTime.now();
		Timestamp timestamp = Timestamp.valueOf(now);
		//createBalju.setBalju_date(timestamp); //현재등록날짜

		// 현재 작업 중인 코드 (발주(B), 입고(I), 출고(O))
		String code = "O";

		// 셀렉한 기업 코드 - ★ 추후 세션으로 가져올 예정
		String selected_company = Integer.toString(company_id);
		System.out.println("셀렉한 기업 코드 : " + selected_company);

		// 날짜->시리얼 넘버 만들기
		String formatedNow = now.format(DateTimeFormatter.ofPattern("yyMMddkmmss"));

		// 출고(=주문) 코드 생성
//		for(int i=0; i<rows-1; i++) { // ★ 'rows-1' 이유 = 사용자가 입력한 엑셀의 row 수인데, 맨 위에 칼럼(성함, 주소 등)도 포함되므로 읽을 건 2개여도 실제 row 수는 3개임.
			unstoring_code = code + selected_company + formatedNow;
//			strList.add(unstoring_code);
//		}
		//////////////////////////// 주문번호 만들기 끝 ////////////////////////////
		
		return unstoring_code;
	}

}
