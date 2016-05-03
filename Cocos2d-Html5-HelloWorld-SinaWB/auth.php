<html>
<head>
</head>
<script src="http://tjs.sjs.sinajs.cn/t35/apps/opent/js/frames/client.js" language="JavaScript"></script>
<script> 
function authLoad(){
 App.AuthDialog.show({
 client_id : 'xxx',
 redirect_uri : 'http://apps.weibo.com/xxx',
 height: 120
 });
}
</script>
<body onload="authLoad();">
</body>
</html>