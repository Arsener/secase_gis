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
      }  
    </style>
    
    <title>特种设备案例展示</title>
  </head>
  
  <body>
    <div id="container" tabindex="0">
   	    
    </div> 
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.0&key=3b1abac71d9c69f21b69c476744f7d98"></script>
    <script type="text/javascript">
        var map = new AMap.Map('container',{
            resizeEnable: true,
            zoom: 4,
            center: [105.293516,38.09107]
        });
    </script>
    <form action="showCounts" method="post">
        <input type="submit" value="按省份展示数量"/>
    </form>
    <form action="showTypes" method="post">
        <input type="submit" value="按类别展示数量"/>
    </form>
  </body>
</html>











