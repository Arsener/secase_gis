<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.mucfc.model.*" %>
<%@ page import="com.mucfc.dao.*"%>
<%@ page import="java.util.*" %>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    <style type="text/css">
      body,html{
        height: 100%;
        margin: 0px;
      }
      #container {
      	width:700px; 
      	height: 500px; 
      }  
    </style>
    
    <title>特种设备案例</title>
  </head>
  <body>
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.0&key=3b1abac71d9c69f21b69c476744f7d98"></script>  
  
    <center>
    	<h1><%=((Detail)session.getAttribute("detail")).getCase_name() %></h1>
    	<strong>发生地点：</strong><%=((Detail)session.getAttribute("detail")).getCase_place() %>&nbsp;&nbsp;&nbsp;&nbsp;<strong>案例类别：</strong><%=((Detail)session.getAttribute("detail")).getCase_equipment() %>
    	
		<div id="container" tabindex="0">
	   	    
	    </div> 
	    
	    <script type="text/javascript">
	        var map = new AMap.Map('container',{
	            resizeEnable: true,
	            zoom: 4,
	            center: [105.293516,38.09107]
	        });
	        
	        map.setZoomAndCenter(8, [<%=((Detail)session.getAttribute("detail")).getPlace_lon() %>,<%=((Detail)session.getAttribute("detail")).getPlace_lat() %>]);
	        
        	AMap.service('AMap.DistrictSearch', function() {
                var opts = {
                    subdistrict: 1,   //返回下一级行政区
                    extensions: 'all',  //返回行政区边界坐标组等具体信息
                    level: 'province'  //查询行政级别为 市
                };
                //实例化DistrictSearch
                district = new AMap.DistrictSearch(opts);
                district.setLevel('district');
                //行政区查询
                district.search(<%=((Detail)session.getAttribute("detail")).getCase_place() %>, function(status, result) {
                    var bounds = result.districtList[0].boundaries;
                    var polygons = [];
                    if (bounds) {
                        for (var i = 0, l = bounds.length; i < l; i++) {
                            //生成行政区划polygon
                            var polygon = new AMap.Polygon({
                                map: map,
                                strokeWeight: 1,
                                path: bounds[i],
                                fillOpacity: 0.7,
                                fillColor: '#CCF3FF',
                                strokeColor: '#CC66CC'
                            });
                            polygons.push(polygon);
                        }
                        map.setFitView();//地图自适应
                    }
                });
            });
	        
	    </script>
    
    </center>
    <p>
    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=((Detail)session.getAttribute("detail")).getCase_describe() %>
    </p>
  </body>
</html>