#!/bin/bash

if [ "$(id -u)" -ne "0" ]; then
  echo "This script must be run as root."
  exit 1
fi

SOURCE="/dev/sda"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BASE_DIR="/mnt/disk_images"
FOLDER_NAME="$BASE_DIR/$DATE"

if [ ! -d "$FOLDER_NAME" ]; then
  echo -e "\nDirectory $FOLDER_NAME does not exist. Creating it..."
  mkdir -p "$FOLDER_NAME"
  echo "Directory $FOLDER_NAME created."
else
  echo -e "\nDirectory $FOLDER_NAME already exists."
fi

DESTINATION="$FOLDER_NAME/backup_$DATE.img"
MD5_FILE="$FOLDER_NAME/md5_$DATE.txt"
SHA256_FILE="$FOLDER_NAME/sha256_$DATE.txt"
SHA512_FILE="$FOLDER_NAME/sha512_$DATE.txt"

echo -e "\nCreating disk image..."
dd if=$SOURCE of=$DESTINATION bs=4M status=progress

echo -e "\nCalculating checksums..."
md5sum $DESTINATION | awk '{print $1 "  " $2}' > $MD5_FILE
sha256sum $DESTINATION | awk '{print $1 "  " $2}' > $SHA256_FILE
sha512sum $DESTINATION | awk '{print $1 "  " $2}' > $SHA512_FILE

echo -e "\nVerifying integrity..."
md5sum -c $MD5_FILE
sha256sum -c $SHA256_FILE
sha512sum -c $SHA512_FILE

echo -e "\nCalculated MD5 checksum:"
cat $MD5_FILE
echo "Calculated SHA256 checksum:"
cat $SHA256_FILE
echo "Calculated SHA512 checksum:"
cat $SHA512_FILE

echo -e "\nOperation completed."
echo "Saved in  $DESTINATION."
