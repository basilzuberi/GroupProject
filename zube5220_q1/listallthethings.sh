files=($@)
file_paths=()

#getting all the files in the directory and subdirectories as their relative paths
getAllFilesPaths() {
    #getting the content of the directory
    long_list=($(ls $1))
    for item in ${long_list[@]}
    do
        item_path="$1$item"
        if [[ -d $item_path ]]           # If directory
        then
            #recursion
            getAllFilesPaths "$item_path/"
        elif [[ -f $item_path ]]           # If file
        then
            file_paths+=( "$item_path" )
        fi
    done
}
#iterating through all the relative paths of "files only" and printing the long list for the path that has the filename appended to it (if nested i.e. parent/{filename}) or filename only (i.e. {filname})
printFileLongList(){
    found=0
    i=0
    for path in ${file_paths[@]}
    do
        find_file=$(echo ${path} | grep -E "(^($1)$)|((\/$1)$)" )
        if [ "$find_file" != "" ]
        then
            response=$(ls -i "${path}")
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

getAllFilesPaths ""

#going through the file provided by the user
for file in ${files[@]}
do
    echo "ls -l for filename: $file"
    printFileLongList $file
    echo ""
done
exit 0