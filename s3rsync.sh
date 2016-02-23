 #!/bin/bash
# Script : Mount S3 bucket as a local drive /mnt/s3 and rsync files

bucket="s3-bucket"
destination="/mnt/s3"
backup="/data/"

# mounting S3 bucket for backup as a local drive
s3fs $bucket $destination

# rsync local files to S3 bucket
rsync -avz $backup $destination

# Once rsync finished - send email and unmount the S3 bucket from local system
ls -lh $destination | mail -s "Rsync completed" sysadmin@system.loca
umount $destination
