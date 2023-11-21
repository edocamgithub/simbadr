<html>
<head>
</head>
<body>
<?php
/*
File: offline.php         Built 202311202208
Version: 0.0.1      

Function: Reports for information offline device list.

Required: 

Note: (simbadr/var/www/html/simbadr/php/)

Written by Eduardo M. Araujo. - versão 0.0.1
Copyright (c)2019-2023 Eduardo M. Araujo..
*/


$texto = $_GET["host"];
$img_os= $_GET["img"];


echo "<h1> Offline devices  </h1> ";


echo "<img src=" ; echo '"'; echo "../images/devices/warning.png" ; echo '"'; echo "/>";
echo "<br>";
echo "
<p>Group of Devices </p>
<p>List 01 </p>

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
