#Jacob Everett
#CSCE3600.001
#02/20/2020

#! /bin/bash

#function to handle ^C
#if user enters y or Y after SIGINT is received, program exits. Any other input resumes program.
sigint() 
{
	printf " (SIGINT) Received.\nTerminate Program? (Y\N)"
	read answer
	if [ ${answer^^} = 'Y' ]
	then
		echo Terminating program...
		exit 0
	else
		return
	fi
}

trap sigint 2

#accent=$(tput setaf 5)
#normal=$(tput sgr0)
#${accent}
#t${normal}
while true
do	
	#print date and column headings
	printf "`date`\n%-17s%13s\n" "User ID" "Count"

	#if user entered args,
	if [ $# -gt 0 ]
	then
		sum=0
		
		#for each user (argument) set count equal to the line count the output from 'ps -u <user> -o user='
		#add count to sum to keep running total of all processes
		#print username and total number of processes
		for i in $@
		do
			count=`ps -u $i -o user= | wc -l`
			let sum=$count+$sum;
			printf "%-17s%13d\n" "$i" "$count"
		done
	
		echo $# USERS, TOTAL PROCESSES $sum
	else
		#get total number of users and processes and store them
		pTotal=`ps -eo user= | wc -l`
		uTotal=`ps -eo user= | sort | uniq | wc -l`
		sum=0

		#store all unique usernames in an array
		arr=("`ps -eo user= | sort | uniq`")
		for i in $arr
		do
			#get the total number of processes for each user in $arr and store in count
			#output username and count
			count=`ps -u $i -o user= | wc -l`
	       		printf "%-17s%13d\n" "$i" "$count"
		done

		 printf "%d USERS, TOTAL PROCESSES %d\n\n" "$uTotal" "$pTotal"
	fi
	sleep 5
done
