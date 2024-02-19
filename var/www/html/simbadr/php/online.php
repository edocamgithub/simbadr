<html>
<head>
</head>
<body>
<?php
/*
File: devide.php         Built 201902061252
Version: 0.0.1        Last update 202302091300

Function: Reports for information device list.

Required: 

Note: (simbadr/var/www/html/simbadr/php/)

Written by Eduardo M. Araujo. - versão 0.0.1
Copyright (c)2019-2023 Eduardo M. Araujo..
*/


$texto = $_GET["host"];
$img_os= $_GET["img"];


echo "<h1> Online devices  </h1> ";


echo "<img src=" ; echo '"'; echo "../images/devices/device.png" ; echo '"'; echo "/>";
echo "<br>";
echo "
<p>Setup time on Device: </p>
<p>Logon user now:</p>
<p>Dept:</p>
<p>Contact:</p>
<p>Operation System:</p>
<p>Device:</p>
";
echo "Device ";

echo $texto;
echo $img_os;
echo "
<p>
";
echo "Access WEB-Conf: ";
echo "<a target=_blank";
echo " href=";
echo "http://$texto/>";
echo "$texto<p>";
echo "<a>";

?>

</body>
</html>
