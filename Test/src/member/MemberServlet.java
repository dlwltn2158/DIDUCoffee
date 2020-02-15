package member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/didu.do")
public class MemberServlet extends HttpServlet{

	//doGet,doPost메소드 오버라이딩
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("서블릿");
		//한글처리
		request.setCharacterEncoding("UTF-8");
		//요청값 (입력한 ID얻기)
		String id = request.getParameter("id");
		System.out.println(id);
		
		//입력한 ID와 DB에 저장된 ID를 비교하기 위해...MemberDAO객체 생성
		MemberDAO memberDAO = new MemberDAO();
		
		//ID중복 여부를 반환 받아 저장
		int check = memberDAO.idCheck(id);
		System.out.println(check);
		
		//클라이언트의 웹브라우저로 응답할 데이터 타입 설정
		response.setContentType("text/html; charset=utf-8");
		//PrintWriter객체 얻기
		PrintWriter out = response.getWriter();
		//ID중복 여부 결과를 ajax3.html페이지에 메세지로 전송함.
		if(check == 1){
			out.print("not_usable");
		}else{
			out.print("usable");
		}
		
	}
		
}







