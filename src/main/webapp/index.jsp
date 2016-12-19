<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>

<% 
	File f = new File("/timu.txt");
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
	out.println("<form action='hello' method='post'>");
	while (entries.hasNext()) {  		  
		Map.Entry<String,String[]> entry = entries.next();  
	    String[] gres = entry.getValue();
	    out.println("</br><div>"+i+entry.getKey()+"</div>");
	    for(int j=0;j<gres.length;j++){
	    	if(j<gres.length-1){
				out.print("<input type=\"radio\" name ='" + i + "' value='"+j+"'/>");
				out.print(gres[j].replace("<", "&lt;").replace(">", "&gt;")+"</br>");
	    	}
	    }
	    i++;
	}
	out.println("</br><input type='submit' value='交卷'></form>");
%>
