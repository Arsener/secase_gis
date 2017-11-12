<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.mucfc.model.*" %>
<%@ page import="java.util.*" %>
<!doctype html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    
    <script type="text/javascript" src="http://echarts.baidu.com/dist/echarts.min.js"></script>
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
    
    <title>特种设备案例类别数量展示</title>
  </head>
  <body>
	<div id="container" tabindex="0">
   	    
    </div> 
    <div id="main" style="width: 600px;height:400px;"></div>
    
   
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.0&key=3b1abac71d9c69f21b69c476744f7d98"></script>
    <script type="text/javascript">
    	var type_names = new Array();
    	var type_counts = new Array();
    	
        var map = new AMap.Map('container',{
            resizeEnable: true,
            zoom: 4,
            center: [105.293516,38.09107]
        });
        <%
        for (int index = 0; index < ((List<Type>)session.getAttribute("types")).size(); index+=1)
        {
        %>
	        type_names[<%=index%>] = "<%=((List<Type>)session.getAttribute("types")).get(index).getCase_equipment() %>";
	        type_counts[<%=index%>] = "<%=((List<Type>)session.getAttribute("types")).get(index).getCounts() %>";
        <%
        }
        %>
        
     // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
		// 显示标题，图例和空的坐标轴
		var seriesLabel = {
		    normal: {
		        show: true,
		        textBorderColor: '#333',
		    }
		}

		option = {
		    title: {
		        text: '不同类别特种设备案例数量'
		    },
		    tooltip: {
		        trigger: 'axis',
		        axisPointer: {
		            type: 'shadow'
		        }
		    },
		    legend: {
		        data: ['案例数量']
		    },
		    grid: {
		        left: 100
		    },
		    xAxis: {
		        type: 'value',
		        name: '数量',
		        axisLabel: {
		            formatter: '{value}'
		        }
		    },
		    yAxis: {
		        type: 'category',
		        inverse: true,
		        data: type_names
		        
		    },
		    series: [
		        {
		            name: '案例数量',
		            type: 'bar',
		            label: seriesLabel,
		            data: type_counts
		        }
		    ]
		};
		
		
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
    
    
    <form action="showCounts" method="post">
        <input type="submit" value="按省份展示数量"/>
    </form>
    <form action="showTypes" method="post">
        <input type="submit" value="按类别展示数量"/>
    </form>
    
    <form action="showTypes" method="post">
    	<p>选择设备种类：
    		<select name="case_type">
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
		<input type="submit" value="展示此类别全部案例">
    </form>
    
    <h3>当前展示案例设备类别为：<%=(String)session.getAttribute("case_type") %></h3>
    
    <c:forEach items="${news }" var="news_item" varStatus="vs">
		<a href="newsDetail?case_id=${news_item.getCase_id() }">${news_item.getCase_name() }</a><br />
	</c:forEach>
    
  </body>
</html>