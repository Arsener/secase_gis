<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ page import="com.mucfc.model.*" %>
<%@ page import="com.mucfc.dao.*"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!doctype html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <style type="text/css">
      body,html{
        height: 100%;
        margin: 0px;
      }
      #container {
      	width:700px; 
      	height: 500px; 
      	margin: 0px auto;
      }  
    </style>
    
    <title>特种设备案例展示</title>
  </head>
  
  <body>
    <h1 align="center"> <font color="red"> 特种设备案例展示 </font> </h1>
    
    <div id="container" tabindex="0">
   	    
    </div> 
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.0&key=3b1abac71d9c69f21b69c476744f7d98"></script>
    <script type="text/javascript">
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

	    var case_place = '<%=(String)session.getAttribute("case_place") %>';
	    
    	if (case_place != "全部"){
    		map.setZoomAndCenter(8, [<%=((Location)session.getAttribute("location")).getPlace_lon() %>, <%=((Location)session.getAttribute("location")).getPlace_lat() %>]);
            showProvince(case_place);
    	}
    </script>
    </br>
    
    <div align="center"> 
	<table>
	<tr>
	<td>
	    <form action="showCounts" method="post">
            <input type="submit" value="按省份展示数量"/>
        </form>
    </td>
    <td>
        <form action="showTypes" method="post">
            <input type="submit" value="按类别展示数量"/>
        </form>
    </td>
    <td>
	    <form action="showLevels" method="post">
	        <input type="submit" value="按事故等级展示"/>
	    </form>	
	</td>
    </tr>
	</table>
	
	</br>
	
	<!--底部-->
	<p align="center"> GIS最垃圾小组 </p>
	
	<!-- 音乐播放器 -->
	<div align="center">
	    <embed src="C:\Users\arsener\workspace_GIS\secase_gis\WebContent\WEB-INF\views\Astral Requiem.mp3" width=300 height=40 tyep=audio/mpeg 
	    hidden="false" autostart="true" loop="true">
	    </embed>
	</div>
    
    <form action="" method="post">
    	<p>选择省份：
    		<select name="case_place">
    			<option value="全部">全部</option>
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
    	<p>选择设备种类：
    		<select name="case_type">
    			<option value="全部">全部</option>
    			<option value="大型游乐设施">大型游乐设施</option>
    			<option value="锅炉">锅炉</option>
    			<option value="电梯">电梯</option>
    			<option value="压力管道">压力管道</option>
    			<option value="起重机械">起重机械</option>
    			<option value="客运索道">客运索道</option>
    			<option value="场（厂）内专用机动车辆">场（厂）内专用机动车辆</option>
    			<option value="压力容器">压力容器</option>
    	    </select>
    	</p>
		<input type="submit" value="查询案例">
    </form>
    
	<h3>查询结果：</h3>
	<h4>地区：<%=(String)session.getAttribute("case_place") %>&nbsp;&nbsp;&nbsp;&nbsp;类别：<%=(String)session.getAttribute("case_type") %></h4>
   
    <c:forEach items="${news }" var="news_item" varStatus="vs">
      <ul>
        <li>
		  <a href="newsDetail?case_id=${news_item.getCase_id() }">${news_item.getCase_name() }</a><br />
	    </li>
	  </ul>
	</c:forEach>
  </body>
</html>











