<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>

<% 
	String path=application.getRealPath(request.getRequestURI());
	File f = new File(path+"/timu.txt");
	FileReader fr = new FileReader(f);
	BufferedReader br = new BufferedReader(fr);
	Map<String,String[]> mp = new HashMap<String,String[]>();
	StringBuilder res = new StringBuilder();
	String lines = "";
	while((lines=br.readLine())!=null){
		res.append(lines+"\n");
		if(lines.equals("")){
			if(res.toString().contains("A.")){
				String[] taa = res.toString().split("A\\.");
				String[] gas = ("A."+taa[1]).split("\n");
				String key = taa[0].substring(taa[0].indexOf("."), taa[0].length()-1);
				key=key.replace("<", "&lt;").replace(">", "&gt;").replace(" ", "&nbsp;").replace("\n", "</br>");
				mp.put(key, gas);
			}
			res.delete(0, res.length());
		}
	}
	br.close();
	out.println("<div>一、单选题：</div>");
	int i = 1;
	Iterator<Map.Entry<String,String[]>> entries = mp.entrySet().iterator(); 
	out.println("<form action='answer' method='post' target='_blank'>");
	while (entries.hasNext()) {  		  
		Map.Entry<String,String[]> entry = entries.next();  
	    String[] gres = entry.getValue();
	    out.println("</br><div name='ask"+i+"'>"+i+entry.getKey()+"</div>");
	    for(int j=0;j<gres.length;j++){
	    	if(j<gres.length-1){
					out.print("<input type=\"radio\" name ='" + i + "' value='"+j+"'/>");
					out.println(gres[j].replace("<", "&lt;").replace(">", "&gt;")+"</br>");
	    	}else{
	    		out.println("<input type='hidden' name='right"+i+"' value='"+gres[j]+"'/>");
	    	}
	    }
	    i++;
	}
	out.println("</br><input type='submit' value='交卷'></form>");
%>
