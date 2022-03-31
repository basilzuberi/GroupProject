#!/usr/bin/bash

# greeting user
user=$(whoami)
echo "Hello $user :)"

# getting birthday
echo "Please enter your date of birth DDMM (q to exit): "
read daymonth

#loop to reask for input until q is inputted to stop.
while [ "$daymonth" != "q" ]
do
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
    holidates=( 3110 2512 1703 0107 )

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

    # days_offset=$( expr $offset '*' 86400 )

    # offset_days=$( expr $days_offset + $EPOCHSECONDS )

    # echo $offset_days
    # check if number >0 && number <=15
    if [[ $offset -le 15 && $offset_days -gt 0 ]]
    then
        # prints offset DDMM
        offset_days=$(date -d "$1 days" +%d%m)
        echo $offset_days
    fi

    #feature 3

    findHoliday() {
        for i in "${holidates[@]}"
        do

            # checks to see if user birthday is on a holiday
            if [[ $i -eq $1 ]]
            then
                case "$1" in
                    "3110")
                        echo "HAPPY HALLOWEEN!"
                        ;;
                    "2512")
                        echo "MERRY CHRISTMAS!"
                        ;;
                    "1703")
                        echo "HAPPY ST. PATRICK'S DAY!"
                        ;;
                        "0107")
                        echo "HAPPY CANADA DAY!"
                        ;;
                    "*")
                        echo ""
                        ;;
                esac
                exit 0
            fi
        done
    }
    findHoliday $daymonth
    findHoliday $offset_days

    echo "Please enter your date of birth DDMM (q to exit): "
    read daymonth

done
exit 0