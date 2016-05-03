<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
</head>
<body>
<script language="php">
include_once 'config_auth.php';
include_once 'saetv2.ex.class.php';

if(!empty($_REQUEST["signed_request"])){
	$o = new SaeTOAuthV2( WB_AKEY , WB_SKEY );
	$data=$o->parseSignedRequest($_REQUEST["signed_request"]);
	if($data=='-2') {
		die('error');
	}
	else {
		$_SESSION['oauth2']=$data;
	}
}

if (empty($_SESSION['oauth2']["user_id"])) {
	include "auth.php";
	exit;
}
else {
	include_once("home.html");
}
</script>
</body>
</html>