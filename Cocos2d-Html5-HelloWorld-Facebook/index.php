<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
</head>
<body>
<script language="php">
require 'fb-php-sdk/facebook.php';
$app_id = 'xxx';
$app_secret = 'xxx';
$app_namespace = 'xxx';
$app_url = 'https://apps.facebook.com/' . $app_namespace . '/';
$scope = 'email,publish_actions';

// Init the Facebook SDK
$facebook = new Facebook(array(
	 'appId'  => $app_id,
	 'secret' => $app_secret,
));

// Get the current user
$user = $facebook->getUser();
// If the user has not installed the app, redirect them to the Login Dialog
if (!$user) {
	$loginUrl = $facebook->getLoginUrl(array(
	'scope' => $scope,
	'redirect_uri' => $app_url,
	));
	print('<script> top.location.href=\'' . $loginUrl . '\'</script>');
}
else {
	include_once("home.html");
}
</script>
</body>
</html>
