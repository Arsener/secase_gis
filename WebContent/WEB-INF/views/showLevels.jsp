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
    
    <title>特种设备案例事故等级展示</title>
  </head>
  <body>
	<div id="container" tabindex="0">
   	    
    </div> 
    <div id="main" style="width: 600px;height:400px;"></div>
    <div id="main_2" style="width: 600px;height:400px;"></div>
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.0&key=3b1abac71d9c69f21b69c476744f7d98"></script>
    
    <script type="text/javascript">
		var level_names = new Array();
    	var level_counts = new Array();
    	
        var map = new AMap.Map('container',{
            resizeEnable: true,
            zoom: 4,
            center: [105.293516,38.09107]
       });
        
        <%
        for (int index = 0; index < ((List<Level>)session.getAttribute("levels")).size(); index+=1)
        {
        %>
        	level_names[<%=index%>] = "<%=((List<Level>)session.getAttribute("levels")).get(index).getCase_level() %>";
        	level_counts[<%=index%>] = "<%=((List<Level>)session.getAttribute("levels")).get(index).getCounts() %>";
        <%
        }

        %>
        
    var myCharts1 = echarts.init(document.getElementById('main'));

    myCharts1.on("click", eConsole);  
    var option1 = {
            backgroundColor: 'white',

            title: {
                text: '事故等级分布',
                left: 'center',
                top: 20,
                textStyle: {
                    color: '#000'
                }
            },
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {d}%"
            },
            toolbox: {
                show : true,
                feature : {
                    mark : {show: true},
                    dataView : {show: true, readOnly: false},
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            

            visualMap: {
                show: false,
                min: 0,
                max: 30,
                inRange: {
                    colorLightness: [0, 1]
                }
            },
            series : [
                {
                    name:'事故等级分布',
                    type:'pie',
                    clockwise:'true',
                    startAngle:'0',
                    radius : '60%',
                    center: ['50%', '50%'],
                    data:[
                        {
                            value:level_counts[1],
                            name:'极其重大事故',
                            itemStyle:{
                                normal:{
                                    color:'rgb(255,192,0)',
                                    shadowBlur:'90',
                                    shadowColor:'rgba(0,0,0,0.8)',
                                    shadowOffsetY:'30'
                                }
                            }
                        },
                        {
                            value:level_counts[2],
                            name:'重大事故',
                            itemStyle:{
                                normal:{
                                    color:'rgb(1,175,80)'
                                }
                            }
                        },
                        {
                            value:level_counts[0],
                            name:'一般事故',
                            itemStyle:{
                                normal:{
                                    color:'rgb(122,48,158)'
                                }
                            }
                        }

                    ],
                }
            ]
        };
           
        // 使用刚指定的配置项和数据显示图表。
        myCharts1.setOption(option1);

        var myChart_2 = echarts.init(document.getElementById('main_2'));
        myChart_2.on("click", eConsole);  
			     //加载图表
			 var option2 = {
			    tooltip: {
			        show:true,
			        trigger: 'item',
			        formatter: function(params, ticket, callback){
			        	 var num = '';
			           var str = '<div style="text-align: center" id="toolTipBox"><p style="font-size:12px;margin:0px;color:green;">案例等级展示</p><p style="font-size:20px;margin:0px">'+ num + '</p></div>'
			            return str
			        },
			         position: function (point, params, dom, rect, size) {
			         		//size参数可以拿到提示框的outerWidth和outerheight，dom参数可以拿到提示框div节点。
			            //console.log(dom)可以看到，提示框是用position定位
			             var marginW = Math.ceil(size.contentSize[0]/2);
			             var marginH = Math.ceil(size.contentSize[1]/2);
			             dom.style.marginLeft='-' + marginW + 'px';
			             dom.style.marginTop='-' + marginH + 'px';
			      			 return ['50%', '50%'];
			  			},
			        alwaysShowContent:true,
			        backgroundColor:'#f3f5f6',	//设置提示框的背景色
			        textStyle:{
			        	color:'#333'
			        }
			    },
			  legend: {
			          data : ['一般事故','重大事故','极其重大事故']
			      },
			    
			    series: [
			        {
			            name:'事故等级展示',
			            type:'pie',
			            radius: ['50%', '70%'],
			           // avoidLabelOverlap: false,
			            //hoverAnimation:false,	//关闭 hover 在扇区上的放大动画效果。
			            cursor:'default', //鼠标悬浮时在图形元素上时鼠标的样式是什么。同 CSS 的 cursor。
			          //  silent:true,	//图形是否不响应和触发鼠标事件，默认为 false，即响应和触发鼠标事件。
			            label: {
			                normal: {
			                   show: false,
			                    position: 'default'
			                },
			                emphasis: {
			                   show: false
			                }
			            },
			            labelLine: {
			                normal: {
			                    show: false
			                }
			            },
			            data:[
							 {
			                      value:level_counts[1],
			                      name:'极其重大事故',
			                      itemStyle:{
			                          normal:{
			                              color:'rgb(255,192,0)',
			                              shadowBlur:'90',
			                              shadowColor:'rgba(0,0,0,0.8)',
			                              shadowOffsetY:'30'
			                          }
			                      }
			                  },
			                  {
			                      value:level_counts[2],
			                      name:'重大事故',
			                      itemStyle:{
			                          normal:{
			                              color:'rgb(1,175,80)'
			                          }
			                      }
			                  },
			                  {
			                      value:level_counts[0],
			                      name:'一般事故',
			                      itemStyle:{
			                          normal:{
			                              color:'rgb(122,48,158)'
			                          }
			                      }
			                  }
			            ]
			        }
			    ]
			};
           myChart_2.setOption(option2);       
           myChart_2.dispatchAction({
        	   type: 'showTip',
        	   seriesIndex: 0,
        	   dataIndex: 0
        	 });

           
           function eConsole(param) { 
               if (typeof param.seriesIndex == 'undefined') {    
                   return;    
               }    
               if (param.type == 'click') {    
               	var temp = document.createElement("form");
                   temp.action = "showLevels";
                   temp.method = "post";
                   temp.style.display = "none";

                   var opt = document.createElement("textarea");
                   opt.name = "case_level";
                   opt.value = param.name;
                   temp.appendChild(opt);

                   document.body.appendChild(temp);
                   temp.submit();  
               }
           } 
    </script>
    
    
    <form action="showCounts" method="post">
        <input type="submit" value="按省份展示数量"/>
    </form>
    <form action="showTypes" method="post">
        <input type="submit" value="按类别展示数量"/>
    </form>
     <form action="showLevels" method="post">
        <input type="submit" value="按事故等级展示"/>
    </form>
    
    <form action="showLevels" method="post">
    	<p>选择事故等级：
    		<select name="case_level">
    			<option value="一般事故">一般事故</option>
    			<option value="重大事故">重大事故</option>
    			<option value="极其重大事故">极其重大事故</option>
    	    </select>
    	</p>
		<input type="submit" value="展示此等级全部案例">
    </form>
    
    <h3>当前展示案例事故等级为：<%=(String)session.getAttribute("case_level") %></h3>
    
    <c:forEach items="${news }" var="news_item" varStatus="vs">
		<a href="newsDetail?case_id=${news_item.getCase_id() }">${news_item.getCase_name() }</a><br />
	</c:forEach>
    
  </body>
</html>