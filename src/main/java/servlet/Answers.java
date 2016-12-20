package servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
        name = "Answers", 
        urlPatterns = {"/answer"}
    )
public class Answers extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	req.setCharacterEncoding("utf-8");
    	resp.setContentType("text/html; charset=utf-8");
    	PrintWriter pw = resp.getWriter();
    	boolean flag = true;
    	pw.write("<title>结果页</title><body leftmargin='20'>");
		for(int i=1;i<50;i++){
			String answer =(String)req.getParameter("ansr"+i);
			String right = (String)req.getParameter("right"+i);
			if(answer!=null){
	    		if(!answer.equals(right)){
	    			flag = false;
	    			pw.write("<div>第"+i+"题："+answer+" 答错!</div>");
	    			pw.write("<div>正确答案："+right+"</div></br>");
	    		}
			}else{
				flag = false;
				pw.write("<div>第"+i+"题未作答! </div>");
    			pw.write("<div>正确答案："+right+"</div></br>");
			}
    	}
		for(int j=1;j<19;j++){
			String[] answers = req.getParameterValues("ansrm"+j);
			String rightm = (String)req.getParameter("rightm"+j);
			String askm = null;
			if(answers!=null){
				StringBuilder manswer = new StringBuilder();
				for(int k=0; k<answers.length;k++){
					manswer.append(answers[k]);
				}
				if(!manswer.toString().equals(rightm)){
					flag = false;
	    			pw.write("<div>第"+j+"题："+manswer.toString()+" 答错!</div>");
	    			pw.write("<div>正确答案："+rightm+"</div></br>");
				}
			}else {
					flag = false;
					pw.write("<div>第"+j+"题未作答! </div>");
	    		pw.write("<div>正确答案："+rightm+"</div></br>");
			}
		}
	    if(flag) pw.write("恭喜您全部答对了！");
	    pw.write("</body>");
	    pw.flush();
	    pw.close();
    }
}