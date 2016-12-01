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
        urlPatterns = {"/hello"}
    )
public class HelloServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        ServletOutputStream out = resp.getOutputStream();
        out.write("hello heroku".getBytes());
        out.flush();
        out.close();
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
				resp.setHeader("content-type","text/html;charset=UTF-8");
        ServletOutputStream out = resp.getOutputStream();
        String user = req.getParameter("user");
        if(user.equals("yzmctrip")){ 
	        out.write("<a href='https://www.3131hu.com/'>A</a>".getBytes());
      	}else if (user.length() == 15){
      		String code = getCode(user);
      		out.write(("CODE: "+ code).getBytes());
      	}else{
      		out.write(" ‰»Î”–ŒÛ£°".getBytes("UTF-8"));
      	}
      	out.flush();
	      out.close();
    }
    
    public String getCode(String imei){
				String s1 = imei.substring(0, 5);
				String s2 = imei.substring(5, 10);
				String s3 = imei.substring(10, 15);
				long l1 = Long.parseLong(s3)*2+2016;
				long l2 = Long.parseLong(s1)*3+12;
				long l3 = Long.parseLong(s2)*2+1;
				StringBuilder res = new StringBuilder();
				res.append(l1);
				res.append(l2);
				res.append(l3);
				return res.toString();
		}
}
