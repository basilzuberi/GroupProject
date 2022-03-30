search() {
    echo $1
    for item in $1/*
    do
        # echo "TEST $item" 
        if [[ -d $item ]]           # If directory
        then
            search $item
        fi

        if [[ -f $item ]]           # If file
        then
            echo "l"
        fi
    done
}


echo "Doing a search for given files..."
search $PWD
echo "Finished Search."
exit 0