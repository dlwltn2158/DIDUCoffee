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

	//doGet,doPost�޼ҵ� �������̵�
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("����");
		//�ѱ�ó��
		request.setCharacterEncoding("UTF-8");
		//��û�� (�Է��� ID���)
		String id = request.getParameter("id");
		System.out.println(id);
		
		//�Է��� ID�� DB�� ����� ID�� ���ϱ� ����...MemberDAO��ü ����
		MemberDAO memberDAO = new MemberDAO();
		
		//ID�ߺ� ���θ� ��ȯ �޾� ����
		int check = memberDAO.idCheck(id);
		System.out.println(check);
		
		//Ŭ���̾�Ʈ�� ���������� ������ ������ Ÿ�� ����
		response.setContentType("text/html; charset=utf-8");
		//PrintWriter��ü ���
		PrintWriter out = response.getWriter();
		//ID�ߺ� ���� ����� ajax3.html�������� �޼����� ������.
		if(check == 1){
			out.print("not_usable");
		}else{
			out.print("usable");
		}
		
	}
		
}







