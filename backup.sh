USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
# LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log" # /var/log/shell-script/16-logs.log
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
mkdir -p $LOGS_FOLDER
echo "Script started executed at: $(date)" | tee -a $LOG_FILE

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if not provided consider as 14 days

if [ $USERID -ne 0 ]; then
    echo "ERROR:: Please run this script with root privelege"
    exit 1 # failure is other than 0
fi
USAGE(){
    echo -e "$R USAGE:: sudo sh 24-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS>[optional, default 14 days] $N"
    exit 1
}

#check source and destination are passed or not 
if [ $# -lt 2 ]; then
    USAGE
fi

#check source directory exist

if [ ! -d $1 ]; then
     echo -e "$R Source $SOURCE_DIR does not exist $N"
     exit 1
fi

#check destination directory exist

if [ ! -d $2 ]; then
     echo -e "$R Source $DEST_DIR does not exist $N"
     exit 1
fi

# find the files which are 14 days old

FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

#if the find vaiable is empty or not

if [ ! -z "$FILES" ]; then
    echo "Files Found:$FILES"
    #Timestampis for ZIP file name 2025-09-09-02-06
    TIMESTAMP=$(date +%F-%H-%M)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    echo "ZipFIle name is :$ZIP_FILE_NAME"
    echo $FILES | zip -@ $ZIP_FILE_NAME

else
    echo -e "No files to archive....$Y SKIPPING..$N"
fi