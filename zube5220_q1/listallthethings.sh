files=($@)
file_paths=()

getAllFilesPaths() {
    for item in $1/*
    do
        # echo "TEST $item" 
        if [[ -d $item ]]           # If directory
        then
            getAllFilesPaths $item
        elif [[ -f $item ]]           # If file
        then
            file_paths+=( $item )
        fi
    done
}

printFileLongList(){
    found=0
    i=0
    num_of_file_path=${#file_paths[@]} #https://www.cyberciti.biz/faq/finding-bash-shell-array-length-elements/
    while [ "$found" -eq "0" ] && [ "$i" -lt "$num_of_file_path" ]
    do
        find_file=$(echo ${file_paths[$i]} | grep -E "(\/$1)$" )
        if [ "$find_file" != "" ]
        then
            response=$(ls -l "${file_paths[$i]}")
            echo $response
            found=1
        fi
        i=$(( $i + 1 ))
    done

    if [ "$found" -eq "0" ] 
    then 
        echo "Filename ($1) does not exist in this directory or any subdirectories"
    fi
}

getAllFilesPaths $PWD
for file in ${files[@]}
do
    echo "ls -l for filename: $file"
    printFileLongList $file
    echo ""
done
exit 0