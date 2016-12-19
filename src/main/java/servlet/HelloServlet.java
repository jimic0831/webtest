	package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
        name = "MyServlet", 
        urlPatterns = {"/answer"}
    )
public class HelloServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	PrintWriter pw = resp.getWriter();
    	pw.write("<title>���ҳ</title>");
    	StringBuilder reslut = new StringBuilder();
		for(int i=1;i<50;i++){
			String answer = null;
			String right = (String)req.getParameter("right"+i);
			try{
				answer =(String)req.getParameter(i+"");}
			catch(Exception e){
				String ask = (String)req.getParameter("ask"+i);
				pw.write("<div>"+ask+"</div></br>");
    			pw.write("<div>��δѡ����ȷ�𰸣�"+right+"</div></br>");
			}
    		if(answer.equals("0")) 
    			answer = "A";
    		else if(answer.equals("1")) 
    			answer = "B";
    		else if(answer.equals("2"))
    			answer = "C";
    		else if(answer.equals("3"))
    			answer = "D";
    		if(!answer.equals(right)){
    			String ask = (String)req.getParameter("ask"+i);
    			pw.write("<div>"+ask+"</div></br>");
    			pw.write("<div>��ȷ�𰸣�"+right+"</div></br>");
    		}
    	}
    }
}
