#!/usr/bin/bash

# greeting user
user=$(whoami)
echo "Hello $user :)"

# getting birthday
echo "Please enter your date of birth DDMM"
read daymonth

# extracting day +1 because wont count that day when subtracted
day=$(expr 1 + $daymonth / 100 )
# echo "day $day"

# getting current month and subtracting with the users birthday month to get the months left
currMonth=$(date +%m)
month=$(expr $daymonth % 100 )
# -1 because it counts the current month as 1 when it should be 0
month=$(expr $month - $currMonth - 1)
# echo "month $month"

# converting months and days to seconds
monthseconds=$( expr $month '*' 2629746 )
dayseconds=$( expr $day '*' 86400 )

# echo $monthseconds
# echo $dayseconds
# adding the converted months and days to the current epoch seconds to get the number of seconds on the users birthday
birthday=$( expr $EPOCHSECONDS + $dayseconds + $monthseconds )
# echo $birthday

# subtract the birthday with current epoch seconds
secsleft=$( expr $birthday - $EPOCHSECONDS )

# convert seconds to days
daysleft=$( expr $secsleft '/' 86400 )

echo "Days left to your birthday: $daysleft"

# feature 1
holidays=("Happy Halloween" "Merry Christmas" "Happy St. Patrick's" "Happy Canada Day")
holidates=( 1031 1225 0317 0701 )

# currentDate=1225
counter=0
currentDate=$(date +%m%d)
# echo $currentDate

for num in "${holidates[@]}"
do
    # check if current date is any of the holidays
    if [[ $num -eq $currentDate ]]
    then
        echo "${holidays[$counter]}!"
    else
        # counter for index
        counter=$(expr $counter + 1)
    fi
    
done

# feature 2

offset=$1
