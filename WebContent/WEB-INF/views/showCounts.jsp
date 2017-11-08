<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
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
    <script type="text/javascript" src="http://echarts.baidu.com/dist/echarts.min.js"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
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
    
    <title>特种设备案例地区数量展示</title>
  </head>
  <body>
	<div id="container" tabindex="0">
   	    
    </div> 
    <div id="main" style="width: 600px;height:400px;"></div>
    
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.0&key=3b1abac71d9c69f21b69c476744f7d98"></script>  
  
    <script type="text/javascript">
    	var place_names = new Array();
    	var place_counts = new Array();
    	
        var map = new AMap.Map('container',{
            resizeEnable: true,
            zoom: 4,
            center: [105.293516,38.09107]
        });
        
        function showProvince(name){
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
                district.search(name, function(status, result) {
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
        }
        
        function httpPost(name) {
            var temp = document.createElement("form");
            temp.action = "showCounts";
            temp.method = "post";
            temp.style.display = "none";

            var opt = document.createElement("textarea");
            opt.name = "case_place";
            opt.value = name;
            temp.appendChild(opt);

            document.body.appendChild(temp);
            temp.submit();

            return temp;
        }

        <%
        for (int index = 0; index < ((List<Place>)session.getAttribute("places")).size(); index+=1){
        %>
        	var div = document.createElement('div');
            div.className = 'circle';
        	var r = <%=((List<Place>)session.getAttribute("places")).get(index).getCase_count() %>;
            div.style.backgroundColor = 'rgb('+r*30+',100,100)';
            div.innerHTML = <%=((List<Place>)session.getAttribute("places")).get(index).getCase_count() %> || 0;
            var marker = new AMap.Marker({
            	map: map,
                content: div,
                title:'<%=((List<Place>)session.getAttribute("places")).get(index).getPlace_name() %>',
                position: [<%=((List<Place>)session.getAttribute("places")).get(index).getPlace_lon() %>,<%=((List<Place>)session.getAttribute("places")).get(index).getPlace_lat() %>],
                offset: new AMap.Pixel(0, 0),
                zIndex: <%=((List<Place>)session.getAttribute("places")).get(index).getCase_count() %>
            });

            (function(){
            	AMap.event.addListener(marker, "click", function(){
            		var name = '<%=((List<Place>)session.getAttribute("places")).get(index).getPlace_name() %>';
            		httpPost(name);
                });   
            })();
            
            place_names[<%=index%>] = "<%=((List<Place>)session.getAttribute("places")).get(index).getPlace_name() %>";
            place_counts[<%=index%>] = "<%=((List<Place>)session.getAttribute("places")).get(index).getCase_count() %>";
        <%
        }
        %>

        map.setZoomAndCenter(8, [<%=((Location)session.getAttribute("location")).getPlace_lon() %>, <%=((Location)session.getAttribute("location")).getPlace_lat() %>]);
        showProvince('<%=(String)session.getAttribute("case_place") %>');
        
     	// 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
		// 显示标题，图例和空的坐标轴
		myChart.setOption({
		    title: {
		        text: '各地区案例数量'
		    },
		    tooltip: {},
		    legend: {
		        data:['案例数量']
		    },
		    xAxis: {
		        data: place_names
		    },
		    yAxis: {},
		    series: [{
		        name: '案例数量',
		        type: 'bar',
		        data: place_counts
		    }]
		});
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
    
    <form action="showCounts" method="post">
        <input type="submit" value="按省份展示数量"/>
    </form>
    <form action="showTypes" method="post">
        <input type="submit" value="按类别展示数量"/>
    </form>
    
    <form action="showCounts" method="post">
    	<p>选择省份：
    		<select name="case_place">
    			<option value="广东省">广东省</option>
    			<option value="北京市">北京市</option>
    			<option value="山西省">山西省</option>
    			<option value="吉林省">吉林省</option>
    			<option value="江苏省">江苏省</option>
    			<option value="安徽省">安徽省</option>
    			<option value="湖南省">湖南省</option>
    			<option value="四川省">四川省</option>
    			<option value="天津市">天津市</option>
    			<option value="黑龙江省">黑龙江省</option>
    			<option value="辽宁省">辽宁省</option>
    			<option value="内蒙古自治区">内蒙古自治区</option>
    			<option value="新疆维吾尔族自治区">新疆维吾尔族自治区</option>
    			<option value="西藏自治区">西藏自治区</option>
    			<option value="青海省">青海省</option>
    			<option value="甘肃省">甘肃省</option>
    			<option value="宁夏回族自治区">宁夏回族自治区</option>
    			<option value="陕西省">陕西省</option>
    			<option value="河南省">河南省</option>
    			<option value="河北省">河北省</option>
    			<option value="山东省">山东省</option>
    			<option value="上海市">上海市</option>
    			<option value="湖北省">湖北省</option>
    			<option value="重庆市">重庆市</option>
    			<option value="云南省">云南省</option>
    			<option value="广西壮族自治区">广西壮族自治区</option>
    			<option value="海南省">海南省</option>
    			<option value="台湾省">台湾省</option>
    			<option value="福建省">福建省</option>
    			<option value="江西省">江西省</option>
    			<option value="贵州省">贵州省</option>
    			<option value="浙江省">浙江省</option>
    			<option value="香港特别行政区">香港特别行政区</option>
    			<option value="澳门特别行政区">澳门特别行政区</option>
    	    </select>
    	</p>
		<input type="submit" value="展示此类别全部案例">
    </form>
    
    <h3>当前展示案例地区为：<%=(String)session.getAttribute("case_place") %></h3>
    
    <c:forEach items="${news }" var="news_item" varStatus="vs">
		<a href="newsDetail?case_id=${news_item.getCase_id() }">${news_item.getCase_name() }</a><br />
	</c:forEach>
  </body>
</html>