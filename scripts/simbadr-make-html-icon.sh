#!/bin/bash
#Writer by Eduardo M. Araujo (c)2024

  TEMP_LOCAL_SIMBADR="/tmp/simbadr"

# Verifica a existenica do DIR=tmp/simbadr/
if test -d $TEMP_LOCAL_SIMBADR
        then
                echo "/tmp/simbadr not found!" >/dev/null
        else
                mkdir $TEMP_LOCAL_SIMBADR
        fi

baseDIR=$(simbadr-read-conf.sh -l)
destinationDIR=$(simbadr-read-conf.sh -d)
#New Ubuntu 22.0 - recommend  to use mktemp
#tmp_file=$(tempfile -d /tmp)
tmp_file=$(mktemp "$TEMP_LOCAL_SIMBADR/"imglist.XXX)
new_name_file="imglist.html"

function html_head {
echo "
<!DOCTYPE html>
<html>
    <head>
         <meta charset=utf-8 />
         <title>Icons for SIMBA(DR)</title>
    </head>
<body>
<h1>Network devices graphical icons for SIMBADR </h1>
<br><br><br><br>
<table>
" > $tmp_file
}

function html_footer {

creator_file=$(date)
echo "
</table>
<br><br><br>
<h4>(C)2019-2024 Designer by Eduardo Macedo Araujo - "$creator_file"</h4>
</body>
</html>
" >> $tmp_file
}


function html_tdtr {

status_number=$i
device_name=$1

echo "<td>
   <tr>
      <td>"$device_name"</td>
      	<td>"$status_number"</td> 
      		<td><img src="$img_file" width=32 height=32 alt=></td>  
      			<td>-   filename : "$img_file"</td> 
      				<td>-   description : "$img_desc"</td>
   </tr>
</td>" >> $tmp_file

}

html_head

img_dir=$("$baseDIR"getimage.sh | grep "local" | cut -d " " -f5)

for i in 0 1 2 3 4 5; do
	#img_file=$("$baseDIR"getimage.sh --deviceHost "$i" | grep "(device/host)" | cut -d " " -f6)
	img_file=$("$baseDIR"getimage.sh --deviceHost "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --deviceHost "$i" | cut -d":" -f2 )
		html_tdtr "--deviceHost"
done

for i in 0 1 2; do
	img_file=$("$baseDIR"getimage.sh --deviceAp "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --deviceAp "$i" | cut -d":" -f2 )
		html_tdtr "--deviceAp"
done

for i in 0 1 2 3 4 5; do
	img_file=$("$baseDIR"getimage.sh --devicePrinter "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --devicePrinter "$i" | cut -d":" -f2 )
		html_tdtr "--devicePrinter"
done

for i in 0 1 2 3; do
	img_file=$("$baseDIR"getimage.sh --deviceSwitch "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --deviceSwitch "$i" | cut -d":" -f2 )
		html_tdtr "--deviceSwitch"
done


for i in 0 1 2; do
	img_file=$("$baseDIR"getimage.sh --deviceCam "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --deviceCam "$i" | cut -d":" -f2 )
		html_tdtr "--deviceCam"
done

for i in 0 1; do
	img_file=$("$baseDIR"getimage.sh --hostAlert "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --hostAlert "$i" | cut -d":" -f2 )
		html_tdtr "--hostAlert"
done

for i in 0 1 2 3; do
	img_file=$("$baseDIR"getimage.sh --hostRetired "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --hostRetired "$i" | cut -d":" -f2 )
		html_tdtr "--hostRetired"
done

for i in 0; do
	img_file=$("$baseDIR"getimage.sh --hostDeny "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --hostDeny "$i" | cut -d":" -f2 )
		html_tdtr "--hostDeny"
done

for i in 0 1 2; do
	img_file=$("$baseDIR"getimage.sh --hostBsd "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --hostBsd "$i" | cut -d":" -f2 )
		html_tdtr "--hostBsd"
done

for i in 0 1 2; do
	img_file=$("$baseDIR"getimage.sh --hostLinux "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --hostLinux "$i" | cut -d":" -f2 )
		html_tdtr "--hostLinux"
done

for i in 0 1; do
	img_file=$("$baseDIR"getimage.sh --hostWindows "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --hostWindows "$i" | cut -d":" -f2 )
		html_tdtr "--hostWindows"
done

for i in 0 1 2; do
	img_file=$("$baseDIR"getimage.sh --hostWeb "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --hostWeb "$i" | cut -d":" -f2 )
		html_tdtr "--hostWeb"
done

for i in 0 1 2 3 4; do
	img_file=$("$baseDIR"getimage.sh --hostWorkstation "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --hostWorkstation "$i" | cut -d":" -f2 )
		html_tdtr "--hostWorkstation"
done

for i in 0 1 2; do
	img_file=$("$baseDIR"getimage.sh --hostPhoneIP "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --hostPhoneIP "$i" | cut -d":" -f2 )
		html_tdtr "--hostPhoneIP"
done

for i in 0 1 2; do
	img_file=$("$baseDIR"getimage.sh --hostMac "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --hostMac "$i" | cut -d":" -f2 )
		html_tdtr "--hostMac"
done

for i in 0 1 2 3 4; do
	img_file=$("$baseDIR"getimage.sh --hostServer "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --hostServer "$i" | cut -d":" -f2 )
		html_tdtr "--hostServer"
done

for i in 0 1 2 3 4 5 6 7; do
	img_file=$("$baseDIR"getimage.sh --hostLaptop "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --hostLaptop "$i" | cut -d":" -f2 )
		html_tdtr "--hostLaptop"
done

for i in 0 1; do
	img_file=$("$baseDIR"getimage.sh --systemFlow "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --systemFlow "$i" | cut -d":" -f2 )
		html_tdtr "--systemFlow"
done

for i in 0 1 2 3; do
	img_file=$("$baseDIR"getimage.sh --hostFw "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --hostFw "$i" | cut -d":" -f2 )
		html_tdtr "--hostFw"
done

for i in 0 1 2 3 4 5 6 7 8 9; do
	img_file=$("$baseDIR"getimage.sh --deviceUPS "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --deviceUPS "$i" | cut -d":" -f2 )
		html_tdtr "--deviceUPS"
done

for i in 0 1; do
	img_file=$("$baseDIR"getimage.sh --deviceWii "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --deviceWii "$i" | cut -d":" -f2 )
		html_tdtr "--deviceWii"
done

for i in 0 1; do
	img_file=$("$baseDIR"getimage.sh --devicePs "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --devicePs "$i" | cut -d":" -f2 )
		html_tdtr "--devicePs"
done

for i in 0 1; do
	img_file=$("$baseDIR"getimage.sh --deviceXbox "$i" | cut -d":" -f3 )
	img_desc=$("$baseDIR"getimage.sh --deviceXbox "$i" | cut -d":" -f2 )
		html_tdtr "--deviceXbox"
done





html_footer

cd "$TEMP_LOCAL_SIMBADR"
t=$(basename $tmp_file)
cat $t > $destinationDIR"$new_name_file"

echo $destinationDIR"$new_name_file"
