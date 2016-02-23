You will need:

Amazon AWS account
Amazon Access Key and Secret Key
Amazon S3 bucket name
s3fs utility installed and configured on the Debianserver
First we need to install few requirements on the Debian server:

::
 
 su
 apt-get install build-essential libfuse-dev fuse-utils libcurl4-openssl-dev libxml2-dev mime-support
 apt-get update

Second, now you can download the latest build of s3fs from the project link  https://code.google.com/p/s3fs/ , untar and compile.

::
 
 su
 cd Downloads
 wget https://s3fs.googlecode.com/files/s3fs-1.74.tar.gz
 tar xzvf s3fs-1.74.tar.gz
 cd s3fs*
 ./configure
 make
 make install

By now you should have installed the s3fs utility on the system. You can try to run it by typing s3fs you should see message that it is not configured yet.

If installed and not configured – you will see this message

::
 
 s3fs: missing BUCKET argument

Usage: s3fs BUCKET:[PATH] MOUNTPOINT [OPTION]...
Now we will create a local directory that will be mounted to Amazon S3 bucket

::
 
 su
 mkdir /mnt/s3
 chown yourusername:yourusername /mnt/s3

Next step is create a password file with the Amazon keys:

::
 
 su
 echo "ACCESS_KEY_ID:SECRET_ACCESS_KEY" > /etc/passwd-s3fs
 chmod 0600 /etc/passwd-s3fs

This is covering the basic setup, installation and configuration s3fs on the Debian server. Lets try it now.

::

 su
 s3fs bucket-name /mnt/s3
 cd /mnt/s3
 ls -l


::
 
 su
 chmod 700 rsyncs3.sh

----------------------
 
::
 
 su
 crontab -e
 0 0 * * * /path/to/rsyncs3.sh # this runs rsync to s3 every day at midnight
