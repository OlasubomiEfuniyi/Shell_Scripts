
# This is a library of functions to assist with greetings

time_of_day_greeting() {
	hour=`date +%k`

	if [ "$hour" -ge "18" ]; then
		echo "Good evening"
	elif ["$hour" -ge "12" ]; then
		echo "Good afternoon"
	else 
		echo "Good morning"
	fi

}
