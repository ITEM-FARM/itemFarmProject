package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vo.CompanyVO;
import vo.ManagerVO;

/**
 * Servlet Filter implementation class LoginCheckFilter
 */
@WebFilter("*.do")
public class LoginCheckFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public LoginCheckFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse rep = (HttpServletResponse) response;
		
		if(req.getServletPath().equals("/auth/loginCheck.do")) {
			
		}else {
			HttpSession session = req.getSession();
			
			//둘다 null일 경우
			Object manager = session.getAttribute("managerUser");
			Object company = session.getAttribute("companyUser");
			
			//System.out.println("companyUser" + company);
			//System.out.println("managerUser" + manager);
			
			if(manager == null && company == null) {
				rep.sendRedirect(req.getContextPath() + "/auth/loginCheck.do");
				return;
			}
		}
		
		//System.out.println("필터 돌아가는 중");
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}