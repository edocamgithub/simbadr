#!/bin/bash
# Created 9 nov 2021 0855
# Write by Eduardo M. Araujo 

db_DIR=$(simbadr-read-conf.sh -g)
lib_DIR=$(simbadr-read-conf.sh -l)
etc_DIR=$(simbadr-read-conf.sh -s)
group_enable_list="simbadr"


  ip_INPUT=$1
  db_FROM=$2 
  db_TO=$3


function input_TEST () {
 	
	if [ -z $ip_INPUT ]
 		then
			echo "Enter with IP!"
			exit 1	
			else 
				uniq_TEST             
            fi 	
 	
 	if [ -z $db_FROM ]
 		then
			echo "Source database - (out)"
			exit 1	
				else 	
					echo $etc_DIR$group_enable_list | grep -w group_enable | grep -w $db_FROM
	 
 		 			if test $? -eq 0
		 				then 
		 					echo "non-existent group"
		 					exit 0
		 				fi
				fi
			
 	if [ -z $db_TO ]
 		then		
 			echo "Target database - (in)"
			exit 1			
				else 			
 					echo $etc_DIR$group_enable_list | grep -w group_enable | grep -w $db_TO

 					if test $? -eq 0
		 				then 
		 					echo "non-existent group"
		 					exit 0
		 				fi
 				fi
}

function uniq_TEST () {
   
   line=$($lib_DIR"rwinfodb.sh" --locate $ip_INPUT | wc -l) 
    
   if  test $line -eq 0 
		then 
			echo "Null"
			#exit 1
	   fi

	if  test $line -eq 1 
		then 
			echo "OK"
		   #exit 0
	   fi

	if  test $line -gt 1
		then 
			echo "Check the database!"
	   	exit 1
	   fi
}


function update_db () {
	db_simbadr=$(simbadr-read-conf.sh -g)
	$lib_DIR"rwinfodb.sh" --delete $ip_INPUT --filename $db_simbadr"$db_FROM" 
	$lib_DIR"rwinfodb.sh" --add $ip_INPUT --filename $db_simbadr"$db_TO"
echo "update"
}



input_TEST

uniq_TEST
update_db








