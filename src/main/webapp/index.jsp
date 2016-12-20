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
	Map<String,String[]> mp1 = new HashMap<String,String[]>();
	Map<String,String[]> mp2 = new HashMap<String,String[]>();
	StringBuilder res = new StringBuilder();
	String lines = "";
	boolean dxflag = true; 
	while((lines=br.readLine())!=null){
		if(lines.contains("二、多选题")){
			dxflag = false;
			res.delete(0, res.length());
			lines = "";
		}
		res.append(lines+"\n");
		if(lines.equals("")){
			if(res.toString().contains("A.")){
				String[] taa = res.toString().split("A\\.");
				String[] gas = ("A."+taa[1]).split("\n");
				String key = taa[0].substring(taa[0].indexOf("."), taa[0].length()-1);
				key=key.replace("<", "&lt;").replace(">", "&gt;").replace(" ", "&nbsp;").replace("\n", "</br>");
				if(dxflag) mp1.put(key, gas);
				else mp2.put(key, gas);
			}
			res.delete(0, res.length());
		}
	}
	br.close();
	out.println("<title>Java三级考试选择题</title><body leftmargin='40'><div>一、单选题：</div>");
	int i = 1;
	Iterator<Map.Entry<String,String[]>> entries1 = mp1.entrySet().iterator(); 
	out.println("<form action='answer' method='post' target='_blank'>");
	while (entries1.hasNext()) {  		  
		Map.Entry<String,String[]> entry = entries1.next();  
	    String[] gres = entry.getValue();
	    out.println("</br><div><input type='hidden' name='ask"+i+"' value='"+i+entry.getKey()+"'/>"+i+entry.getKey()+"</div>");
	    for(int j=0;j<gres.length;j++){
	    	if(j<gres.length-1){
					out.print("<input type=\"radio\" name ='ansr" + i + "' value='"+(char)(65+j)+"'/>");
					out.println(gres[j].replace("<", "&lt;").replace(">", "&gt;")+"</br>");
	    	}else{
	    		out.println("<input type='hidden' name='right"+i+"' value='"+gres[j]+"'/>");
	    	}
	    }
	    i++;
	}
	
	out.println("</br><div>二、多选题：</div>");
	i = 1;
	Iterator<Map.Entry<String,String[]>> entries2 = mp2.entrySet().iterator();
	while (entries2.hasNext()) {  		  
		Map.Entry<String,String[]> entry = entries2.next();  
	    String[] gres = entry.getValue();
	    out.println("</br><div><input type='hidden' name='ask2"+i+"' value='"+i+entry.getKey()+"'/>"+i+entry.getKey()+"</div>");
	    for(int j=0;j<gres.length;j++){
	    	if(j<gres.length-1){
					out.print("<input type=\"checkbox\" name ='ansrm" + i + "' value='"+(char)(65+j)+"'/>");
					out.println(gres[j].replace("<", "&lt;").replace(">", "&gt;")+"</br>");
	    	}else{
	    		out.println("<input type='hidden' name='rightm"+i+"' value='"+gres[j]+"'/>");
	    	}
	    }
	    i++;
	}
	out.println("</br><input type='submit' value='交卷'></form></body>");
%>
